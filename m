Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316098AbSENWcc>; Tue, 14 May 2002 18:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316100AbSENWcb>; Tue, 14 May 2002 18:32:31 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:43758 "HELO
	cuzco.az.mvista.com") by vger.kernel.org with SMTP
	id <S316098AbSENWca>; Tue, 14 May 2002 18:32:30 -0400
From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Date: Tue, 14 May 2002 15:32:30 -0700
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: ip autoconfig skips ipv6 dev initialization
Message-ID: <20020514223230.GL15751@cuzco.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some ipv6 testing here on some nfs-rooted 2.4.18 systems.
I found that ipv6 initialization isn't performed on an ipv4-autoconfigured
network device, leaving it without a link-local address.  It happens
because ip_auto_config() is executed before inet6_init() has a chance
to register to handle NETDEV_UP notifications.  This only occurs when
ipv6 support is compiled into the kernel.

A fix is to do the ipv6 initialization before ipv4 initialization.
The included patch resolved it for me.  Please apply or suggest an
alternative.

Thanks,
-Dale Farnsworth

--- linux.orig/net/Makefile	Tue May 14 12:33:40 2002
+++ linux/net/Makefile	Tue May 14 12:34:35 2002
@@ -15,10 +15,10 @@
 
 
 subdir-$(CONFIG_NET)		+= 802 sched netlink
+subdir-$(CONFIG_IPV6)		+= ipv6
 subdir-$(CONFIG_INET)		+= ipv4
 subdir-$(CONFIG_NETFILTER)	+= ipv4/netfilter
 subdir-$(CONFIG_UNIX)		+= unix
-subdir-$(CONFIG_IPV6)		+= ipv6
 
 ifneq ($(CONFIG_IPV6),n)
 ifneq ($(CONFIG_IPV6),)

