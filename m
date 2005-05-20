Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVETKlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVETKlC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 06:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVETKlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 06:41:02 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:44719 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261401AbVETKkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 06:40:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Date: Fri, 20 May 2005 20:40:48 +1000
User-Agent: KMail/1.8
Cc: chen Shang <shangcs@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, rml@tech9.net,
       Andrew Morton <akpm@osdl.org>
References: <855e4e4605051909561f47351@mail.gmail.com> <855e4e46050520001215be7cde@mail.gmail.com> <20050520094909.GA16923@elte.hu>
In-Reply-To: <20050520094909.GA16923@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7220697.WPHIdGkbkj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505202040.51329.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7220697.WPHIdGkbkj
Content-Type: multipart/mixed;
  boundary="Boundary-01=_x6bjC+hcCYJVmxh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_x6bjC+hcCYJVmxh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 20 May 2005 19:49, Ingo Molnar wrote:
> * chen Shang <shangcs@gmail.com> wrote:
> > I minimized my patch and against to 2.6.12-rc4 this time, see below.
>
> looks good - i've done some small style/whitespace cleanups and renamed
> prio to old_prio, patch against -rc4 below.

We should inline requeue_task as well.

Con
----

--Boundary-01=_x6bjC+hcCYJVmxh
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="inline_requeue_task.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="inline_requeue_task.diff"

Putting requeue_task into the common fast path code in schedule() will
benefit generically from inlining the requeue_task function.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc4/kernel/sched.c
===================================================================
--- linux-2.6.12-rc4.orig/kernel/sched.c	2005-05-20 20:28:29.000000000 +1000
+++ linux-2.6.12-rc4/kernel/sched.c	2005-05-20 20:28:55.000000000 +1000
@@ -560,7 +560,7 @@ static void enqueue_task(struct task_str
  * Put task to the end of the run list without the overhead of dequeue
  * followed by enqueue.
  */
-static void requeue_task(struct task_struct *p, prio_array_t *array)
+static inline void requeue_task(struct task_struct *p, prio_array_t *array)
 {
 	list_move_tail(&p->run_list, array->queue + p->prio);
 }

--Boundary-01=_x6bjC+hcCYJVmxh--

--nextPart7220697.WPHIdGkbkj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCjb6zZUg7+tp6mRURAokoAJ4r1CZl+0Uspjc9rYKCYkp05lPSFQCffTMa
9uIZbJWg3wht/KaxwYZAD+E=
=hQSk
-----END PGP SIGNATURE-----

--nextPart7220697.WPHIdGkbkj--
