Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUIVSvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUIVSvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUIVSvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:51:39 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:42460 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266643AbUIVSvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:51:37 -0400
To: Timothy Miller <miller@techsource.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, jmerkey@comcast.net,
       alan@lxorguk.ukuu.org.uk, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
X-Message-Flag: Warning: May contain useful information
References: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>
	<20040830111019.5ddc99ab.rddunlap@osdl.org>
	<4151C9FB.8040100@techsource.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 22 Sep 2004 11:51:34 -0700
In-Reply-To: <4151C9FB.8040100@techsource.com> (Timothy Miller's message of
 "Wed, 22 Sep 2004 14:52:43 -0400")
Message-ID: <52r7oukuh5.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Sep 2004 18:51:35.0150 (UTC) FILETIME=[2F1378E0:01C4A0D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timothy> My question is: Why can't we just shrink the kernel
    Timothy> address space by that same amount, allowing the kernel
    Timothy> address space plus the extra to fit into 1GB?

If you have 1 GB of memory and want to map it all into the kernel's
address space and the kernel has only 1 GB of address space total,
then there is no room for anything else (such as address space to
ioremap memory-mapped peripherals or space for vmalloc allocations).
Therefore, if you want to have 1 GB of RAM mapped linearly into the
kernel's address space, you need strictly more than 1 GB of kernel
address space.  In practice, 1.25 GB of kernel address space (a
PAGE_OFFSET value of 0xb0000000) works well with 1 GB of RAM.  That's
what I run on my main desktop machine with 1 GB of RAM to avoid HIGHMEM.

 - Roland
