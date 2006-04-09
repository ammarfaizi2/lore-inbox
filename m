Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWDIHnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWDIHnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 03:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDIHnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 03:43:17 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:23943 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1750705AbWDIHnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 03:43:17 -0400
Date: Sun, 9 Apr 2006 10:43:13 +0300
From: Ville Herva <vherva@vianova.fi>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org,
       davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
Message-ID: <20060409074313.GZ15954@vianova.fi>
Reply-To: vherva@vianova.fi
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44388908.6070602@trash.net>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 06:09:44AM +0200, you [Patrick McHardy] wrote:
> Ville Herva wrote:
> > I upgraded from 2.6.15-rc7 to 2.6.17-rc1. rc1 seems nice other than that
> > iptables stopped working:
> > 
> >  failed iptables v1.3.5: can't initialize iptables table filter: iptables
> >  who? (do you need to insmod?) 
> >  Perhaps iptables or your kernel needs to be upgraded.
> > 
> > iptables is compiled in the kernel, not a module:
> >  CONFIG_NETFILTER=y
> > 
> > I can even do "modprobe iptable_nat" successfully (iptable_nat is module),
> > but iptables refuses to work. iptables is of version iptables-1.3.5-1.2. 
> > 
> > The kernel config is copied with make oldconfig from 2.6.15-rc7 (which
> > worked), not much else has changed. I just booted back to 2.6.15-rc7 and
> > verified it works. Any ideas?
> 
> Most likely you didn't enable the new xtables options. Please post your
> full config.

The full .config is here
 http://www.iki.fi/v/tmp/2.6.17-rc1.config

I indeed do not have xfilter enabled (I was unaware that such thing had been
introduced :):
--8<-----------------------------------------------------------------------
...
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_NETBIOS_NS is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_H323 is not set
# CONFIG_IP_NF_QUEUE is not set
...
--8<-----------------------------------------------------------------------

I'll try building a new kernel with CONFIG_NETFILTER_XTABLES enabled and
report back. Thanks!


-- v -- 

v@iki.fi

