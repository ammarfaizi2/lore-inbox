Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281428AbRKHDx6>; Wed, 7 Nov 2001 22:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281439AbRKHDxs>; Wed, 7 Nov 2001 22:53:48 -0500
Received: from toscano.org ([64.50.191.142]:60361 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S281428AbRKHDxg>;
	Wed, 7 Nov 2001 22:53:36 -0500
Date: Wed, 7 Nov 2001 22:53:28 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011107225328.A18371@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE870EF.2080508@gutschke.com> <20011106155934.B12661@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106155934.B12661@kroah.com>
User-Agent: Mutt/1.3.23i
X-Unexpected: The Spanish Inquisition
X-Uptime: 10:49pm  up 10 days,  5:18,  4 users,  load average: 0.08, 0.07, 0.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case it matters any, here's the Clie (760C) part of my
/proc/bus/usb/devices:

T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=054c ProdID=0066 Rev= 1.00
S:  Manufacturer=Sony Corp.
S:  Product=Palm Handheld
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

I'll also be a test monkey for the patch.

pete

On Tue, 06 Nov 2001, Greg KH wrote:

> On Wed, Nov 07, 2001 at 12:23:27AM +0100, Stephan Gutschke wrote:
> > there you go,  the output from  /proc/bus/usb/devices
> > By the way I have an Clie N710C which is upgraded
> > to an 760 with OS 4.1S, shouldnt make a difference,
> > but I just wanted to let you know.
> 
> Ah, that might make the difference.  It looks like the number of
> endpoints is different on this device, than any other 4.x Clie devices
> (they should have 4 bulk endpoints.)  The older devices have 2 endpoints
> (endpoints are usually done in hardware)
> 
> This Clie is reporting to the driver that it _does_ have 2 "ports" (a
> port is 2 endpoint pairs in this scheme), but in reality, it doesn't.
> The lying device is then causing the driver to oops when it tries to
> write to a port that isn't even there.
> 
> I'm going to have to rework the driver to fix this problem, give me a
> day or so to come up with a solution.  Are you willing to try a patch
> when I have something?
> 
> Thanks for the good error reporting, it really helped.
> 
> greg k-h
