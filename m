Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRANMfC>; Sun, 14 Jan 2001 07:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132628AbRANMex>; Sun, 14 Jan 2001 07:34:53 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:3068 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S132564AbRANMeo>;
	Sun, 14 Jan 2001 07:34:44 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Reuben Farrelly <reuben@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols 
In-Reply-To: Your message of "Fri, 05 Jan 2001 04:23:37 +1100."
             <5.0.2.1.2.20010105042217.0287d6f0@mail.reub.net> 
Date: Sun, 14 Jan 2001 23:34:28 +1100
Message-Id: <E14HmMg-0002TB-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.0.2.1.2.20010105042217.0287d6f0@mail.reub.net> you write:
> Hi Rusty,
> 
> Some more unresolved symbols for you from the latest prerelease linux kernel:

Does this fix it?  If so I'll send to Linus...

Cheers,
Rusty.
--
http://linux.conf.au The Linux conference Australia needed.

diff -urN -I \$.*\$ -X /tmp/kerndiff.ObwPZl --minimal linux-2.4.0-official/net/ipv4/netfilter/Config.in working-2.4.0/net/ipv4/netfilter/Config.in
--- linux-2.4.0-official/net/ipv4/netfilter/Config.in	Tue Mar 28 04:35:56 2000
+++ working-2.4.0/net/ipv4/netfilter/Config.in	Sun Jan  7 16:48:59 2001
@@ -37,11 +37,20 @@
   fi
 
   if [ "$CONFIG_IP_NF_CONNTRACK" != "n" ]; then
-    dep_tristate '  Full NAT' CONFIG_IP_NF_NAT $CONFIG_IP_NF_IPTABLES 
+    dep_tristate '  Full NAT' CONFIG_IP_NF_NAT $CONFIG_IP_NF_IPTABLES $CONFIG_IP_NF_CONNTRACK
     if [ "$CONFIG_IP_NF_NAT" != "n" ]; then
       define_bool CONFIG_IP_NF_NAT_NEEDED y
       dep_tristate '    MASQUERADE target support' CONFIG_IP_NF_TARGET_MASQUERADE $CONFIG_IP_NF_NAT
       dep_tristate '    REDIRECT target support' CONFIG_IP_NF_TARGET_REDIRECT $CONFIG_IP_NF_NAT
+      # If they want FTP, set to $CONFIG_IP_NF_NAT (m or y), 
+      # or $CONFIG_IP_NF_FTP (m or y), whichever is weaker.  Argh.
+      if [ "$CONFIG_IP_NF_FTP" = "m" ]; then
+	define_tristate CONFIG_IP_NF_NAT_FTP m
+      else
+	if [ "$CONFIG_IP_NF_FTP" = "y" ]; then
+	  define_tristate CONFIG_IP_NF_NAT_FTP $CONFIG_IP_NF_NAT
+	fi
+      fi
     fi
   fi
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.ObwPZl --minimal linux-2.4.0-official/net/ipv4/netfilter/Makefile working-2.4.0/net/ipv4/netfilter/Makefile
--- linux-2.4.0-official/net/ipv4/netfilter/Makefile	Sat Dec 30 09:07:24 2000
+++ working-2.4.0/net/ipv4/netfilter/Makefile	Sat Jan  6 13:36:25 2001
@@ -35,7 +35,7 @@
 obj-$(CONFIG_IP_NF_FTP) += ip_conntrack_ftp.o
 
 # NAT helpers 
-obj-$(CONFIG_IP_NF_FTP) += ip_nat_ftp.o
+obj-$(CONFIG_IP_NF_NAT_FTP) += ip_nat_ftp.o
 
 # generic IP tables 
 obj-$(CONFIG_IP_NF_IPTABLES) += ip_tables.o
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
