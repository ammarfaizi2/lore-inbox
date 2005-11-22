Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVKVVNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVKVVNs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVKVVKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965194AbVKVVJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:09:52 -0500
Date: Tue, 22 Nov 2005 13:08:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>
Subject: [patch 15/23] [PATCH] [NETFILTER] ip_conntrack: fix ftp/irc/tftp helpers on ports >= 32768
Message-ID: <20051122210817.GP28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ip_conntrack-fix-ftp-irc-tftp-helpers-on-large-ports.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Since we've converted the ftp/irc/tftp helpers to use the new
module_parm_array() some time ago, we ware accidentially using signed data
types - thus preventing those modules from being used on ports >= 32768.

This patch fixes it by using 'ushort' module parameters.

Thanks to Jan Nijs for reporting this bug.

Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_conntrack_ftp.c  |    4 ++--
 net/ipv4/netfilter/ip_conntrack_irc.c  |    4 ++--
 net/ipv4/netfilter/ip_conntrack_tftp.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_ftp.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_ftp.c
@@ -29,9 +29,9 @@ static char *ftp_buffer;
 static DEFINE_SPINLOCK(ip_ftp_lock);
 
 #define MAX_PORTS 8
-static short ports[MAX_PORTS];
+static unsigned short ports[MAX_PORTS];
 static int ports_c;
-module_param_array(ports, short, &ports_c, 0400);
+module_param_array(ports, ushort, &ports_c, 0400);
 
 static int loose;
 module_param(loose, int, 0600);
--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_irc.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_irc.c
@@ -34,7 +34,7 @@
 #include <linux/moduleparam.h>
 
 #define MAX_PORTS 8
-static short ports[MAX_PORTS];
+static unsigned short ports[MAX_PORTS];
 static int ports_c;
 static int max_dcc_channels = 8;
 static unsigned int dcc_timeout = 300;
@@ -52,7 +52,7 @@ EXPORT_SYMBOL_GPL(ip_nat_irc_hook);
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("IRC (DCC) connection tracking helper");
 MODULE_LICENSE("GPL");
-module_param_array(ports, short, &ports_c, 0400);
+module_param_array(ports, ushort, &ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of IRC servers");
 module_param(max_dcc_channels, int, 0400);
 MODULE_PARM_DESC(max_dcc_channels, "max number of expected DCC channels per IRC session");
--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_tftp.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_tftp.c
@@ -26,9 +26,9 @@ MODULE_DESCRIPTION("tftp connection trac
 MODULE_LICENSE("GPL");
 
 #define MAX_PORTS 8
-static short ports[MAX_PORTS];
+static unsigned short ports[MAX_PORTS];
 static int ports_c;
-module_param_array(ports, short, &ports_c, 0400);
+module_param_array(ports, ushort, &ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of tftp servers");
 
 #if 0

--
