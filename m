Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWCLLG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWCLLG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 06:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWCLLG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 06:06:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932155AbWCLLG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 06:06:57 -0500
Date: Sun, 12 Mar 2006 03:04:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2/8] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
Message-Id: <20060312030435.6a5ff2c2.akpm@osdl.org>
In-Reply-To: <20060312104728.GA25301@2ka.mipt.ru>
References: <E3A930D59AFC3345AEBA35189102A8A6060E15E7@orsmsx404.amr.corp.intel.com>
	<20060312104728.GA25301@2ka.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
>  On Fri, Mar 10, 2006 at 06:29:46PM -0800, Leech, Christopher (christopher.leech@intel.com) wrote:
>  > From: Chris Leech [mailto:christopher.leech@intel.com] 
>  > Sent: Friday, March 10, 2006 6:29 PM
>  > To: 
>  > Subject: [PATCH 2/8] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
>  > 
>  > 
>  > Adds a new ioatdma driver
> 
>  enumerate_dma_channels() is still broken, if it can not fail add NOFAIL
>  gfp flag.

The __GFP_NOFAIL flag is there to mark lame-and-buggy-code which doesn't
know how to handle ENOMEM.  I went through the kernel, found all the
retry-until-it-works loops and consolidated their behaviour in the page
allocator instead.

Really we should fix them all up.  Adding new users of __GFP_NOFAIL
would not be good.
