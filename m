Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUJ3TFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUJ3TFg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUJ3TFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:05:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4267 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261253AbUJ3TFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:05:30 -0400
Date: Sat, 30 Oct 2004 14:14:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andreas Herrmann <AHERRMAN@de.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH] reduce stack consumption in do_mount
Message-ID: <20041030161453.GA17602@logos.cnet>
References: <OF2D3B25A6.EBF2AF62-ONC1256F3B.005D01ED-C1256F3B.005EBAFF@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2D3B25A6.EBF2AF62-ONC1256F3B.005D01ED-C1256F3B.005EBAFF@de.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 07:14:52PM +0200, Andreas Herrmann wrote:

> I have seen a kernel stack overflow during mount of a SCSI disk on
> s390, 31bit, with 4K stack size.
> 
> The backtrace showed that there were 3 functions with stack
> consumption of above 200 bytes.
> 
> These are do_mount (328 bytes stack size), ext3_fill_super (288 bytes)
> and mpage_writepages (352 bytes).

One possibly interesting thing for you guys who are trying to reduce 
stack usage is using the SLAB allocator for pagevec structures in the VM
code. mpage_readpages/writepages use those, and pretty much all VM code.

Allocating those structures from SLAB can also increase performance
due to cache colouring, but requires the additional instructions into
kmalloc() for allocation - needs benchmarking.

I want to try so if no one does it before.

