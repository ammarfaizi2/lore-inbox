Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWGFTKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWGFTKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGFTKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:10:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64422 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750700AbWGFTKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:10:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
References: <20060704113441.GA26023@muc.de>
	<1152137302.6533.28.camel@localhost.localdomain>
	<20060705220425.GB83806@muc.de>
	<m1odw32rep.fsf@ebiederm.dsl.xmission.com>
	<20060706130153.GA66955@muc.de>
	<m18xn621i6.fsf@ebiederm.dsl.xmission.com>
	<20060706165159.GB66955@muc.de>
	<m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
	<20060706180826.GA95795@muc.de>
	<1152210898.13734.12.camel@localhost.localdomain>
	<20060706182729.GA97717@muc.de>
Date: Thu, 06 Jul 2006 13:09:35 -0600
In-Reply-To: <20060706182729.GA97717@muc.de> (Andi Kleen's message of "6 Jul
	2006 20:27:29 +0200, Thu, 6 Jul 2006 20:27:29 +0200")
Message-ID: <m1fyhey2hc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

>
> It depends on what you do. First a large part of X's messiness
> comes from it not using the proper interfaces.
> Or it trying to do complicated things like messing with bridges. 

Yep we sometimes have to mess with complicated things.

> Then anything with MMIO or interrupts or anything dynamic 
> definitely belongs into kernel space agreed.

Yep we sometimes have to mess with MMIO.

> But at least on K8 DIMM inventory is purely reading PCI config space on
> something that doesn't change and doesn't need any locking. 
> It also doesn't need to do anything complicated, but just look
> for the right PCI ID.

Mostly.  Except for the part where you have to figure out the stepping
of the processor connected to the memory controller to properly decode
the registers.  AMD should have used the revision field in pci config
space but...

> I don't see an issue with such simple static things in user space.

I agree it should be that simple. 

But if all of your drivers are not that simple it doesn't make sense
to put half of them in user space and half of them in the kernel,
unless there is a good reason for them not to be in the kernel.

Eric
