Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282242AbRKWVIq>; Fri, 23 Nov 2001 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282243AbRKWVIg>; Fri, 23 Nov 2001 16:08:36 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35577
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282242AbRKWVI1>; Fri, 23 Nov 2001 16:08:27 -0500
Date: Fri, 23 Nov 2001 13:08:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Flavio Stanchina <flavio.stanchina@tin.it>, linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123130820.D17332@mikef-linux.matchmail.com>
Mail-Followup-To: Flavio Stanchina <flavio.stanchina@tin.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20212.1006507727@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain> <20011123094313.GB190@tolot.miese-zwerge.org> <20011123103338.BXVP10632.fep40-svc.tin.it@there> <20011123110505.A27707@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011123110505.A27707@alcove.wittsend.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 11:05:05AM -0500, Michael H. Warfield wrote:
> On Fri, Nov 23, 2001 at 11:33:38AM +0100, Flavio Stanchina wrote:
> > On Friday 23 November 2001 10:43, Jochen Striepe wrote:
> > 
> > > I am *much* more irritated by:
> > >
> > > $ uname -r
> > > 2.4.15-greased-turkey
> 
> > So I guess you are vegetarian. Try changing to "2.4.15-tasteful-salad".
> 
> 	Point is that it BROKE some things....  Like "make install" on
> RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turkey,
> breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
> like you expected it to be.  Not funny.  Just had three freeswan
> kinstall builds blow up because of that.
> 
> 	Now got to go back and fix it and rebuild.

OMFG!

How can you *not* point to the /boot/vmlinuz symlink?!!!  It points directly
to the latest kernel. And, /boot/vmlinuz.old points to the previous kernel.

Here are some examples:  This is *just too simple*!!!

Lilo:
image=/boot/vmlinuz
	label=vmlinuz
	read-only
#	restricted
	alias=1

image=/boot/vmlinuz.old
	label=vmlinuz-old
	read-only
	optional
	append="single"
#	restricted
	alias=3
			
Grub:
title           Debian GNU/Linux, Latest Kernel
root            (hd0,0)
kernel          /boot/vmlinuz root=/dev/hda1 ro vga=extended

title           Debian GNU/Linux, Latest Kernel (recovery mode)
root            (hd0,0)
kernel          /boot/vmlinuz root=/dev/hda1 ro single vga=extended

title           Debian GNU/Linux, Previous Kernel
root            (hd0,0)
kernel          /boot/vmlinuz.old root=/dev/hda1 ro vga=extended

title           Debian GNU/Linux, Previous Kernel (recovery mode)
root            (hd0,0)
kernel          /boot/vmlinuz.old root=/dev/hda1 ro single vga=extended

