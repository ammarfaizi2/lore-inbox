Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbQJaEoD>; Mon, 30 Oct 2000 23:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130243AbQJaEn4>; Mon, 30 Oct 2000 23:43:56 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:35079
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130214AbQJaEno>; Mon, 30 Oct 2000 23:43:44 -0500
Date: Mon, 30 Oct 2000 21:42:07 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Steven Walter <srwalter@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UDMA/66 Data Corruption on SiS530
In-Reply-To: <20001031040805.24819.qmail@web2103.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10010302136320.25785-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Steven Walter wrote:

> 
> Recently, when trying to use UDMA/66 on my SiS 530 and
> WD84AA, I got some data corruption.  At first, I tried
> with "UDMA Enabled" set to off in the BIOS, because I
> had known this to previously cause problems.  However,
> like this, I couldn't set the harddrive to use UDMA
> mode4 (-X68).  I would set it, it would appear
> successful, check with hdparm -i, and it would still
> say mode2.  Additionally, there was no speed increase
> after the -X68.

Check your logs and see if their is a speed setting block issued, only if
you are using patched 2.2x or 2.4.0x kernels will this report be
generated.

> Before, on a 40-conductor cable, I was getting 11MB/s
> with hdparm -t .  I bought an 80-conductor cable
> today, and saw no speed improvement in mode2, which is

This clear indicates a problem in the device pairing or you have not
enable the entire driver.

> the only mode I can set it to.  Something that striked
> me as odd about the cable, though, is that the red
> wire was broken between the Drive 1 socket and the
> Drive 0 socket.  Is this to differentiate the two?

Explain...

> Anyway, what's interesting is what happens after I
> turned "UDMA Enabled" on in the BIOS.  Upon booting,
> everything appeared normal until just before X
> started.  At this point, I got a
> 
> dma_intr: hda: status=0x58 { DriveReady SeekComplete
> Error}
> error=0x0 { }
> 
> I'm not sure about the numbers, but I am sure about
> the texts.  The drive said there was an error, but no
> error was set.  After fooling around with hdparm
> (setting the drive to -X68, timing it, etc) I got a
> few more identical errors.  Then, I started getting
> errors from EXT3-fs regarding invalid/corrupt data.

If you are using "EXT3-fs" journalling and your write cache is not
disable, you are TOAST!  I just now got the drive venders to auto-update
the contents of the identify page that reports the features set and
masked.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
