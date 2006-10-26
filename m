Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423593AbWJZQFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423593AbWJZQFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423596AbWJZQFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:05:41 -0400
Received: from hera.kernel.org ([140.211.167.34]:27611 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1423593AbWJZQFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:05:40 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: incorrect taint of ndiswrapper
Date: Thu, 26 Oct 2006 09:00:02 -0700
Organization: OSDL
Message-ID: <20061026090002.49b04f1b@freekitty>
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
	<20061025205923.828c620d.akpm@osdl.org>
	<1161859199.12781.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1161878706 5937 10.8.0.228 (26 Oct 2006 16:05:06 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 26 Oct 2006 16:05:06 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006 11:39:59 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Mer, 2006-10-25 am 20:59 -0700, ysgrifennodd Andrew Morton:
> > May be so.  But this patch was supposed to print a helpful taint message to
> > draw our attention to the fact that ndis-wrapper was in use.  The patch was
> > not intended to cause gpl'ed modules to stop loading 
> 
> The stopping loading is purely because it now uses _GPLONLY symbols,
> which is fine until the user wants to load a windows driver except for
> the old CIPE driver. Some assumptions broke somewhere along the way and
> the chain of events that was never forseen unfolded.
> 
> > Now, if we do want to disallow gpl module loading after ndis-wrapper has
> > been used then fine
> 
> The problem is we do the dynamic link at module load time. We would have
> to unlink the module if it tried to taint itself, which is clearly not
> what the end user needs to suffer. Having the taint function actually
> taint and printk + return a "Linked gplonly you can't" error seems the
> better solution.
> 
> Really ndiswrapper shouldn't be using _GPLONLY symbols, that would
> actually make it useful to the binary driver afflicted again and more
> likely to be legal.
> 

What are the symbols in question? A simple test would be to take the GPL
MODULE_LICENSE() off of ndiswrapper and try loading it.

-- 
Stephen Hemminger <shemminger@osdl.org>
