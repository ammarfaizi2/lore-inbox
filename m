Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHIVlO>; Fri, 9 Aug 2002 17:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSHIVlO>; Fri, 9 Aug 2002 17:41:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35766 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316088AbSHIVlN>;
	Fri, 9 Aug 2002 17:41:13 -0400
Date: Fri, 9 Aug 2002 14:47:47 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andrew Morton <akpm@zip.com.au>, Dave Hansen <haveblue@us.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
In-Reply-To: <20020809212231.GB1252@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0208091441350.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Andries Brouwer wrote:

> On Fri, Aug 09, 2002 at 02:00:37PM -0700, Andrew Morton wrote:
> 
> > > > Code;  c0160d0f <d_unhash+f/70>   <=====
> 
> > It would be much more useful if the oops code were to dump the
> > text preceding the exception EIP rather than after it, actually.
> 
> I think I already mentioned what the stack trace is for this oops:
> for me, it is sd_detach -> driverfs_remove_partitions ->

For some reason, the put_device() is forcing the refcount to 0, which 
shouldn't be happening. The refcounting model for devices is pretty wack 
right now, and this is one of a few places that's hitting it..

To solve this issue, I really think that driverfs_remove_partitions can go 
away. When a device's driverfs directory, all the files in it will be 
removed, so explicitly removing them is unnecssary.

	-pat


