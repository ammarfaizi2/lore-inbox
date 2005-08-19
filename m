Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVHSJPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVHSJPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 05:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVHSJPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 05:15:06 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:62549 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932563AbVHSJPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 05:15:03 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,124,1122847200"; 
   d="scan'208"; a="14313210:sNHT27964328"
To: linux-kernel@vger.kernel.org
Subject: Re: SATA status report updated
References: <4AA7B-4jm-5@gated-at.bofh.it> <4DagM-7c8-43@gated-at.bofh.it>
Organization: Fujitsu Siemens Computers VP BC E SW OS
From: Rainer Koenig <Rainer.Koenig@fujitsu-siemens.com>
Date: Fri, 19 Aug 2005 11:14:45 +0200
In-Reply-To: <4DagM-7c8-43@gated-at.bofh.it> (Simon Oosthoek's message of
 "Fri, 19 Aug 2005 10:20:16 +0200")
Message-ID: <871x4ql24a.fsf@ABG3595C.abg.fsc.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Simon Oosthoek <simon.oosthoek@ti-wmc.nl> writes:

> I'm wondering how the support for the SIS 182 controller is doing, I
> noticed they have a GPL driver on their website for kernel 2.6.10,
> which is not a drop in replacement for sata_sis.c in 2.6.12.5, I
> haven't tried compiling it as an add-on module outside the tree,
> though...

I tried the sources from the SiS website (that seem to add more
details than my simple patch that just adds the device ID) as a drop
in for the Fedora installation kernel 2.6.11-1.1369_FC4, but the
kernel build process ran into an error at the sata_sis module. The
problem is that the source from SiS has a conditional code that
depends on the definition of a symbol "KERN_2_6_10" which is defined
by their "outside build makefile", but not in the standard kernel
build process. I added a #define KERN_2_6_10 to the source and then it
compiled also inside the kernel build process.

> Adding the 0x182 identifier to the 180 driver does compile (duh!), but
> I haven't tried it on hardware.

Working at a PC manufacturer I have access to hardware and I tried out
a lot and didn't run into any problem so far. 

> As a temporary measure, there was a patch posted to this list [1] a
> while ago, would it be a good idea to include this while full support
> is being worked on?

Seeing that the source from the SiS website is much more going into the
details than my simple adding of the device ID (of course SiS has hopefully
a much deeper knowledge of their hardware than I have ;-) I would rather
go for integrating the SiS source in the current kernel. 

And this problem is quite urgent since its a sort of "showstopper" for 
brandnew hardware. We have a query from an university that wants to buy
7000 PCs with that hardware in the next 4 years, but until yesterday they
were unable to install Fedora Core 4 on the machine since the installer
doesn't see any hard disks. I succeeded to make a simple quick&dirty
driver disk to get Linux at least installed on the hard disk. But the
problem also applies for every other Linux distribution, so we urgently
need to get support for that device in the mainstream kernel hoping 
that it will be inherited to the installation kernels of the distributions
soon. 

Generally SATA is replacing parallel ATA in the new PC platforms and we
already got anouncements that future platforms will come with SATA only.
So can't emphasize enought that SATA support is absolutely important for
Linux on the desktop. 

If there is something I can do to help or contribute let me know. 

Best regards
Rainer
-- 
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux
Business Clients
Fujitsu Siemens Computers 
VP BC E SW OS
Phone: +49-821-804-3321
Fax:   +49-821-804-2131
 
