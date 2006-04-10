Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWDJKEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWDJKEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWDJKEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:04:35 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:23210 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751115AbWDJKEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:04:34 -0400
Date: Mon, 10 Apr 2006 18:01:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 2/3] coredump: shutdown current process first
Message-ID: <20060410140131.GB85@oleg>
References: <20060409001127.GA101@oleg> <20060410070840.26AE41809D1@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410070840.26AE41809D1@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Roland McGrath wrote:
>
> I would be inclined to restructure the inner loop something like this:
> 
> 		p = g;
> 		while (unlikely(p->mm == NULL)) {
> 			p = next_thread(p);
> 			if (p == g)
> 				break;
> 		}
> 		if (p->mm == mm) {
> 			/*
> 			 * p->sighand can't disappear, but
> 			 * may be changed by de_thread()
> 			 */
> 			lock_task_sighand(p, &flags);
> 			zap_process(p);
> 			unlock_task_sighand(p, &flags);
> 		}

Yes, I agree, this is much more understandable.

Oleg.

