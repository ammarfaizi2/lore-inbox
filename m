Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRCWQct>; Fri, 23 Mar 2001 11:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRCWQcb>; Fri, 23 Mar 2001 11:32:31 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:6673 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131232AbRCWQcR>;
	Fri, 23 Mar 2001 11:32:17 -0500
Date: Fri, 23 Mar 2001 17:31:31 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: floppy programming
To: leberns@yahoo.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helge Hafting <helgehaf@idb.hist.no>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Message-id: <3ABB7A63.EA70D566@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leandro Bernsmuller (leberns@yahoo.com)

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

The floppy controller on PC is a rather "intelligent"
piece and there is not much to tweak.

It can't even read Amiga floppies, which are not that different.

The amiga controller on the other side is pretty "dumb" and you
can do tricks there ( I wrote a program/driver that could put
1120 kB on DD floppy ; theoretically 2240 kB on HD , but I never tried that )

But it can't change the data density either.

So IMO , you can't do anything useful on  PC hardware.

Actually you could instruct the controller to use 18 sectors on inner
tracks and foe example 20 on outer , but then you could just use 20 on all
tracks, which is actually done by people. Even linux supports them, look into
the floppy driver and it's documentation.


P.S.: Most of the replies you got on LKML are irrelevant or wrong :
Helge Hafting (helgehaf@idb.hist.no) wrote :

> Go ahead. Note that ordinary floppies store 
> the number of sectors per cylinder in the boot sector, 
> and this is used for easy conversion from 
> block number (from the fs) to head, cylinder 
> & sector (for the hardware driver) 

Irrelevant. The file system ( or any other user of the data )
will only see a sequence of blocks, no matter how they are
physically organized.
All modern hard disks use this technique ( "zone bit recording"
or "variable bit recording" , CDs use it too ) and
even DOS works with them :-)

> You'll break this simple scheme, as you'll need 
> a table in the driver for how many sectors in track 0, 
> how many sectors in track 1, and so on up to 
> the maximum track which usually is 80 although 
> some floppy drives goes out to 83 or 89 or something. 

You could just always use the same layout ( 18 sectors
on tracks 0-10 , 19 on 11 to 25 , etc ... )
Or sacrify a sector to store a layout ( which would off course
be invisible to anything , but your driver )



Richard B. Johnson (root@chaos.analogic.com) wrote :
 
> You need to look at data-books to see how the floppy controllers 
> actually work (NEC uPD765A/uPD765B). You can format tracks with 
> different numbers of sectors. However, when you read such a drive 
> you are stuck unless you have stored (somewhere) information about 
> the number of sectors each track contains. Otherwise, you have no 
> way of converting a logical offset into the correct head/cylinder/ 
> sector. You need to have set the correct head, to the correct 
> cylinder before you attempt to read a sector. 
> 
> Incidentally, for some dumb reason, sectors are numbered from 1 
> instead of 0. This adds code, not necessary, if sectors were 
> zero-based like all the other parameters. 

Irrelevant. Handled by the driver , if needed at all.
 
> The bit-rate can be set to 500/300/250/150/125 kb/s, but it's 
> not continuously variable. The bit-rate that will work with a drive 
> is dependent upon the characteristics of the head and the media. 
> 
> The head inductance is resonated with circuit capacitance at the 
> bit-rate at which it is to be used. This means that a 300 kb/s 
> drive will not function at 500 kb/s. 
> 
> The 'problem' you describe is as old as magnetic media itself. It 
> is a problem of "areal density". Spiral recording helps to some 
> extent. Basically, there is only one track, it spirals from the 
> outside to the inside. The spacing between sectors is adjusted 
> automatically because the on-media areal density increases as 
> the head(s) move towards the center of rotation (hub).

The same can be done with concentrical cylinders and is done
with all modern hard drives and was done also on the Commodore 64
5.25 inch floppies ( at least they used different number of sectors
per track , I don't know if the actual bit density was variable or not )

> You can't 
> do this with a floppy controller because the heads "step" to 
> discrete positions. 

So you do it with "classic" concentrical tracks.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
