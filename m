Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTBYLZs>; Tue, 25 Feb 2003 06:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbTBYLZs>; Tue, 25 Feb 2003 06:25:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60943 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267925AbTBYLZr>; Tue, 25 Feb 2003 06:25:47 -0500
Date: Tue, 25 Feb 2003 11:35:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ville Herva <vherva@niksula.cs.hut.fi>,
       Mikael Starvik <mikael.starvik@axis.com>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'tinglett@vnet.ibm.com'" <tinglett@vnet.ibm.com>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225113557.C9257@flint.arm.linux.org.uk>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mikael Starvik <mikael.starvik@axis.com>,
	"'Randy.Dunlap'" <rddunlap@osdl.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'tinglett@vnet.ibm.com'" <tinglett@vnet.ibm.com>,
	"'torvalds@transmeta.com'" <torvalds@transmeta.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225110704.GD159052@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Tue, Feb 25, 2003 at 01:07:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:07:04PM +0200, Ville Herva wrote:
> On Tue, Feb 25, 2003 at 09:25:20AM +0000, you [Russell King] wrote:
> > Agreed - zImage is already around 1MB on many ARM machines, and since
> > loading zImage over a serial port using xmodem takes long enough
> > already, this is one silly feature I'll definitely keep out of the
> > ARM tree.
> 
> Why not make it a config option (like the other (two? three?) rejected
> patches that implemented this did)?

I, for one, do not see any point in trying to put more and more crap
into one file, when its perfectly easy to just use the "cp" command
to produce the same end result, namely a copy of zImage, System.map
and configuration, thusly:

cp arch/$ARCH/boot/zImage /boot/vmlinuz-$VERSION
cp .config /boot/config-$VERSION
cp System.map /boot/System.map-$VERSION

No hastles with configuration options.  No hastles with bloated zImage
files.  No hastles with adding extra stuff to makefiles to do special
mangling to zImage.

If people are worried about vmlinuz being out of step with config, once
you add the above to the installation target of the kernel makefile,
unless you do things manually, you won't get out of step.

If you're worried about config-* and System.map-* being out of step with
the kernel you're running, exactly the same applies to the "everything
in one file" version as well.

If you need to make a backup of it:

mkdir /boot/old
cp /boot/*-$VERSION /boot/old

Nice.  Simple.  No crap.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
