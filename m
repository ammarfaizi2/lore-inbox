Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUFQBXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUFQBXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUFQBXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:23:02 -0400
Received: from havoc.gtf.org ([216.162.42.101]:58338 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266346AbUFQBWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:22:20 -0400
Date: Wed, 16 Jun 2004 21:22:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Chew <achew@nvidia.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Message-ID: <20040617012219.GA11167@havoc.gtf.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B4@mail-sc-6-bk.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B4@mail-sc-6-bk.nvidia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 06:19:34PM -0700, Andrew Chew wrote:
> > From: Bartlomiej Zolnierkiewicz 
> 
> > Is there any reason why this driver doesn't support 
> > CK804-SATA[2] and  MCP04-SATA[2]?
> 
> These will be supported by this driver eventually.  We probably can
> change it now, but silicon isn't available for these yet so I wasn't
> able to test the driver.

If silicon isn't available yet, let's just remove those PCI IDs.  That
way we can ensure that these are libata only, without two drivers
sharing the same PCI ids.


> > Removing IDs from amd74xx.c is a bad idea,
> > it breaks boot on systems already using these IDs.
> 
> I assume these systems will be able to boot using the libata subsystem.
> Is that a bad assumption?

They can, but consider a system that uses 2.6.7 (IDE driver) then boots
into 2.6.8 (libata driver):  the drives move from /dev/hdX to /dev/sdX.
That breaks stuff not using LABEL= in bootloader config and fstab.

	Jeff



