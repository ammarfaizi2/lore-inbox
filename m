Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWBZVLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWBZVLX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWBZVLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:11:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751401AbWBZVLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:11:22 -0500
Date: Sun, 26 Feb 2006 13:04:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, largret@gmail.com,
       axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060226130402.5aa39e34.akpm@osdl.org>
In-Reply-To: <20060226203917.GA76858@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	<20060226102152.69728696.akpm@osdl.org>
	<20060226203917.GA76858@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Sun, Feb 26, 2006 at 10:21:52AM -0800, Andrew Morton wrote:
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > > Chris Largret is getting repeated OOM kills because of DMA memory
> > > exhaustion:
> > > 
> > > oom-killer: gfp_mask=0xd1, order=3
> > > 
> > 
> > This could be related to the known GFP_DMA oom on some x86_64 machines.
> 
> What known GFP_DMA oom? GFP_DMA allocation should work.
> 

There's a problem on some x86_64 machines which confuses the BIO layer. 
BIO makes simple decisions about bounce pfns and some x86_64 memory layouts
cause them to go wrong.  Net effect: lots of GFP_DMA allocations in the BIO
layer.

http://readlist.com/lists/vger.kernel.org/linux-kernel/36/182357.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173
