Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVAJUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVAJUYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVAJUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:22:32 -0500
Received: from one.firstfloor.org ([213.235.205.2]:192 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262494AbVAJUMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:12:03 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	<41DD9968.7070004@comcast.net>
	<1105045853.17176.273.camel@localhost.localdomain>
	<1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>
	<1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>
	<1105278618.12054.37.camel@localhost.localdomain>
	<41E1CCB7.4030302@comcast.net>
	<21d7e99705010917281c6634b8@mail.gmail.com>
	<1105361337.12054.66.camel@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: Mon, 10 Jan 2005 21:11:54 +0100
In-Reply-To: <1105361337.12054.66.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 10 Jan 2005 18:27:52 +0000")
Message-ID: <m1fz196o39.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
> We've seen that with the proposed 1Gb DMA area on x86-64 - Nvidia wanted
> a 4Gb one to fix their hardware needs and various other drivers want a
> 1Gb DMA area. That happens to also sort Nvidia's problems.

To clarify there are other drivers who also want 4GB (e.g. the free
Intel and ATI DRM drivers and also some other video drivers) 

I haven't seen a real request from someone who requires 1GB, but needs
to use more than 96MB (16MB GFP_DMA + 64-128MB softiommu/amd iommu memory) 

But 1GB is not enough for the higherend 3d users, especially when you
put multiple adapters into the machine.

>>From DRI experience I'd say that a mostly user space nvidia driver would
> probably be almost as problematic as a binary kernel module. It would
> make reverse engineering a lot easier though 8)

I think it would be a good idea to perhaps to move common services
needed by Nvidia and others (ATI, free DRI drivers, others) into a
common free library. This way we would probably break them less often
and there would be less potentially buggy code in the kernel. 

And anything that shrinks binary only drivers and replaces them with
more and more free code is probably a good thing. And doing this in baby
steps is probably the only realistic option.

-Andi
