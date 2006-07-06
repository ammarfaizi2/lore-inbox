Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWGFS1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGFS1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWGFS1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:27:32 -0400
Received: from colin.muc.de ([193.149.48.1]:31506 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750726AbWGFS1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:27:31 -0400
Date: 6 Jul 2006 20:27:29 +0200
Date: Thu, 6 Jul 2006 20:27:29 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060706182729.GA97717@muc.de>
References: <20060704113441.GA26023@muc.de> <1152137302.6533.28.camel@localhost.localdomain> <20060705220425.GB83806@muc.de> <m1odw32rep.fsf@ebiederm.dsl.xmission.com> <20060706130153.GA66955@muc.de> <m18xn621i6.fsf@ebiederm.dsl.xmission.com> <20060706165159.GB66955@muc.de> <m18xn6zkx3.fsf@ebiederm.dsl.xmission.com> <20060706180826.GA95795@muc.de> <1152210898.13734.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152210898.13734.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 07:34:58PM +0100, Alan Cox wrote:
> Ar Iau, 2006-07-06 am 20:08 +0200, ysgrifennodd Andi Kleen:
> > > No. There is a status report that tells you which pieces of hardware
> > > your memory controller sees.  It is just a simple list.
> > 
> > Ok but that could be also done easily in user space that reads
> > PCI config space. No need for a complicated kernel driver at all.
> 
> The same is true of writing a file system and disk driver so I'm a bit
> confused why you think poking around in PCI space from user space is an
> argument or given how often such stuff breaks and how messy it gets (eg
> X) that we want to encourage it

It depends on what you do. First a large part of X's messiness
comes from it not using the proper interfaces.
Or it trying to do complicated things like messing with bridges. 

Then anything with MMIO or interrupts or anything dynamic 
definitely belongs into kernel space agreed.

But at least on K8 DIMM inventory is purely reading PCI config space on
something that doesn't change and doesn't need any locking. 
It also doesn't need to do anything complicated, but just look
for the right PCI ID.

I don't see an issue with such simple static things in user space.

I could probably write it as a shell script that parses lspci output
(not saying that that would be the right way, but it's certainly
doable)

-Andi 

