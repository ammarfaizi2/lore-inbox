Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRATW6D>; Sat, 20 Jan 2001 17:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbRATW5w>; Sat, 20 Jan 2001 17:57:52 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:8452
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129561AbRATW5j>; Sat, 20 Jan 2001 17:57:39 -0500
Date: Sat, 20 Jan 2001 14:57:07 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
In-Reply-To: <20010120215641.A1818@suse.cz>
Message-ID: <Pine.LNX.4.10.10101201301200.657-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Vojtech Pavlik wrote:

> On Sat, Jan 20, 2001 at 06:45:10PM +0000, Alan Chandler wrote:
> > On Thu, 20 Jan 2011 09:51:03 -0800 (PST), you wrote:
> > 
> > >On Sat, 20 Jan 2001, Alan Chandler wrote:
> > >
> > >> I'm running with an Abit K7 (uses via82c686a in southbridge) with IBM
> > >> deskstar 8.4gb disks (DHEA-38451) as masters in ide0 and 1. They only
> > >> do UDMA mode 2. I am not overclocking or anything - all should be
> > >> running at default speeds with an Athlon 900.  
> > >> 
> > >> Just to be clear - I am NOT getting any errors when I switch back to
> > >> the 2.2.17 kernel (debian standard) - with a 2.4.0 kernel they occur
> > >> every few minutes when there is significant disk activity. 
> > >
> > >But that kernel uses the stock driver that was the original second
> > >generation correct?
> > >
> > >Andre Hedrick
> > >Linux ATA Development
> > >
> > 
> > Sorry, I realise now what I said was ambiguous.  To be clear
> > 
> > 2.2.17 - absolutely standard as shipped in debian - no errors

This is with the original ide.2.2.17.??.date.patch and not the morfing
timing code you have started.

> > 2.4.0 - standard (downloaded tar.bz2) - ERRORS
> > 2.4.0 - as standard except for three files in tar.bz2 attachment to
> > Vojtech Pavlik's mail which were placed in drivers/ide directory -
> > ERRORS. 
> > Alan
> 
> Wonderful! A case where I can compare a working setup with a nonworking
> one! :) Could you please send me the usual stuff (dmesg, lspci -vvxxx,
> cat /proc/ide/via, hdparm -i /dev/hd*, hdparm -t /dev/hd*) for both the
> 2.2 case and the 2.4.0+VIA-latest case? That'll allow me to find the
> differences and possibly fix the new driver.

Vojtech, I worry that the dynamic timing that you are calculating could
bite you.  Timings are exact especially at modes 3/4/5 the margins go to
an effective zero for varition or wiggle room.  The state diagrams from
Quantum that created the Ultra DMA 0,1,2,3,4,5 show how darn tight it
constrained.  You need to assume absolutes because the various board
makers screw up the skew tables by the PCB lane traces.

By assuming only absolutes, all vendors that do bad designs will show and
the user can not and "should" not be allowed to hold the driver in a state
that can damage filesystems or lock the box.  Since I have never addressed
this issue in public it is no obvious why I hardcoded timings and did not
let tehm float, but I hope it is clearer now.

chipset ---\
            |
            \---------IDC-header

chipset ---+
           |
           +----------IDC-header

These are nearly the same but the corners cause bounce and iCRC's

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
