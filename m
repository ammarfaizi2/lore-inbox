Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131180AbQK0OCU>; Mon, 27 Nov 2000 09:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131374AbQK0OCM>; Mon, 27 Nov 2000 09:02:12 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:52687 "EHLO
        mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
        id <S131180AbQK0OB4>; Mon, 27 Nov 2000 09:01:56 -0500
Message-ID: <3A2261CD.322EB04@didntduck.org>
Date: Mon, 27 Nov 2000 08:29:49 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CDROMPLAYTRKIND causes an oops on aic7xxx
In-Reply-To: <3A21E07C.C3A9880E@didntduck.org> <20001127085938.G31641@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sun, Nov 26 2000, Brian Gerst wrote:
> > I get an oops from aic7xxx_buildscb() when CDROMPLAYTRKIND is used.
> > I've tracked it down to sr_audio_ioctl() using SCSI_DATA_NONE for the
> > direction of the command, which gets changed to PCI_DMA_NONE, which then
> > triggers a BUG() in pci_map_single().  Is SCSI_DATA_NONE the correct
> > direction code, or is there a problem further down the code?  Oops
> > attached.
> 
> NONE is the right direction, but buflen needs to be 0 too. The
> patch is here
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2

That worked.  Thanks.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
