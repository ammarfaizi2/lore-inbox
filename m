Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVIWEFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVIWEFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 00:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVIWEFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 00:05:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:37381 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751282AbVIWEFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 00:05:06 -0400
Date: Fri, 23 Sep 2005 06:02:34 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050923040234.GC595@alpha.home.local>
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331D168.6090604@cosmosbay.com> <20050922124803.GH26520@sunbeam.de.gnumonks.org> <4332AC2E.8000607@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332AC2E.8000607@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:05:50PM +0200, Eric Dumazet wrote:
(...) 
> It was necessary to get the best code with gcc-3.4.4 on i386 and 
> gcc-4.0.1 on x86_64
> 
> For example :
> 
> bool1 = FWINV(ret != 0, IPT_INV_VIA_OUT);
> if (bool1) {
> 
> gives a better code than :
> 
> if (FWINV(ret != 0, IPT_INV_VIA_OUT)) {
> 
> (one less conditional branch)
> 
> Dont ask me why, it is shocking but true :(

I also noticed many times that gcc's optimization of "if (complex condition)"
is rather poor and it's often better to put it in a variable before. I even
remember that if you use an intermediate variable, it can often generate a
CMOV instruction on processors which support it, while it produces cond tests
and jumps without the variable. Generally speaking, if you want fast code,
you have to write it as a long sequence of small instructions, just as if
you were writing assembly. As you said, shocking but true.

BTW, cheers for your optimizations !

Regards,
Willy

