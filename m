Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUBZXEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUBZXE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:04:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37279 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261248AbUBZXDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:03:11 -0500
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
From: john stultz <johnstul@us.ibm.com>
To: Go Taniguchi <go@turbolinux.co.jp>, willy@debian.org
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1077830762.2857.164.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077668801.2857.63.camel@cog.beaverton.ibm.com>
	 <20040224170645.392abcff.akpm@osdl.org> <403E0563.9050007@turbolinux.co.jp>
	 <1077830762.2857.164.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1077836576.2857.168.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 15:02:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-26 at 13:26, john stultz wrote:
> On Thu, 2004-02-26 at 06:40, Go Taniguchi wrote:
> > Hi,
> > 
> > Andrew Morton wrote:
> > > john stultz <johnstul@us.ibm.com> wrote:
> > > 
> > >>	Booting 2.6.3-mm3 on an x440 hangs the box during the SCSI probe after
> > >>the following:
> > >> 
> > >>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
> > >>        <Adaptec aic7899 Ultra160 SCSI adapter>                 
> > >>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> > >>                                                                
> > >>
> > >>I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
> > >>there as well. 
> > > 
> > > 
> > > Could you try reverting aic7xxx-deadlock-fix.patch?  Also, add
> > > initcall_debug to the boot command just so we know we aren't blaming the
> > > wrong thing.
> > > 
> > > Apart from that, gosh.  Maybe you could add just linus.patch and
> > > bk-scsi.patch, see if that hangs too?  Or just test the latest linus tree -
> > > the scsi changes were merged this morning.  Thanks.
> > > 
> > 
> > Problem patch is expanded-pci-config-space.patch.
> > x440 can not enable acpi by dmi_scan.
> > expanded-pci-config-space.patch need acpi support.
> > So, kernel can not get x440's xAPIC interrupt.
> 
> Wow, thanks for that analysis Go! I'll test it here to confirm. 

Yep, I've confirmed that backing out the expanded-pci-config-space patch
solves it. Thanks again, Go, for hunting that down! 

Matthew, any ideas why the patch fails if the system has an ACPI
blacklist entry?

thanks
-john

