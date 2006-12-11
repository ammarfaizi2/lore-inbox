Return-Path: <linux-kernel-owner+w=401wt.eu-S1762682AbWLKJZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762682AbWLKJZH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762680AbWLKJZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:25:07 -0500
Received: from smtp2.belwue.de ([129.143.2.15]:34128 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762682AbWLKJZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:25:05 -0500
Date: Mon, 11 Dec 2006 10:24:02 +0100 (CET)
From: Karsten Weiss <K.Weiss@science-computing.de>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
 memory hole mapping related bug?!
In-Reply-To: <Pine.LNX.4.64.0612021202000.2981@addx.localnet>
Message-ID: <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006, Karsten Weiss wrote:

> On Sat, 2 Dec 2006, Christoph Anton Mitterer wrote:
> 
> > I found a severe bug mainly by fortune because it occurs very rarely.
> > My test looks like the following: I have about 30GB of testing data on
> 
> This sounds very familiar! One of the Linux compute clusters I
> administer at work is a 336 node system consisting of the
> following components:
> 
> * 2x Dual-Core AMD Opteron 275
> * Tyan S2891 mainboard
> * Hitachi HDS728080PLA380 harddisk
> * 4 GB RAM (some nodes have 8 GB) - intensively tested with
>   memtest86+
> * SUSE 9.3 x86_64 (kernel 2.6.11.4-21.14-smp) - But I've also
>   e.g. tried the latest openSUSE 10.2 RC1+ kernel 2.6.18.2-33 which
>   makes no difference.
> 
> We are running LS-Dyna on these machines and discovered a
> testcase which shows a similar data corruption. So I can
> confirm that the problem is for real an not a hardware defect
> of a single machine!

Last week we did some more testing with the following result:

We could not reproduce the data corruption anymore if we boot the machines 
with the kernel parameter "iommu=soft" i.e. if we use software bounce 
buffering instead of the hw-iommu. (As mentioned before, booting with 
mem=2g works fine, too, because this disables the iommu altogether.)

I.e. on these systems the data corruption only happens if the hw-iommu 
(PCI-GART) of the Opteron CPUs is in use.

Christoph, Erik, Chris: I would appreciate if you would test and hopefully 
confirm this workaround, too.

Best regards,
Karsten

-- 
__________________________________________creating IT solutions
Dipl.-Inf. Karsten Weiss               science + computing ag
phone:    +49 7071 9457 452            Hagellocher Weg 73
teamline: +49 7071 9457 681            72070 Tuebingen, Germany
email:    knweiss@science-computing.de www.science-computing.de

