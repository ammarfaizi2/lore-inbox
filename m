Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWB1Bjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWB1Bjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWB1Bjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:39:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932120AbWB1Bjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:39:47 -0500
Date: Mon, 27 Feb 2006 17:38:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: clameter@engr.sgi.com, largret@gmail.com, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060227173830.5fee084f.akpm@osdl.org>
In-Reply-To: <20060228012553.GA52585@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	<20060226102152.69728696.akpm@osdl.org>
	<1140988015.5178.15.camel@shogun.daga.dyndns.org>
	<20060226133140.4cf05ea5.akpm@osdl.org>
	<20060226235142.GB91959@muc.de>
	<Pine.LNX.4.64.0602271429270.12204@schroedinger.engr.sgi.com>
	<20060228004115.GA37362@muc.de>
	<20060227165921.242f6810.akpm@osdl.org>
	<20060228012553.GA52585@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> > I was thinking that your __GFP_NOOOM was a thinko.  How would it differ
> > from __GFP_NORETRY?
> 
> __GFP_NORETRY seems to skip at least one retry pass as far as I can see.
> __GFP_NOOOM wouldn't. But perhaps the additional pass only makes sense
> with oom killing? I'm not sure - that is why i was asking.
> 

Oh, OK.  That final get_page_from_freelist() is allegedly to see if a
parallel oom-killing freed some pages - we already know that
try_to_free_pages() didn't work.

I rather doubt that it'll make any difference.
