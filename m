Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSIADOP>; Sat, 31 Aug 2002 23:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSIADOP>; Sat, 31 Aug 2002 23:14:15 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:40721 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S313070AbSIADOO>; Sat, 31 Aug 2002 23:14:14 -0400
Date: Sun, 1 Sep 2002 13:18:32 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] Re: 2.5.32 : net/ipv4/netfilter/ipfwadm_core.c compile error
In-Reply-To: <Pine.LNX.4.33.0208300801120.27846-100000@primetime>
Message-ID: <Mutt.LNX.4.44.0209011232410.14016-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2002, Frank Davis wrote:

> Hello all, 
>   While 'make modules', I received the following error.
> 
> Regards,
> Frank
> 
> ipfwadm_core.c: In function `ip_fw_chk':
> ipfwadm_core.c:450: structure has no member named `read_locked_map'
> ipfwadm_core.c:450: structure has no member named `write_locked_map'

Please see the fix below.  (The problem only shows up when netfilter 
debugging is enabled).


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.33.w1/net/ipv4/netfilter/ipfwadm_core.c linux-2.5.33.w1-ipfwadm/net/ipv4/netfilter/ipfwadm_core.c
--- linux-2.5.33.w1/net/ipv4/netfilter/ipfwadm_core.c	Wed Aug 28 13:24:30 2002
+++ linux-2.5.33.w1-ipfwadm/net/ipv4/netfilter/ipfwadm_core.c	Sun Sep  1 12:16:16 2002
@@ -156,7 +156,7 @@
 #define dprint_ip(a)
 #endif
 
-static rwlock_t ip_fw_lock = RW_LOCK_UNLOCKED;
+static DECLARE_RWLOCK(ip_fw_lock);
 
 #if defined(CONFIG_IP_ACCT) || defined(CONFIG_IP_FIREWALL)
 


