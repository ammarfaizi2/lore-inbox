Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVIWLgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVIWLgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 07:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVIWLgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 07:36:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47621 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750850AbVIWLgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 07:36:11 -0400
Date: Fri, 23 Sep 2005 13:33:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Willy Tarreau <willy@w.ods.org>, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050923113347.GA19516@alpha.home.local>
References: <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331D168.6090604@cosmosbay.com> <20050922124803.GH26520@sunbeam.de.gnumonks.org> <4332AC2E.8000607@cosmosbay.com> <20050923040234.GC595@alpha.home.local> <43338F30.6070601@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43338F30.6070601@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 07:14:24AM +0200, Eric Dumazet wrote:
 
> Even without CMOV support, the suggested patch helps :
> 
> Here is the code generated with gcc-3.4.4  on a pentium4 (i686) for :
> 
> /********************/
> bool1 = ((ip->saddr&ipinfo->smsk.s_addr) != ipinfo->src.s_addr);
> bool1 ^= !!(ipinfo->invflags & IPT_INV_SRCIP);
> 
> bool2 = ((ip->daddr&ipinfo->dmsk.s_addr) != ipinfo->dst.s_addr);
> bool2 ^= !!(ipinfo->invflags & IPT_INV_DSTIP);
> 
> if ((bool1 | bool2) != 0) {
> 
> /********************/

(...)

I totally agree with your demonstration. It would be interesting to compare
she same code on an architecture with more registers (eg: sparc). One of
the reasons of bad optimization of such constructs on x86 seems to be the
lack of registers for the number of variables and intermediate results.
When you write the code like above, you show the workflow to the compiler
(and I often use the same technique).

Regards,
Willy

