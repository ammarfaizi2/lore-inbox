Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280807AbRKYKPe>; Sun, 25 Nov 2001 05:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280808AbRKYKP1>; Sun, 25 Nov 2001 05:15:27 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9970
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280807AbRKYKPI>; Sun, 25 Nov 2001 05:15:08 -0500
Date: Sun, 25 Nov 2001 02:15:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Flavio Stanchina <flavio.stanchina@tin.it>, linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011125021500.A30336@mikef-linux.matchmail.com>
Mail-Followup-To: Flavio Stanchina <flavio.stanchina@tin.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20212.1006507727@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain> <20011123094313.GB190@tolot.miese-zwerge.org> <20011123103338.BXVP10632.fep40-svc.tin.it@there> <20011123110505.A27707@alcove.wittsend.com> <20011123130820.D17332@mikef-linux.matchmail.com> <20011123185407.A3499@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20011123185407.A3499@alcove.wittsend.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2001 at 06:54:07PM -0500, Michael H. Warfield wrote:
> On Fri, Nov 23, 2001 at 01:08:20PM -0800, Mike Fedyk wrote:
> > On Fri, Nov 23, 2001 at 11:05:05AM -0500, Michael H. Warfield wrote:
> > > On Fri, Nov 23, 2001 at 11:33:38AM +0100, Flavio Stanchina wrote:
> > > > On Friday 23 November 2001 10:43, Jochen Striepe wrote:
> > > > 
> > > > > I am *much* more irritated by:
> > > > >
> > > > > $ uname -r
> > > > > 2.4.15-greased-turkey
> > > 
> > > > So I guess you are vegetarian. Try changing to "2.4.15-tasteful-salad".
> > > 
> > > 	Point is that it BROKE some things....  Like "make install" on
> > > RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turkey,
> > > breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
> > > like you expected it to be.  Not funny.  Just had three freeswan
> > > kinstall builds blow up because of that.
> > > 
> > > 	Now got to go back and fix it and rebuild.
> 
> > OMFG!
> 
> > How can you *not* point to the /boot/vmlinuz symlink?!!!  It points directly
> > to the latest kernel. And, /boot/vmlinuz.old points to the previous kernel.
> 
> 	Clue alert...
> 
> 	The PRIMARY link goes to vmlinuz.  The backup links go to the
> specific versions (the install script even facilitates this for you
> by installing it there).  That way, when you end up with a radioactive
> version, you can boot your prior version and recover from the disaster.
>

Lets see...

/boot/vmlinuz -> vmlinuz-2.4.15-pre7
/boot/vmlinuz.old -> vmlinuz-2.4.15-pre7.old

That looks like new, and old to me...

> > Here are some examples:  This is *just too simple*!!!
> 
> 	I typically keep 4 to six fall back versions in each of the
> 2.2 and 2.4 lines active and want (or occasionally need) to target specific
> versions, especially when I'm testing preX kernels and my device driver.
> You are way TOO simple.
>

$ ls /boot|grep -c vmlinuz
39

All right...

I sortened my answer to fix your specific problem, but grub is working great
for this too...

There's also a nice util provided by the debian grub package that keeps this
up to date.  All you have to do is modify your shutdown scripts, or modify
/sbin/installkernel

My response was terse, I admit.  I must ask you though, why were you
complaining about boot loader settings that you say is already setup
correctly?

/boot/grub/menu.lst:
# By default, boot the first entry after five seconds.
default         0
timeout         5

# Pretty colours
color cyan/blue white/blue

#
# examples
#
# title		Windows 95/98/NT/2000
# root		(hd0,0)
# makeactive
# chainloader	+1
#
# title		Linux
# root		(hd0,1)
# kernel	/vmlinuz root=/dev/hda2 ro
#

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

# rootflags=data=journal
### BEGIN AUTOMAGIC KERNELS LIST
# lines between the AUTOMAGIC KERNELS LIST markers will be modified
# by the debian update-grub script except for the default optons below
# DO NOT UNCOMMENT THEM, Just edit them to your needs

# ## Start Default Options ##
# default kernel options
# kopt=root=/dev/hda1 ro vga=extended
# default grub root device
# groot=(hd0,0)
# default should update-grub add recovery options to menu
# recovery=true
# ## End Default Options ##

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+xsched+elevator
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+xsched+elevator root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+xsched+elevator (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+xsched+elevator root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+ext3_0.9.14-2414p8+elevator+preempt-p7
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+ext3_0.9.14-2414p8+elevator+preempt-p7 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+ext3_0.9.14-2414p8+elevator+preempt-p7 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+ext3_0.9.14-2414p8+elevator+preempt-p7 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+elevator+preempt-p7+xsched
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+elevator+preempt-p7+xsched root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre8+netdev_random-p7+elevator+preempt-p7+xsched (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre8+netdev_random-p7+elevator+preempt-p7+xsched root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre7+xsched+ext3_0.9.14-2414p5+netdev_random root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre6+xsched
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6+xsched root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre6+xsched (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6+xsched root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre6+ext3_0.9.14-2414p5
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6+ext3_0.9.14-2414p5 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre6+ext3_0.9.14-2414p5 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6+ext3_0.9.14-2414p5 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-pre6
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-pre6 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-pre6 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14-ext3-2.4-0.9.14-2414p8
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-ext3-2.4-0.9.14-2414p8 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14-ext3-2.4-0.9.14-2414p8 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14-ext3-2.4-0.9.14-2414p8 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.14
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.14 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.14 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2+account-rand-cleanup
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2+account-rand-cleanup root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2+account-rand-cleanup (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2+account-rand-cleanup root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac11+smp+preempt+vm_hogstop.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac11+smp+preempt+vm_hogstop.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac11+smp+preempt+vm_hogstop.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac11+smp+preempt+vm_hogstop.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac11+smp+preempt+vm_hogstop
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac11+smp+preempt+vm_hogstop root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac11+smp+preempt+vm_hogstop (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac11+smp+preempt+vm_hogstop root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac10-smp-preempt.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac10-smp-preempt.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac10-smp-preempt.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac10-smp-preempt.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac10-smp-preempt
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac10-smp-preempt root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac10-smp-preempt (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac10-smp-preempt root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac10
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac10 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac10 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac10 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac4.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac4.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac4.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac4.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac4
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac4 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac4 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac4 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.4.10-ac3
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac3 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.4.10-ac3 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.4.10-ac3 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.2.20pre10_raid-2219A1_ext3-007a_eide-05042001
root		(hd0,0)
kernel		/boot/vmlinuz-2.2.20pre10_raid-2219A1_ext3-007a_eide-05042001 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.2.20pre10_raid-2219A1_ext3-007a_eide-05042001 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.2.20pre10_raid-2219A1_ext3-007a_eide-05042001 root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.2.19.old
root		(hd0,0)
kernel		/boot/vmlinuz-2.2.19.old root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.2.19.old (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.2.19.old root=/dev/hda1 ro vga=extended rootflags=data=journal single

title		Debian GNU/Linux, kernel 2.2.19
root		(hd0,0)
kernel		/boot/vmlinuz-2.2.19 root=/dev/hda1 ro vga=extended rootflags=data=journal

title		Debian GNU/Linux, kernel 2.2.19 (recovery mode)
root		(hd0,0)
kernel		/boot/vmlinuz-2.2.19 root=/dev/hda1 ro vga=extended rootflags=data=journal single

### END DEBIAN AUTOMAGIC KERNELS LIST

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=update-grub

#!/bin/sh
#
# Insert a list of installed kernels in a grub menu.lst file
#   Copyright 2001 Wichert Akkerman <wichert@linux.com>
#
# This file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# Contributors:
#	Jason Thomas <jason@debian.org>
#	David B.Harris <dbarclay10@yahoo.ca>
#	Marc Haber <mh@zugschlus.de>
#	Crispin Flowerday <crispin@zeus.com>

## StartOPTIONS
# name of file menu is stored in
menufile="menu.lst"

# directory's to look for the grub installation and the menu file
grubdirs="/boot/grub /boot/boot/grub"

# Default kernel options, overidden by the kopt statement in the menufile.
kopt="root=/dev/hda1 ro"

# Drive(in GRUB terms) where the kernel is located. If a seperate
# partition, this would be mounted under /boot, overridden by the kopt statement in menufile
groot="(hd0,0)"

# should grub create the alternative boot options in the menu
alternative="true"

# should grub lock the alternative boot options in the menu
lockalternative="false"

# options to use with the alternative boot options
altoptions="(recovery mode) single"

# Default options to use in a new menu.lst . This will only be used if menu.lst
# doesn't already exist. Only edit the lines between the two "EOF"s. The others are
# part of the script.
newtemplate=$(tempfile)
cat > "$newtemplate" <<EOF
## default num
# Set the default entry to the entry number NUM. Numbering starts from 0, and
# the entry number 0 is the default if the command is not used.
#
# You can specify 'saved' instead of a number. In this case, the default entry
# is the entry saved with the command 'savedefault'.           
default		0

## timeout sec
# Set a timeout, in SEC seconds, before automatically booting the default entry
# (normally the first entry defined).
timeout		5

# Pretty colours
color cyan/blue white/blue

## password ['--md5'] passwd
# If used in the first section of a menu file, disable all interactive editing
# control (menu entry editor and command-line)  and entries protected by the
# command 'lock'
# e.g. password topsecret
#      password --md5 \$1\$gLhU0/\$aW78kHK1QfV3P2b2znUoe/
# password topsecret

#
# examples
#
# title		Windows 95/98/NT/2000
# root		(hd0,0)
# makeactive
# chainloader	+1
#
# title		Linux
# root		(hd0,1)
# kernel	/vmlinuz root=/dev/hda2 ro
#

EOF
## End OPTIONS

# Make sure we use the standard sorting order
LC_COLLATE=C
# Magic markers we use
start="### BEGIN AUTOMAGIC KERNELS LIST"
end="### END DEBIAN AUTOMAGIC KERNELS LIST"

# Abort on errors
set -e

abort() {
	echo >&2
	echo "$@" >&2
	echo >&2
	exit 1
}

# Compares two version strings A and B
# Returns -1 if A<B
#          0 if A==B
#          1 if A>B
# This compares version numbers of the form
# 2.4.14-random > 2.4.14-ac10 > 2.4.14 > 2.4.14-pre2 > 
# 2.4.14-pre1 > 2.4.13-ac99
CompareVersions()
{
	# First split the version number and remove any '.' 's or dashes
	v1=$(echo $1 | sed -e 's![^0-9]\+! & !g' -e 's![\.\-]!!g')
	v2=$(echo $2 | sed -e 's![^0-9]\+! & !g' -e 's![\.\-]!!g')

	# also convert ac -> 50, pre -> -50 and anything else to 99
	v1=$(echo $v1 | sed -e 's!ac!50!g' -e 's!pre!-50!g' -e 's![^-0-9 ]\+!99!g')
	v2=$(echo $v2 | sed -e 's!ac!50!g' -e 's!pre!-50!g' -e 's![^-0-9 ]\+!99!g')

	result=0; v1finished=0; v2finished=0;
	while [ $result -eq 0 -a $v1finished -eq 0 -a $v2finished -eq 0 ];
	do
		if [ "$v1" = "" ]; then
			v1comp=0; v1finished=1
		else
			set -- $v1; v1comp=$1; shift; v1=$*
		fi

		if [ "$v2" = "" ]; then
			v2comp=0; v2finished=1
		else
			set -- $v2; v2comp=$1; shift; v2=$*
		fi

		if   [ $v1comp -gt $v2comp ]; then result=1
		elif [ $v1comp -lt $v2comp ]; then result=-1
		fi
	done

	# finally return the result
	echo $result
}

echo  -n "Searching for GRUB installation directory ... "

for d in $grubdirs ; do
	if [ -d "$d" ] ; then
		dir="$d"
		break
	fi
done

if [ -z "$dir" ] ; then
	abort "GRUB is not installed. To install grub, you may use the 'grub-install' command"
else
	echo "found: $dir ."
fi

echo -n "Testing for an existing GRUB menu.list file... "

# Test if our menu file exists
if [ -f "$dir/$menufile" ] ; then
	menu="$dir/$menufile"
	unset newtemplate
	echo "found: $menu ."
else
	# if not ask user if they want us to create one
	menu="$dir/$menufile"
	echo
	echo
	echo -n "Could not find $menu file. "
	echo -n "Would you like one generated for you? "
	echo -n "(y/N) "
	read answer
	case "$answer" in
		y* | Y*)
		cat "$newtemplate" > $menu
		unset newtemplate
		;;
		*)
		abort "Not creating menu.lst as you wish"
		;;
	esac
fi

# Extract the kernel options to use
tmp=$(sed -ne 's/# kopt=\(.*\)/\1/p' $menu)
[ -z "$tmp" ] || kopt="$tmp"

# Extract the grub root
tmp=$(sed -ne 's/# groot=\(.*\)/\1/p' $menu)
[ -z "$tmp" ] || groot="$tmp"

# Extract the old recovery value
tmp=$(sed -ne 's/# recovery=\(.*\)/\1/p' $menu)
[ -z "$tmp" ] || alternative="$tmp"

# Extract the alternative value
tmp=$(sed -ne 's/# alternative=\(.*\)/\1/p' $menu)
[ -z "$tmp" ] || alternative="$tmp"

# Extract the lockalternative value
tmp=$(sed -ne 's/# lockalternative=\(.*\)/\1/p' $menu)
[ -z "$tmp" ] || lockalternative="$tmp"

# Generate the menu options we want to insert
buffer=$(tempfile)
echo $start >> $buffer
echo "## lines between the AUTOMAGIC KERNELS LIST markers will be modified" >> $buffer
echo "## by the debian update-grub script except for the default optons below" >> $buffer
echo >> $buffer
echo "## DO NOT UNCOMMENT THEM, Just edit them to your needs" >> $buffer
echo >> $buffer
echo "## ## Start Default Options ##" >> $buffer

echo "## default kernel options" >> $buffer
echo "## e.g. kopt=\"root=/dev/hda1 ro\"" >> $buffer
echo "# kopt=$kopt" >> $buffer
echo >> $buffer

echo "## default grub root device" >> $buffer
echo "## e.g. groot=(hd0,0)" >> $buffer
echo "# groot=$groot" >> $buffer
echo >> $buffer

echo "## should update-grub create alternative boot options" >> $buffer
echo "## e.g. alternative=true" >> $buffer
echo "##      alternative=false" >> $buffer
echo "# alternative=$alternative" >> $buffer
echo >> $buffer

echo "## should update-grub lock alternative boot options" >> $buffer
echo "## e.g. lockalternative=true" >> $buffer
echo "##      lockalternative=false" >> $buffer
echo "# lockalternative=$lockalternative" >> $buffer
echo >> $buffer

echo "## altoption boot targets option" >> $buffer
echo "## multiple altoptions lines are allowed" >> $buffer
echo "## e.g. altoptions=(extra menu suffix) extra boot options" >> $buffer
echo "##      altoptions=(recovery mode) single" >> $buffer

if ! grep -q "^# altoptions" $menu ; then
	echo "# altoptions=$altoptions" >> $buffer
else
	grep "^# altoptions" $menu >> $buffer
fi

echo >> $buffer

echo "## ## End Default Options ##" >> $buffer
echo >> $buffer

sortedKernels=""
for kern in $(/bin/ls -1vr /boot/vmlinuz-*) ; do
	# found a kernel
	newerKernels=""
	for i in $sortedKernels ; do
		res=`CompareVersions "$kern" "$i"`;
		if [ "$kern" != "" -a $res -gt 0 ] ; then
			newerKernels="$newerKernels $kern $i"
			kern=""
		else
			newerKernels="$newerKernels $i"
		fi
	done
	if [ "$kern" != "" ] ; then
		newerKernels="$newerKernels $kern"
	fi
	sortedKernels="$newerKernels"
done

for kern in $sortedKernels ; do
	kernelName=$(basename $kern)
	kernelVersion=$(echo $kernelName | sed -e 's/vmlinuz-//')

	if mount | grep -qs "on /boot " > /dev/null 2>&1 ; then
		kernel=/$kernelName
		initrd=/initrd-$kernelVersion
	else
		kernel=/boot/$kernelName
		initrd=/boot/initrd-$kernelVersion
	fi

	echo "title		Debian GNU/Linux, kernel $kernelVersion" >> $buffer
	echo "root		$groot" >> $buffer
	echo "kernel		$kernel $kopt"  >> $buffer
	if [ -e /boot/initrd-$kernelVersion ]; then
		echo "initrd		$initrd" >> $buffer
	fi
	echo "savedefault" >> $buffer
	echo >> $buffer

	# insert the alternative boot options
	if test ! x"$alternative" = x"false" ; then
		# for each altoptions line do this stuff
		sed -ne 's/# altoptions=\(.*\)/\1/p' $buffer | while read line; do
			descr=$(echo $line | sed -ne 's/\(([^)]*)\)[[:space:]]\(.*\)/\1/p')
			suffix=$(echo $line | sed -ne 's/\(([^)]*)\)[[:space:]]\(.*\)/\2/p')
			echo "title		Debian GNU/Linux, kernel $kernelVersion $descr" >> $buffer
			# lock the alternative options
			if test x"$lockalternative" = x"true" ; then
				echo "lock" >> $buffer
			fi
			echo "root		$groot" >> $buffer
			echo "kernel		$kernel $kopt $suffix"  >> $buffer
			if [ -e /boot/initrd-$kernelVersion ]; then
				echo "initrd		$initrd" >> $buffer
			fi
			echo "savedefault" >> $buffer
			echo >> $buffer
		done
	fi
done

echo $end >> $buffer

echo -n "Updating $menu ... "
# Insert the new options into the menu
if ! grep -q "^$start" $menu ; then
	cat $buffer >> $menu
else
	umask 077
	sed -e "/^$start/,/^$end/{
	/^$start/r $buffer
	d
	}
	" $menu > $menu.new
	cat $menu.new > $menu
	rm -f $buffer $menu.new
fi
echo "done"
echo

if [ ! -z $answer ]; then
cat <<EOF

Please note that configuration parameters for GRUB are stored in
$menu . You must edit this file in order to set the options
which GRUB passes to the kernel, as well as the drive which GRUB looks in to
for the kernel.

Everything on the line after "kopt=" is passed to the kernel as parameters,
and "groot=" must be set to the partition(in GRUB terms, such as "(hd0,0)")
which GRUB will load the kernel from.

After you have edited $menu , please re-run 'update-grub'.
EOF
fi

--J/dobhs11T7y2rNN--
