Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDIOoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDIOoW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 10:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWDIOoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 10:44:22 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:6544 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1750741AbWDIOoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 10:44:22 -0400
Date: Sun, 9 Apr 2006 17:44:16 +0300
From: Ville Herva <vherva@vianova.fi>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org,
       davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
Message-ID: <20060409144416.GO1686@vianova.fi>
Reply-To: vherva@vianova.fi
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net> <20060409074313.GZ15954@vianova.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060409074313.GZ15954@vianova.fi>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 10:43:13AM +0300, you [Ville Herva] wrote:
> > 
> > Most likely you didn't enable the new xtables options. Please post your
> > full config.
> 
> The full .config is here
>  http://www.iki.fi/v/tmp/2.6.17-rc1.config

Now "iptables -L" works, but I still get

> iptables -A INPUT         -p tcp -d 0.0.0.0/0   --dport  http -m state --state NEW,ESTABLISHED -j ACCEPT
iptables: Unknown error 4294967295

from about half of the iptables rules.
My current config is here:

http://www.iki.fi/v/tmp/2.6.17-rc1.config.new

The following modules are loaded:
iptable_nat             6948  1 
ip_nat                 14860  1 iptable_nat
ip_conntrack           43188  2 iptable_nat,ip_nat
ipt_REJECT              4704  0 
iptable_filter          2784  0 

and 
CONFIG_NETFILTER=y
CONFIG_NETFILTER_XTABLES=y
CONFIG_IP_NF_IPTABLES=y
are compiled in statically.

I just realized 
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
should probably be set. I'm building a new kernel now...


-- v -- 

v@iki.fi

