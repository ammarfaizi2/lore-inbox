Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUJOTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUJOTXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUJOTW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:22:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13719 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268355AbUJOTWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:22:14 -0400
Message-ID: <41702358.1080203@pobox.com>
Date: Fri, 15 Oct 2004 15:22:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug McNaught <doug@mcnaught.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: CDROM support in ata_piix?
References: <87k6txdte5.fsf@asmodeus.mcnaught.org>
In-Reply-To: <87k6txdte5.fsf@asmodeus.mcnaught.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:
> I have an IBM server with a SATA controller listed as:
> 
> 0000:00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller (rev 02)
> 
> Debian's 2.6.8 kernel with libata works fine, except that the CDROM
> (which is on a PATA port) does not appear as a SCSI device.  It's also
> not seen by the regular IDE driver, because ata_piix has already
> grabbed the i/o resources--I get:
> 
> ide0: I/O resource 0x1F0-0x1F7 not free.
> ide0: ports already in use, skipping probe
> ide1: I/O resource 0x170-0x177 not free.
> ide1: ports already in use, skipping probe
> 
> Is there any way to get ata_piix to register my CDROM, or
> alternatively to have the regular IDE driver handle it? 
> 
> This seems to be a known problem (it's filed as a Debian bug)--is it
> fixed in 2.6.9-rc4?  I had a look at the -rc4 patch but couldn't tell
> from the diff whether there's anything CDROM-related in there...

Well, two things are going on:

You may need to set CONFIG_BLK_DEV_SATA (or unset it) depending on your 
configuration.

Once you get past that, you need to apply the latest libata patch to fix 
a related combined mode bug.

http://lkml.org/lkml/2004/10/14/336

	Jeff



