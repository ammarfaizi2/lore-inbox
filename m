Return-Path: <linux-kernel-owner+w=401wt.eu-S932760AbXAJJfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbXAJJfu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 04:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbXAJJfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 04:35:50 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:3309 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932760AbXAJJft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 04:35:49 -0500
Date: Wed, 10 Jan 2007 10:35:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-Id: <20070110103555.9bc45c6a.khali@linux-fr.org>
In-Reply-To: <20070110035820.GB27550@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de>
	<20070105095233.4ce72e7e.khali@linux-fr.org>
	<20070107154441.GB22558@jupiter.solarsys.private>
	<20070108121055.d25c8ffa.khali@linux-fr.org>
	<20070109030226.GA2408@jupiter.solarsys.private>
	<20070109141721.b823187c.khali@linux-fr.org>
	<20070110035820.GB27550@jupiter.solarsys.private>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 9 Jan 2007 22:58:20 -0500, Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2007-01-09 14:17:21 +0100]:
> > I am worried about the Intel/Asus SMBus quirk then, which affects many
> > more users than the SiS SMBus one, and would suffer from a reordering as
> > well.
> 
> Intel/Asus users on FC[456] would surely have screamed if that was true.  But I
> was curious so I looked deeper.  There is a fundamental difference between the
> Intel SMBus quirks and the SiS SMBus quirk...
> 
> Intel:
> 1) The first quirk keys off the host bridge, setting a flag.  
> 2) The second quirk keys off the LPC, enabling the SMBus if the flag was set.
> 
> SiS:
> 1) The first quirk keys off the *old* LPC ID... this causes the ID to change.[1]
> 2) The second quirk keys off the *new* LPC ID; this one enables the SMBus.
> 
> In the SiS case, both quirks key off the *same* *device*, but with potentially
> different IDs.  The quirk list ordering matters there because the list is
> scanned only once per device.
> 
> For the Intel case, the only ordering that matters is that the host bridge
> device is added [pci_device_add()] before the LPC; AFAICT, that is reliable,
> perhaps even by definition.
> 
> So I don't think you have to worry about the Intel SMBus quirks.

Ah, OK, I think I get it now, thanks for the clarification. I thought
that the quirks were processed in file order for all devices at once,
while I now understand they are processed for each device in turn. In
which case, indeed, as long as the host bridge PCI device is listed
before the ISA bridge PCI device (and as you suggest this appears to be
guaranteed), the Intel SMBus quirk will work fine, regardless of the
linking order.

-- 
Jean Delvare
