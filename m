Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318088AbSGMDTG>; Fri, 12 Jul 2002 23:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318089AbSGMDTF>; Fri, 12 Jul 2002 23:19:05 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:44769 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318088AbSGMDTC>;
	Fri, 12 Jul 2002 23:19:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Saurabh Desai" <sdesai@us.ibm.com>
Cc: torvalds@transmeta.com, bcrl@redhat.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: A fix for futex patch 
In-reply-to: Your message of "Fri, 12 Jul 2002 11:08:47 EST."
             <OFE0524400.39220EE3-ON85256BF4.0057F3F7@raleigh.ibm.com> 
Date: Sat, 13 Jul 2002 13:26:11 +1000
Message-Id: <20020713032213.CD682422D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <OFE0524400.39220EE3-ON85256BF4.0057F3F7@raleigh.ibm.com> you write:
> I looked in latest 2.5.25 futex.c and at line # 278, the f_owner.pid is
> back to "current->pid".
> Last month, I'd send you this fix to work correctly with cloned task.
> I thought at one point you had changed this to "current->tgid", and now
> it's back to pid.
> The pid should be tgid to work for all cases.

Oops.  Good catch.  My mistake.

Linus, "getpid()" returns "tgid" not "pid", so this is correct.

Thanks!
Rusty.

diff -urN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/kernel/futex.c working-2.5.25-futex/kernel/futex.c
--- linux-2.5.25/kernel/futex.c	Fri Jun 21 09:41:56 2002
+++ working-2.5.25-futex/kernel/futex.c	Sat Jul 13 13:24:43 2002
@@ -275,7 +275,7 @@
 	filp->f_dentry = dget(futex_dentry);
 
 	if (signal) {
-		filp->f_owner.pid = current->pid;
+		filp->f_owner.pid = current->tgid;
 		filp->f_owner.uid = current->uid;
 		filp->f_owner.euid = current->euid;
 		filp->f_owner.signum = signal;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
