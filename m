Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSFFCHE>; Wed, 5 Jun 2002 22:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSFFCHD>; Wed, 5 Jun 2002 22:07:03 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:61945 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316666AbSFFCHD>; Wed, 5 Jun 2002 22:07:03 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15614.50117.861698.205543@wombat.chubb.wattle.id.au>
Date: Thu, 6 Jun 2002 12:07:01 +1000
To: linux-kernel@vger.kernel.org, rml@tech9.net, trivial@rustcorp.com.au
Subject: [PATCH] Fix sys_capset in 2.5.20+patches...
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	The current head-of-bk-tree 2.5 kernel breaks capset() (and so
named, for one, won't run).  SYS_setcap() will *always* return -EINVAL
with the current tree.



--- /tmp/geta315	Thu Jun  6 12:05:43 2002
+++ linux-2.5-import/kernel/capability.c	Thu Jun  6 12:05:19 2002
@@ -134,10 +134,11 @@
      if (get_user(version, &header->version))
 	     return -EFAULT; 
 
-     if (version != _LINUX_CAPABILITY_VERSION)
+     if (version != _LINUX_CAPABILITY_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
 		     return -EFAULT; 
              return -EINVAL;
+     }
 
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 


--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
