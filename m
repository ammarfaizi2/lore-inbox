Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUANWph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUANWph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:45:37 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:1486 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264894AbUANWp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:45:27 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org>
Date: 14 Jan 2004 17:18:34 -0500
In-Reply-To: <20031203204445.GA26987@gtf.org>
Message-ID: <87hdyyxjgl.fsf@stark.xeocode.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik <jgarzik@pobox.com> writes:

> Intel ICH5
>
> Issue #2: Excessive interrupts are seen in some configurations.

I guess I'm seeing this problem. I'm trying to get my P4P800 motherboard with
an ICH5 chipset working completely. So far I've been living without the cdrom
or DVD players. I see lots of other posts on linux-kernel about the same
problems:

Whenever I try to access the cdrom my system becomes unusable. Due to high
interrupts, typically over 150k/s. I thought libata would help, but I don't
understand how to use the PATA drive and the cdrom drives while I'm using it.

The situation is that I have two SATA drives, a PATA drive and two cdrom
drives (actually one CD burner and one DVD drive). They are 

Primary Master:   PATA Drive
Secondary Master: CD Burner
Secondary Slave:  DVD-Rom
SATA-1:           SATA Drive
SATA-2:           SATA Drive

I've tried 2.4.23pre4 (no libata), 2.6.1 (IDE drivers), and 2.6.1 (with scsi
libata drivers) with the following results:

2.4.23pre4: as soon as the cdrom is touched I see bursts of 150k interrupts
    per second and the system becomes unresponsive momentarily every few
    seconds.

2.6.1 with regular IDE drivers: same as above except the system feels
    responsive except for disk i/o. I see printks of "Disabling interrupt #18"
    and all disk i/o freezes for a few seconds.

2.6.1 with scsi ata_piix driver: the SATA drives show up and work fine but the
    PATA drive and the cdroms doesn't show up at all. This is true even when I
    compile with the CONFIG_IDE, CONFIG_BLK_DEV_IDE, and CONFIG_BLK_DEV_IDECD
    enabled.


-- 
greg

