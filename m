Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbTDBOSd>; Wed, 2 Apr 2003 09:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263010AbTDBOSd>; Wed, 2 Apr 2003 09:18:33 -0500
Received: from [81.2.110.254] ([81.2.110.254]:64753 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263009AbTDBOSc>;
	Wed, 2 Apr 2003 09:18:32 -0500
Subject: Re: how to interpret ide error messages (2.4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kiniger, Karl (MED)" <karl.kiniger@med.ge.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030402122324.GA23847@ki_pc2.kretz.co.at>
References: <20030402122324.GA23847@ki_pc2.kretz.co.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049290268.16275.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2003 14:31:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 13:23, Kiniger, Karl (MED) wrote:
> kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> kernel: hdc: dma_intr: error=0x01 { AddrMarkNotFound }, LBAsect=20300322, sector=1263288
> kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }

The drive could not find the requested sector. That normally means bad
things but for some drivers can also mean the controller asked for a
totally bogon sector number

> kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=20803307, sector=1766272
> kernel: end_request: I/O error, dev 16:04 (hdc), sector 1766272

Unrecoverable data error.

> The affected sectors dont generate any error messages if I read them today...

On errors the next write to a bad sector will typically remap it
transparently to another spare block on the disk. Read obviously cannot
do the same. That would mean that if for example clearcase ignored the
I/O error and wrote back what it thought it saw but did not that it may
have recovered the sector with invalid data. Its also possible of course
clearcase actually handles I/O errors properly (which is hard).

Consult the clearcase support I guess, there should be tools to verify
your clearcase datasets. You might also want to force an fsck on your
file systems while the box is down for disk replacement to check 
everything out.

