Return-Path: <linux-kernel-owner+w=401wt.eu-S932734AbXAJH46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbXAJH46 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 02:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbXAJH46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 02:56:58 -0500
Received: from stinky.trash.net ([213.144.137.162]:61371 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932734AbXAJH45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 02:56:57 -0500
Message-ID: <45A49C47.6080407@trash.net>
Date: Wed, 10 Jan 2007 08:56:55 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Tomasz Kvarsin <kvarsin@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, bunk@stusta.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.20-rc4: regression: iptables failed to load rules
References: <5157576d0701082329o1875911j20f6679e2d35bb17@mail.gmail.com> <Pine.LNX.4.64.0701090929160.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701090929160.3594@woody.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 9 Jan 2007, Tomasz Kvarsin wrote:
> 
>>During boot into 2.6.20-rc4 iptables says
>>iptables-restore: line 15 failed.
>>And works fine with my default kernel: 2.6.18.x
> 
> 
> I bet you enabled the new transport-agnostic netfilter, and didn't enable 
> some of the actual rules needed for your iptables setup (they have new 
> config names).
> 
> I do think that the netfilter team has been very irritating in changing 
> the config names, even if it "is logical". 
> 
> Somebody should stop the madness, and tell people what config options they 
> need for a regular iptables setup like this. Rather than say "just compile 
> everything". There's about a million different filters, and they all 
> depend on one infrastructure or another.
> 
> And then the networking people should F*NG STOP that config name changing 
> madness! The config names should match the _usage_, not some 
> implementation detail. And failing that, leave the config options named 
> something illogical, as long as people don't have to change their config 
> file all the time and answer millions of questions that they don't care 
> about!


In the x_tables case it really caused a lot of unnecessary confusion,
the recent connection tracking changes however needed new config
options since we're keeping the old implementation around for a few more
releases. Unfortunately when switching between the two implementations,
Kconfig deselects all options depending on either one, even though the
dependencies are still fulfilled (f.e. NETFILTER_XT_MATCH_CONNTRACK:
depends on IP_NF_CONNTRACK || NF_CONNTRACK), which means you have
to select all those options again.

It probably won't be necessary anymore to make changes like this in
the future, but in case it is I'll make sure to at least provide
compatibility options for a few releases.

