Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRGKSBR>; Wed, 11 Jul 2001 14:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbRGKSA5>; Wed, 11 Jul 2001 14:00:57 -0400
Received: from dsl-209-162-208-225.easystreet.com ([209.162.208.225]:38166
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261198AbRGKSAx>; Wed, 11 Jul 2001 14:00:53 -0400
Message-ID: <3B4C9492.7070201@PolyServe.com>
Date: Wed, 11 Jul 2001 11:01:54 -0700
From: David Chamness <chamness@PolyServe.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.6 i686; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] minor change to netsyms.c
Content-Type: multipart/mixed;
 boundary="------------050800000100060308050309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050800000100060308050309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently, inet_stream_ops only gets exported if experimental code (IPV6 
module or KHTTPD) is configured.  This patch makes the exporting of 
inet_stream_ops the same as inet_dgram_ops, whenever CONFIG_INET is 
defined.  I have written a module that needs both these symbols 
exported, and it would be much cleaner if they both were exported in a 
consistent manner.

Thanks,
David Chamness
PolyServe, Inc.



--------------050800000100060308050309
Content-Type: text/plain;
 name="patch-netsyms.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-netsyms.c"

--- v2.4.6/linux/net/netsyms.c	Mon Jul  9 11:18:56 2001
+++ linux/net/netsyms.c	Mon Jul  9 11:17:05 2001
@@ -251,6 +251,7 @@
 EXPORT_SYMBOL(ip_mc_inc_group);
 EXPORT_SYMBOL(ip_mc_dec_group);
 EXPORT_SYMBOL(ip_finish_output);
+EXPORT_SYMBOL(inet_stream_ops);
 EXPORT_SYMBOL(inet_dgram_ops);
 EXPORT_SYMBOL(ip_cmsg_recv);
 EXPORT_SYMBOL(inet_addr_type); 
@@ -281,7 +282,6 @@
 #endif
 #if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_KHTTPD) || defined (CONFIG_KHTTPD_MODULE)
 /* inet functions common to v4 and v6 */
-EXPORT_SYMBOL(inet_stream_ops);
 EXPORT_SYMBOL(inet_release);
 EXPORT_SYMBOL(inet_stream_connect);
 EXPORT_SYMBOL(inet_dgram_connect);

--------------050800000100060308050309--

