Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291223AbSBLWiW>; Tue, 12 Feb 2002 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291225AbSBLWiN>; Tue, 12 Feb 2002 17:38:13 -0500
Received: from [63.231.122.81] ([63.231.122.81]:31827 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291223AbSBLWiG>;
	Tue, 12 Feb 2002 17:38:06 -0500
Date: Tue, 12 Feb 2002 15:33:37 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ville Herva <vherva@twilight.cs.hut.fi>, Bill Davidsen <davidsen@tmr.com>,
        Padraig Brady <padraig@antefacto.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020212153337.S9826@lynx.turbolabs.com>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Bill Davidsen <davidsen@tmr.com>,
	Padraig Brady <padraig@antefacto.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C695035.6040902@antefacto.com> <Pine.LNX.3.96.1020212132711.6082B-100000@gatekeeper.tmr.com> <20020212140624.R9826@lynx.turbolabs.com> <20020212221025.GH1105@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020212221025.GH1105@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Wed, Feb 13, 2002 at 12:10:26AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  00:10 +0200, Ville Herva wrote:
> On Tue, Feb 12, 2002 at 02:06:24PM -0700, you [Andreas Dilger] wrote:
> > 
> > You can also extract it from an uncompressed kernel (vmlinux) or the
> > module with "strings <file> | grep '[A-Z]*=[ym]$'".  It is simple
> > enough to search for the gzip magic (1f 8b 08 00 at about 16-18kB)
> > in a zImage or bzImage, and then pipe it to gunzip and strings as above.

Just as a clarification, the module configs can be stored in the short form:

EXPERIMENTAL=y
MODULES=y
PCI=y
:
:

I checked, in my current kernel/modules nothing matches the above regexp,
and even if it did, having a garbage config value wouldn't be fatal.

> Such script could live in /usr/src/linux/scripts. The same script could
> perhaps extract the version string as well. Anybody got a clue how to find
> it reliably? Is this reliable 
> 
> strings /boot/bzImage |
>  egrep '^[0-9]+\.[0-9]\.+.*\(.*@.*\).*[0-9]+:[0-9]+:[0-9]+' | 
>  head -1

This will work for the bzImage, but not the uncompressed kernel.  If you
remove the "^" (start of line) requirement it works for both:

egrep '[0-9]+\.[0-9]\.+.*\(.*@.*\).*[0-9]+:[0-9]+:[0-9]+'

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

