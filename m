Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129345AbQK0IaI>; Mon, 27 Nov 2000 03:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129391AbQK0I36>; Mon, 27 Nov 2000 03:29:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42257 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S129345AbQK0I3r>;
        Mon, 27 Nov 2000 03:29:47 -0500
Date: Mon, 27 Nov 2000 08:59:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CDROMPLAYTRKIND causes an oops on aic7xxx
Message-ID: <20001127085938.G31641@suse.de>
In-Reply-To: <3A21E07C.C3A9880E@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A21E07C.C3A9880E@didntduck.org>; from bgerst@didntduck.org on Sun, Nov 26, 2000 at 11:18:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26 2000, Brian Gerst wrote:
> I get an oops from aic7xxx_buildscb() when CDROMPLAYTRKIND is used. 
> I've tracked it down to sr_audio_ioctl() using SCSI_DATA_NONE for the
> direction of the command, which gets changed to PCI_DMA_NONE, which then
> triggers a BUG() in pci_map_single().  Is SCSI_DATA_NONE the correct
> direction code, or is there a problem further down the code?  Oops
> attached.

NONE is the right direction, but buflen needs to be 0 too. The
patch is here

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2


-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
