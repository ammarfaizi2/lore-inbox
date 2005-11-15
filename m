Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVKOQq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVKOQq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVKOQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:46:58 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:31004 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964830AbVKOQq5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:46:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErJHTrdNb1Pu71YWgwWNdEXOb3Z2VIPnAYivnk5sDMNsjPFZfbAJmj9n7UP/qER25VcK2aVjP9OWKhM8GHrtW0iVOOgRqILP4s6VF2SIW81ORaC0W14PgdQH79r/tYrzA1bTq8ldMv+qnjoaWjNvdLtxATjJ1oX07hYt8BvZ/SU=
Message-ID: <58cb370e0511150846r5f8c89aagddf902e9b6ab6361@mail.gmail.com>
Date: Tue, 15 Nov 2005 17:46:55 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bryce Nesbitt <bryce1@obviously.com>
Subject: Re: ide: failed opcode errors, thousands of them, 2.6.13-15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43784187.4060607@obviously.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43784187.4060607@obviously.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/05, Bryce Nesbitt <bryce1@obviously.com> wrote:
> This is using a SUSE Linux 10.0 build.  I installed a new DVD burner,
> and now get 1 error per second in
> the kernel ring buffer:
>
> Nov 13 23:31:18 linux kernel: hdc: packet command error: status=0x51 {
> DriveReady SeekComplete Error }
> Nov 13 23:31:18 linux kernel: hdc: packet command error: error=0x54 {
> AbortedCommand LastFailedSense=0x05 }
> Nov 13 23:31:18 linux kernel: ide: failed opcode was: unknown
> Nov 13 23:31:19 linux udevd[2297]: get_netlink_msg: no ACTION in payload
> found, skip event 'mount'
> Nov 13 23:31:19 linux kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
> Nov 13 23:31:19 linux kernel: ISO 9660 Extensions: RRIP_1991A
> Nov 13 23:31:19 linux kernel: hdc: packet command error: status=0x51 {
> DriveReady SeekComplete Error }
> Nov 13 23:31:19 linux kernel: hdc: packet command error: error=0x54 {
> AbortedCommand LastFailedSense=0x05 }
> Nov 13 23:31:19 linux kernel: ide: failed opcode was: unknown
> Nov 13 23:31:20 linux kernel: hdc: packet command error: status=0x51 {
> DriveReady SeekComplete Error }
> Nov 13 23:31:20 linux kernel: hdc: packet command error: error=0x54 {
> AbortedCommand LastFailedSense=0x05 }
> Nov 13 23:31:20 linux kernel: ide: failed opcode was: unknown
>
> This is similar to report:
> http://lkml.org/lkml/2005/9/21/300  DMA broken in mainline 2.6.13.2
> _AND_ opensuse vendor 2.6.13-15
>
>
> Like the first reporter, I also have a LITEON SOHW-1693S DVD burner.
> Curiously enough mine works fine (burns and reads DVD's just fine).
> DMA on or DMA off makes no difference.
> Note the HDIO_GETGEO error below.
> Is there anything else I can probe to help track down this issue?

Try latest _vanilla_ kernel (2.6.15-rc1), if it still doesn't work
please fill the bug on http://bugme.osdl.org.

> linux:/home/bryce # lspci
> ...
> 00:04.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
>
> linux:/home/bryce # hdparm /dev/hdc
> /dev/hdc:
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  HDIO_GETGEO failed: Invalid argument
>
> linux:/home/bryce # hdparm -iI /dev/hdc
>
> /dev/hdc:
>
>  Model=LITE-ON DVDRW SOHW-1693S, FwRev=KS0B, SerialNo=
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2
>  AdvancedPM=no
>  Drive conforms to: device does not report version:
>
>  * signifies the current active mode
>
>
> ATAPI CD-ROM, with removable media
>         Model Number:       LITE-ON DVDRW SOHW-1693S
>         Serial Number:
>         Firmware Revision:  KS0B
> Standards:
>         Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
>         Supported: CD-ROM ATAPI-2
> Configuration:
>         DRQ response: 50us.
>         Packet size: 12 bytes
> Capabilities:
>         LBA, IORDY(cannot be disabled)
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=227ns  IORDY flow control=120ns
>
> linux:/home/bryce # uname -a
> Linux linux 2.6.13-15-default #1 Tue Sep 13 14:56:15 UTC 2005 i686
> athlon i386 GNU/Linux
