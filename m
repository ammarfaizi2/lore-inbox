Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUDQEg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 00:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUDQEg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 00:36:56 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:58597 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S263620AbUDQEgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 00:36:53 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: ross.biro@gmail.com
Subject: Re: Kernel writes to RAM it doesn't own on 2.4.24   
Date: Sat, 17 Apr 2004 14:40:18 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, root@chaos.analogic.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404171440.18829.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004, Ross Biro wrote: 

> On Fri, 16 Apr 2004, Richard B. Johnson wrote: 
> > 
> > On Fri, 16 Apr 2004, Ross Biro wrote: 
> > 
> > > mem= isn't there to tell the kernel what ram it owns and what ram it 
> > > doesn't own. It's there to tell the kernel what ram is in the system. 
> > > Since you told the system it only has 500m, it assumes the rest of 
> > > the 3.5G of address space is available for things like memory mapped 
> > > i/o. If you cat /proc/iomem, you'll probably see something has 
> > > reserved the memory range in question. 
> > > 
> > 
> > No! This is address space, not RAM. Whether or not a PCI device 
> > or whatever has internal RAM that's mapped makes no difference. 
> > 
> > I told the kernel that it has 500m of RAM. It better not assume 
> > I don't know what I'm talking about. I might have reserved that 
> > RAM because it's bad or I may have something else important to 
> > do with that RAM (which I do). 
 


> The problem is that the kernel does assume you know what you are 
> talking about, and you don't. You are abusing the mem= parameter. 
> That's fine, but then you have to tell the kernel what you really 
> mean. What you really want to say is there is memory above 500M and I 
> don't want you to touch it. There may be a way to do that via the 
> fancy mem=@ parameters. 
 


> What mem= tells the kernel is that there is RAM in a certain spot an 
>  no where else. Since you told the kernel there is no ram about 500M, 
> that means that address space is free to be used for memory mapped 
> I/O. Since the kernel trusts you, it started using the memory above 
> 500m for memory mapped i/o. Since you LIED to the kernel, you are 
> getting results you do not like. The solution I settled on was to 
> tell the kernel that people LIE to it and only use memory for I/O if 
> both the BIOS and the USER agree that it's available. You have to 
> find a way to tell the kernel the TRUTH, or you will never get the 
> results you want. 
> - 


This is all most enlightening. If I am understanding correctly then every
device driver that the author specifies to use a "mem=" command to 
reserve some memory for said drivers use at the upper part of physical
memory is stuffed by design. 

I thought it was a valid technique? I never questioned it because there is
a history of its use -I think the early bttv driver was written this way.

I have been debugging an oops on a system which uses the open source
driver for the Matrox MeteorII multichannel available from,
http://www.emlix.com/index.php?id=158
This driver uses the technique and I am getting a corrupted slab free list. 

Ross B, could I please have details of your mem bios hack please so I can try
it as a workaround.

Regards
Ross Dickson



