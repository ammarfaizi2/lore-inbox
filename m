Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVC0RMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVC0RMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVC0RMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:12:35 -0500
Received: from colin2.muc.de ([193.149.48.15]:49159 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261163AbVC0RMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:12:25 -0500
Date: 27 Mar 2005 19:12:20 +0200
Date: Sun, 27 Mar 2005 19:12:20 +0200
From: Andi Kleen <ak@muc.de>
To: davidm@hpl.hp.com
Cc: Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Message-ID: <20050327171220.GA18506@muc.de>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com> <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com> <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com> <20050318192808.GB38053@muc.de> <16963.2075.713737.485070@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16963.2075.713737.485070@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Clearly, if the CPU that's clearing the page is likely to use that
> same page soon after, it'd be useful to use temporal stores.

That is always the case in the current code (without Christophers 
pre cleaning daemon). The page fault handler clears and user space
is guaranteed to need at least one cacheline from the fresh page
because it just did a page fault on it. With non temporal stores
you guarantee at least one hard cache miss directly after
the return to user space.

I suspect even with precleaning the average time from cleaning to use will be 
quite short.

-Andi
