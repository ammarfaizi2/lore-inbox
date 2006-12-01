Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162229AbWLAXSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162229AbWLAXSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162225AbWLAXSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:18:53 -0500
Received: from stinky.trash.net ([213.144.137.162]:13265 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1162223AbWLAXSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:18:52 -0500
Message-ID: <4570B912.6060105@trash.net>
Date: Sat, 02 Dec 2006 00:21:54 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Adrian Bunk <bunk@stusta.de>, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [2.6 patch] remove ip{,6}_queue
References: <20061201205954.GH11084@stusta.de>
In-Reply-To: <20061201205954.GH11084@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020404040304010408040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020404040304010408040009
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> This patch removes ip{,6}_queue that were scheduled for removal
> in mid-2005.

Thanks for the reminder, I forgot to remove the feature-removal-schedule
entry last time you asked.

We really can't remove ip_queue. Many users use this, there is no binary
compatible interface and even the compat replacement for the originally
statically linked library doesn't work. There is also no real necessity
to remove the code, so the feature-removal-schedule entry should be
removed instead.

Dave, please apply this patch. Thanks.


--------------020404040304010408040009
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b3949cd..8244716 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -70,18 +70,6 @@ Who:	Dominik Brodowski <linux@brodo.de>
 
 ---------------------------
 
-What:	ip_queue and ip6_queue (old ipv4-only and ipv6-only netfilter queue)
-When:	December 2005
-Why:	This interface has been obsoleted by the new layer3-independent
-	"nfnetlink_queue".  The Kernel interface is compatible, so the old
-	ip[6]tables "QUEUE" targets still work and will transparently handle
-	all packets into nfnetlink queue number 0.  Userspace users will have
-	to link against API-compatible library on top of libnfnetlink_queue 
-	instead of the current 'libipq'.
-Who:	Harald Welte <laforge@netfilter.org>
-
----------------------------
-
 What:	remove EXPORT_SYMBOL(kernel_thread)
 When:	August 2006
 Files:	arch/*/kernel/*_ksyms.c

--------------020404040304010408040009--
