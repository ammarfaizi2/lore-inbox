Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272173AbVBFEUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272173AbVBFEUS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbVBFEUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:20:17 -0500
Received: from h80ad26a6.async.vt.edu ([128.173.38.166]:8460 "EHLO
	h80ad26a6.async.vt.edu") by vger.kernel.org with ESMTP
	id S264320AbVBFET5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:19:57 -0500
Message-Id: <200502060419.j164JjCP027883@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01 
In-Reply-To: Your message of "Fri, 04 Feb 2005 11:03:47 +0100."
             <20050204100347.GA13186@elte.hu> 
From: Valdis.Kletnieks@vt.edu
References: <20050204100347.GA13186@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107663585_3521P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 05 Feb 2005 23:19:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107663585_3521P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <27872.1107663584.1@turing-police.cc.vt.edu>

On Fri, 04 Feb 2005 11:03:47 +0100, Ingo Molnar said:
> 
> i have released the -V0.7.38-01 Real-Time Preemption patch, which can be

Building with:

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT_DESKTOP=y
# CONFIG_PREEMPT_RT is not set

  CC      kernel/sched.o
kernel/sched.c:314:1: warning: "_finish_arch_switch" redefined
kernel/sched.c:306:1: warning: this is the location of the previous definition

caused by this part of the patch:

@@ -288,12 +295,20 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)             cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)          (cpu_rq(cpu)->curr)
 
+#ifdef CONFIG_PREEMPT_RT
+# ifdef prepare_arch_switch
+#   error FIXME
+# endif        
+#else  
+# define _finish_arch_switch finish_arch_switch
+#endif 
+       
 /*     
  * Default context-switch locking:
  */    
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(rq, next) do { } while (0)
-# define finish_arch_switch(rq, next)  spin_unlock_irq(&(rq)->lock)
+# define _finish_arch_switch(rq, next) spin_unlock(&(rq)->lock)
 # define task_running(rq, p)           ((rq)->curr == (p))
 #endif
  

What was intended for non-RT builds?

--==_Exmh_1107663585_3521P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCBZrhcC3lWbTT17ARAuXKAKDZokwOwmB7YzNxSh8+pJKBV0dxVQCeJeLK
GA5sSWsJ6bk8hkUx6S00QQg=
=UGjb
-----END PGP SIGNATURE-----

--==_Exmh_1107663585_3521P--
