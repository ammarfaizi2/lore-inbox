Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSINSOM>; Sat, 14 Sep 2002 14:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSINSOM>; Sat, 14 Sep 2002 14:14:12 -0400
Received: from s2.org ([195.197.64.39]:38822 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S317398AbSINSOK>;
	Sat, 14 Sep 2002 14:14:10 -0400
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.20-pre7] net/ipv4/netfilter/ip_conntrack_ftp and _irc to export objs
References: <m3vg58qwz1.fsf@kalahari.s2.org> <1032027105.29595.129.camel@tux>
From: Jarno Paananen <jpaana@s2.org>
Date: 14 Sep 2002 21:19:03 +0300
In-Reply-To: <1032027105.29595.129.camel@tux>
Message-ID: <m3n0qkqvs8.fsf@kalahari.s2.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> writes:

| On Sat, 2002-09-14 at 19:53, Jarno Paananen wrote:
| > Hi,
| > 
| > the two modules mentioned export symbols but are not mentioned in
| > export-objs in Makefile and thus give errors. Patch attached.
| > 
| > // Jarno
| > 
| > --- net/ipv4/netfilter/Makefile.bak	2002-09-14 19:50:38.000000000 +0300
| > +++ net/ipv4/netfilter/Makefile	2002-09-14 19:51:28.000000000 +0300
| > @@ -9,7 +9,7 @@
| >  
| >  O_TARGET := netfilter.o
| >  
| > -export-objs = ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o ip_tables.o arp_tables.o
| > +export-objs = ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o ip_tables.o arp_tables.o ip_conntrack_ftp.o ip_conntrack_irc.o
| >  
| >  # Multipart objects.
| >  list-multi		:= ip_conntrack.o iptable_nat.o ipfwadm.o ipchains.o
| 
| Did you see this part starting at row 34?
| 
| # connection tracking helpers
| obj-$(CONFIG_IP_NF_FTP) += ip_conntrack_ftp.o
| ifdef CONFIG_IP_NF_NAT_FTP
|         export-objs += ip_conntrack_ftp.o
| endif
| 
| obj-$(CONFIG_IP_NF_IRC) += ip_conntrack_irc.o
| ifdef CONFIG_IP_NF_NAT_IRC
|         export-objs += ip_conntrack_irc.o
| endif
| 
| but maybe the ifdefs shouldn't use the NAT define...
| I don't think I've compiled without NAT support...
|  
| -- 
| /Martin
| 
| Never argue with an idiot. They drag you down to their level, then beat
| you with experience.

Hm, didn't notice those, sorry.

It seems the condition for the actual export is different than the
Makefile. In ip_conntrack_ftp.c for example the export is done:

#ifdef CONFIG_IP_NF_NAT_NEEDED
EXPORT_SYMBOL(ip_ftp_lock);
#endif

and in Makefile:

ifdef CONFIG_IP_NF_NAT_FTP
        export-objs += ip_conntrack_ftp.o
endif

For some reason these didn't match with my .config, relevant part attached.

// Jarno

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
# CONFIG_IP_NF_MATCH_HELPER is not set
# CONFIG_IP_NF_MATCH_STATE is not set
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
# CONFIG_IP6_NF_MATCH_OWNER is not set
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_LENGTH=m
# CONFIG_IP6_NF_MATCH_EUI64 is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

