Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSIHXQ0>; Sun, 8 Sep 2002 19:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSIHXQ0>; Sun, 8 Sep 2002 19:16:26 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:63708 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315540AbSIHXQZ>; Sun, 8 Sep 2002 19:16:25 -0400
Message-Id: <5.1.0.14.2.20020909001700.03fdee00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 09 Sep 2002 00:21:10 +0100
To: mingo@elte.hu, torvalds@transmeta.com
From: Anton Altaparmakov <aia21@cantab.net>
Subject: pinpointed: PANIC caused by dequeue_signal() in current Linus
  BK tree
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020908234145.03fdaec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a look and the panic actually happens in collect_signal() in here:

static inline int collect_signal(int sig, struct sigpending *list, 
siginfo_t *info)
{
         if (sigismember(&list->signal, sig)) {
                 /* Collect the siginfo appropriate to this signal.  */
                 struct sigqueue *q, **pp;
                 pp = &list->head;
                 while ((q = *pp) != NULL) {
q becomes 0x5a5a5a5a  ^^^^^^^^^
                         if (q->info.si_signo == sig)
0x5a5a5a5a is dereferenced ^^^^^^^^^^^^^^^^
                                 goto found_it;
                         pp = &q->next;
                 }

Hope this helps.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

