Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291078AbSBLOXy>; Tue, 12 Feb 2002 09:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291075AbSBLOXp>; Tue, 12 Feb 2002 09:23:45 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:49108 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S291079AbSBLOXb>; Tue, 12 Feb 2002 09:23:31 -0500
Message-ID: <3C6926E7.90F7C781@ntlworld.com>
Date: Tue, 12 Feb 2002 14:29:59 +0000
From: SA products <super.aorta@ntlworld.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Write-combining
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

Sorry this maybe off topic-- I am writing a device driver for a kind of
framebuffer device.
This is virtually complete and working, all I wish to add is
write-combining but I can find
very little information on how to do this.  Looking at other device
drivers MTRR crops
up a few times but I is still not clear to me what I have to do.

So far-
I grab the memory region for the framebuffer (1/4Mb) something like so;
......

memio=ioremap(pci_resource_start(dev,MEMIO)&PCI_BASE_ADDRESS_MEM_MASK,MEMIO_SIZE);

......
then try to mtrr it
.....
    err=mtrr_add(memio,MEMIO_SIZE,MTRR_TYPE_WRCOMB,1);
......
which fails because memio is not aligned correctly

my code generates the following messages
slm: init: mtrr option enabled- trying region cc960000
mtrr: base(0xcc960000) is not aligned on a size(0x40000) boundary
slm: init: mtrr: unable to set write combining for slm memory :(

Before I go any further I would like to ask is this a sensible approach
or have I missed
something somewhere?

If this is not the most sensible way please point me towards a sensible
solution-

If this is the correct way of doing things is there
> an easy way to discover the mtrr alignment requirements prior to
mtrr_add?
> Can I align memio properly (how?) or
>   do I start by defining a larger mtrr region below memio and then
masking off the
    unwanted regions either side of my memory region with
mtrr(...MTRR_TYPE_WRBACK..)?
> What happens on none x86 type processors?

any other advice?


Thanks SA


