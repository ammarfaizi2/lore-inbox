Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSIIAMg>; Sun, 8 Sep 2002 20:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSIIAMg>; Sun, 8 Sep 2002 20:12:36 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:57054 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315690AbSIIAMf>; Sun, 8 Sep 2002 20:12:35 -0400
Message-Id: <5.1.0.14.2.20020909011504.00b1adf0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 09 Sep 2002 01:17:26 +0100
To: mingo@elte.hu, torvalds@transmeta.com
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: pinpointed: PANIC caused by dequeue_signal() in current
  Linus BK tree
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020909001700.03fdee00@pop.cus.cam.ac.uk>
References: <5.1.0.14.2.20020908234145.03fdaec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Andrew Morton's suggestion I tried with preempt disabled. That still 
gives the same result.

I then also tried to compile the kernel for UP and it still gives the same 
result.

Anton

At 00:21 09/09/02, Anton Altaparmakov wrote:
>Hi,
>
>I had a look and the panic actually happens in collect_signal() in here:
>
>static inline int collect_signal(int sig, struct sigpending *list, 
>siginfo_t *info)
>{
>         if (sigismember(&list->signal, sig)) {
>                 /* Collect the siginfo appropriate to this signal.  */
>                 struct sigqueue *q, **pp;
>                 pp = &list->head;
>                 while ((q = *pp) != NULL) {
>q becomes 0x5a5a5a5a  ^^^^^^^^^
>                         if (q->info.si_signo == sig)
>0x5a5a5a5a is dereferenced ^^^^^^^^^^^^^^^^
>                                 goto found_it;
>                         pp = &q->next;
>                 }
>
>Hope this helps.
>
>Best regards,
>
>         Anton

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

