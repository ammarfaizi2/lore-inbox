Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQKTMdj>; Mon, 20 Nov 2000 07:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbQKTMd3>; Mon, 20 Nov 2000 07:33:29 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9226
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129851AbQKTMdO>; Mon, 20 Nov 2000 07:33:14 -0500
Date: Mon, 20 Nov 2000 04:02:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "T. Yamada" <tai@tasogare.imasy.or.jp>
cc: Andries Brouwer <aeb@veritas.com>, tai@imasy.or.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old
 BIOS
In-Reply-To: <200011201159.eAKBxnq07622@tasogare.imasy.or.jp>
Message-ID: <Pine.LNX.4.10.10011200402430.22419-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed now and working on it..


On Mon, 20 Nov 2000, T. Yamada wrote:

> 
> > Both disks claim support for the Host Protected Area feature set.
> > No doubt early disks had firmware flaws.
> 
> So it's yet another "borken hardware"... Is there anything like
> SCSI "blacklist" for IDE driver? Then it could be handled easily
> by registering the drive there and check that out before autodetection.
> 
> > - The routine idedisk_supports_host_protected_area()
> > should look at bit 10 of command_set_1, but it does a "& 0x0a".
> 
> Oh, no. Thanks for catching that. It should obviously be 0x0400.
> 
> # I guess it got converted in a way like this: 10th bit -> 10 -> 0x0a. Ugh.
> 
> > - The assignment "hd_cap = hd_max;" is one off:
> 
> Now that explains one missing sector reported previously. Yes,
> ATA spec says that the command returns "maximum address", not
> number of sectors.
> 
> I'll make a fix and resend a patch - or since the fix is so
> simple, I guess Andre can just add these fixes to IDE driver directly.
> 
> --
> Taisuke Yamada <tai@imasy.or.jp>
> PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
