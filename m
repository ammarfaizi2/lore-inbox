Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbSLTFvP>; Fri, 20 Dec 2002 00:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbSLTFvP>; Fri, 20 Dec 2002 00:51:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267719AbSLTFvO>; Fri, 20 Dec 2002 00:51:14 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PATCH 2.5.x disable BAR when sizing
Date: Fri, 20 Dec 2002 05:57:23 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <atubg3$699$1@penguin.transmeta.com>
References: <20021219213712.0518B12CB2@debian.cup.hp.com>
X-Trace: palladium.transmeta.com 1040363947 14707 127.0.0.1 (20 Dec 2002 05:59:07 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Dec 2002 05:59:07 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021219213712.0518B12CB2@debian.cup.hp.com>,
Grant Grundler <grundler@cup.hp.com> wrote:
>
>In April 2002, turukawa@icc.melco.co.jp sent a 2.4.x patch to disable
>BARs while the BARs were being sized.  I've "forward ported" this patch
>to 2.5.x (appended).  turukawa's excellent problem description and
>original posting are here:
>	https://lists.linuxia64.org/archives//linux-ia64/2002-April/003302.html
>
>David Mosberger agrees this is an "obvious fix".

It is NOT an "obvious fix".

It breaks stuff horribly. When you turn off the MEM bit on the
northbridge, there are northbridges that will stop forwarding RAM<->PCI.

>We've been using this in the ia64 2.4 code stream since about August.

And it's CRAP.

DO NOT DO THIS. It locks up some machines at bootup. Hard. Total bus
lockup if you have legacy USB enabled (or anything else that does DMA,
for that matter) at the same time as probing the northbridge with this.

Trust me.  If you have some new silly ia64-specific bug, the fix is
_not_ to break real and existing hardware out there. 

We've had this "obviously correct" patch floating around several times,
and it even made it into the kernel at least once. It was reverted
because it is WRONG.

		Linus
