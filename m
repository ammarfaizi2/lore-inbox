Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279217AbRJWCzb>; Mon, 22 Oct 2001 22:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279215AbRJWCzW>; Mon, 22 Oct 2001 22:55:22 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:20996
	"HELO marcus.pants.nu") by vger.kernel.org with SMTP
	id <S279213AbRJWCzM>; Mon, 22 Oct 2001 22:55:12 -0400
Subject: Re: hfs cdrom broken in 2.4.13pre
To: trini@kernel.crashing.org (Tom Rini)
Date: Mon, 22 Oct 2001 19:11:39 -0700 (PDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        hollis-lists@austin.rr.com (Hollis Blanchard),
        pochini@denise.shiny.it (Giuliano Pochini),
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011022155617.B6673@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Oct 22, 2001 03:56:17 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011023021139.C66662B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> No, really.  What's changed to break HFS cdrom support?

Based on the messages and glancing over the hfs code, I would guess
that the CD-ROM block device driver used to fake accessing the drive
at any random block size. The hfs code depends on being able to use
a particular block size (512) and if the driver for the block device
doesn't support it, stuff breaks.

(super.c lines 394-416/491 byte 10778/12361 87%)

        /* set the device driver to 512-byte blocks */
        set_blocksize(dev, HFS_SECTOR_SIZE);

To be more flexible, the hfs code shouldn't force a hard coded block size.

	Brad Boyer
	flar@allandria.com

