Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131202AbRCSJZK>; Mon, 19 Mar 2001 04:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRCSJYu>; Mon, 19 Mar 2001 04:24:50 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:57102 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S131202AbRCSJYl>; Mon, 19 Mar 2001 04:24:41 -0500
Message-ID: <3AB5D023.258B5DE5@idb.hist.no>
Date: Mon, 19 Mar 2001 10:23:47 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Leandro Bernsmuller <leberns@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: floppy programming
In-Reply-To: <20010318160105.11345.qmail@web1302.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leandro Bernsmuller wrote:
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

Go ahead.  Note that ordinary floppies store
the number of sectors per cylinder in the boot sector,
and this is used for easy conversion from
block number (from the fs) to head, cylinder
& sector (for the hardware driver)

You'll break this simple scheme, as you'll need
a table in the driver for how many sectors in track 0,
how many sectors in track 1, and so on up to
the maximum track which usually is 80 although
some floppy drives goes out to 83 or 89 or something.

>I want opinions about the idea, pleace.
>
>Where can I find information about floppy drivers
>programming, DMA setup,...?

Look at the existing floppy driver.  Note that
you don't need info on DMA etc., as the driver
already will do all sorts of weird sector layouts.
(look at the manpages for superformat)
The only limitation is that the current driver
likes to use the same number of sectors per track
for all cylinders, but you can change that
using a lookup table.

I am not sure this will help you though, as
pc floppies have constant rotational speed
and I bleieve a constant write rate too.
So you cannot really squeeze more onto the
outer tracks without some kind of hardware
modification.  

Well, maybe your drive
can gain a little extra on some cylinders if you
take variable head drag into consideration,
but you'll surely end up with a floppy that
fits one drive only if you go too close
to the rotational tolerances.


Helge Hafting
