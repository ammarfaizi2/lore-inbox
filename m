Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272166AbRHWAMh>; Wed, 22 Aug 2001 20:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272168AbRHWAM1>; Wed, 22 Aug 2001 20:12:27 -0400
Received: from pioneer.oftheInter.net ([216.61.42.221]:61202 "HELO
	pioneer.oftheInter.net") by vger.kernel.org with SMTP
	id <S272166AbRHWAMN>; Wed, 22 Aug 2001 20:12:13 -0400
Date: Wed, 22 Aug 2001 19:12:27 -0500
From: Taylor Carpenter <taylorcc@codecafe.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
Message-ID: <20010822191227.A11226@pioneer.oftheInter.net>
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net> <200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca> <20010821223042.A30478@pioneer.oftheInter.net> <200108220507.f7M576q25412@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108220507.f7M576q25412@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Tue, Aug 21, 2001 at 11:07:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 11:07:06PM -0600, Richard Gooch wrote:
> Taylor Carpenter writes:
> > 
> Well, the following line suggests a devfs interaction (provided you
> are sure that you used the correct System.map:
> > Trace; c015469b <devfs_unregister_blkdev+12eb/1960>

I can check again, but I am fairly certain it was the correct System.map (I
looked before and after when running ksymoops).

> Are you unloading the floppy driver at some point? Or using module
> autoloading?

I am using module autoloading.  It seems that right after the mountall script
is called this happens.


> Interesting. What happens if you use /dev/floppy/0 instead of /dev/fd0
> in the /etc/fstab? Still an Oops?

I will try that...  

I did not get the oops, but I could not access the device until I manually
loaded the floppy module (the /dev/fd0 was created as usual).

After booting w/the floppy module not loaded I can start and stop devfsd and
load and unload the floppy module in any order w/o an oops. I only get the
oops if the module is loaded during boot.

Also when I get the oops during boot, the floppy module is not loaded once the
system is through booting and I login, but /dev/fd* are all there!  With out
the oops /dev/fd* is only there when I load the floppy module (and disappears
as usual when I rmmod the module).


> Strange. I tried the following sequence, without problems:
> # devfsd /dev
> # mount /floppy
> # ls -lF /dev/floppy

I could not mount the floppy until I manually loaded the floppy module!  This
is after editing /etc/fstab as you said below.

> 
> where /etc/fstab has:
> /dev/floppy/0  /floppy  ext2  defaults,noauto,user  0 0
> 
> I have nothing in my /etc/devfsd.conf which refers to the floppy.

I only reference floppy in my perms file.

> In addition, I don't have any LOOKUP entries. I did this with 2.4.9 with
> devfs-patch-v188.

I have many LOOKUP entries.  I did not have any specific to /dev/fd*, but that
was caught by the .* LOOKUP entry.  I commented that out, which is probably
why mdir and other commands do not work w/o manually loading floppy.o.

> Could you please try reproducing the problem with the setup and sequence I
> used?

I believe I followed your steps, and had no oops during boot w/the /etc/fstab
change.  I do not think that made the difference though.  I think telling
devfsd to not autoload floppy is what let me boot w/o oops.  So I think there
still is a problem w/loading the floppy module during boot.
