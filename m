Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266911AbUFZBNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266911AbUFZBNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUFZBNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:13:22 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:37768 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266911AbUFZBNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:13:12 -0400
Message-ID: <40DCCD9C.9020402@kolivas.org>
Date: Sat, 26 Jun 2004 11:13:00 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Drzewiecki <z@drze.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Staircase v7.4 question.
References: <Pine.LNX.4.44.0406251410190.13512-100000@truch.net>
In-Reply-To: <Pine.LNX.4.44.0406251410190.13512-100000@truch.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Drzewiecki wrote:
| Hi Con,
|  Wonderful job on the scheduler! I really like the simplicity of
staircase
| vs mainline, and am very happy with its behaviour.
| I was hand-applying the patch from 7.3 to 7.4, and 'enqueue_task' seemed
| inconsistant from your description:
|
| 	"Preempted tasks [...] will go ahead of other tasks [...]"
|
| The code is:
|
| 	static void enqueue_task(struct task_struct *p, runqueue_t *rq)
| 	{
| 		if (rq->curr->flags & PF_PREEMPTED) {
| 			rq->curr->flags &= ~PF_PREEMPTED;
| 			list_add(&p->run_list, rq->queue + p->prio);
| 		} else
| 			list_add_tail(&p->run_list, rq->queue + p->prio);
| 		__set_bit(p->prio, rq->bitmap);
| 	}
|
| This would insert other tasks in front of a task which was just preempted.
| Shouldn't the code be:
|
| 		if (p->flags & PF_PREEMPTED) {
| 			p->flags &= ~PF_PREEMPTED;
| 			....

Eeek!

Indeed. Brain fart. Looks like I introduced a couple of bugs here after
all :P

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3M2bZUg7+tp6mRURAmmCAJwKw7GnQ73CMgj8k6a5dmbpRKwN3QCeMDQ9
dxSUhYXd2yj2XxygEc4p2Vg=
=/APw
-----END PGP SIGNATURE-----
