Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSBDWdf>; Mon, 4 Feb 2002 17:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSBDWdZ>; Mon, 4 Feb 2002 17:33:25 -0500
Received: from stingr.net ([212.193.33.37]:25351 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id <S289216AbSBDWdH>;
	Mon, 4 Feb 2002 17:33:07 -0500
Date: Tue, 5 Feb 2002 01:32:58 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre8
Message-ID: <20020205013258.H349@stingr.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Marcelo Tosatti:
> 
> Hi, 
> 
> No more big patches for 2.4.18, please... We are getting close to the -rc
> stage.

We all getting close to another bug. Maybe.
Beat me if I am wrong, but netfilter_ipv4.h update (route_me_harder) break
userland iptables compile process.

I am now worked around with following, but it is completely untested, also
sent to harald welte and I suggest further comments from him - fix the
userspace, kernel, or ...

--- linux/include/linux/netfilter_ipv4.h	Tue Feb  5 01:06:27 2002
+++ linux-kg/include/linux/netfilter_ipv4.h	Tue Feb  5 01:12:34 2002
@@ -73,6 +73,7 @@
 /* 2.4 firewalling went 64 through 67. */
 #define SO_ORIGINAL_DST 80
 
+#ifdef __KERNEL__
 
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue 
  *
@@ -149,5 +150,7 @@
 
 	return err;
 }
+
+#endif
 
 #endif /*__LINUX_IP_NETFILTER_H*/

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
