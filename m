Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCSOjN>; Mon, 19 Mar 2001 09:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbRCSOjD>; Mon, 19 Mar 2001 09:39:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38786 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129436AbRCSOir>; Mon, 19 Mar 2001 09:38:47 -0500
Date: Mon, 19 Mar 2001 09:22:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Leandro Bernsmuller <leberns@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: floppy programming
In-Reply-To: <20010318160105.11345.qmail@web1302.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1010319085157.2109A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Leandro Bernsmuller wrote:

> 
> Hi,
> 
> some body know if exist or is possible to do one
> driver
> to makes floppy drive use some type of "balanced" bits
> distribution?
> The idea is simple: format a disk doing inner tracks
> with less bits than
> in external tracks.
> Maybe is better think in sectors and not bits
> banlancing?
> 
> I want opinions about the idea, pleace.
> 
> Where can I find information about floppy drivers
> programming, DMA setup,...?
> 
> Thanks,

You need to look at data-books to see how the floppy controllers
actually work (NEC uPD765A/uPD765B). You can format tracks with
different numbers of sectors. However, when you read such a drive
you are stuck unless you have stored (somewhere) information about
the number of sectors each track contains. Otherwise, you have no
way of converting a logical offset into the correct head/cylinder/
sector. You need to have set the correct head, to the correct
cylinder before you attempt to read a sector.

Incidentally, for some dumb reason, sectors are numbered from 1
instead of 0. This adds code, not necessary, if sectors were
zero-based like all the other parameters.

The bit-rate can be set to 500/300/250/150/125 kb/s, but it's
not continuously variable. The bit-rate that will work with a drive
is dependent upon the characteristics of the head and the media.

The head inductance is resonated with circuit capacitance at the
bit-rate at which it is to be used. This means that a 300 kb/s
drive will not function at 500 kb/s.

The 'problem' you describe is as old as magnetic media itself. It
is a problem of "areal density". Spiral recording helps to some
extent. Basically, there is only one track, it spirals from the
outside to the inside. The spacing between sectors is adjusted
automatically because the on-media areal density increases as
the head(s) move towards the center of rotation (hub). You can't
do this with a floppy controller because the heads "step" to
discrete positions.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


