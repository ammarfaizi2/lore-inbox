Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRHYQ23>; Sat, 25 Aug 2001 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269632AbRHYQ2U>; Sat, 25 Aug 2001 12:28:20 -0400
Received: from pioneer.oftheInter.net ([216.61.42.221]:9744 "HELO
	pioneer.oftheInter.net") by vger.kernel.org with SMTP
	id <S269646AbRHYQ2H>; Sat, 25 Aug 2001 12:28:07 -0400
Date: Sat, 25 Aug 2001 11:28:12 -0500
From: Taylor Carpenter <taylorcc@codecafe.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
Message-ID: <20010825112812.A31755@pioneer.oftheInter.net>
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net> <200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca> <20010821223042.A30478@pioneer.oftheInter.net> <200108220507.f7M576q25412@vindaloo.ras.ucalgary.ca> <20010822191227.A11226@pioneer.oftheInter.net> <200108230505.f7N55sr05856@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108230505.f7N55sr05856@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Aug 22, 2001 at 11:05:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 11:05:54PM -0600, Richard Gooch wrote:
> Taylor Carpenter writes:
> >
> You mean the floppy module gets loaded as a result of the mountall
> script being run?

As far as I can tell, when it runs mount -avt, the floppy module
is loaded if there is an entry in /etc/fstab for /dev/fd0 (even w/the noauto
option).
 
> Is the /etc/modules.devfs the one that ships with devfsd?
> Specifically, you need the following line:
> alias     /dev/floppy		floppy

I do not have a modules.devfs.  I do have a /etc/modutils/devfsd, but it does
not have an alias entry for the floppy.

I added the entry, and it now shows up in modules.conf.

> and of course the MODLOAD action in /etc/devfsd.conf.

I did not have anything specific to /dev/fd* in devfsd.conf, but I did have a
.* entry to load it.  I commented that out, after your other email.

I added /dev/fd0, and /dev/floppy MODLOAD but it is still not autoloading.
 
> Do you mean to say that the Oops happens during the boot sequence,
> before you can log in?

Yes, the oops happens during boot when it runs the mountall script, and then
right after when something else tries to access the device.  I did not mention
before, but devfsd will not run after I get this oops.  Or I should say it
dies, and then I can not run it again after logging in.  I get an oops
everytime I access the floppy device after this, but I only get an oops if I
get one during boot.

> You must have a bogus /etc/devfsd.conf or /etc/modules.devfs file for
> module autoloading not to work.

I had commented out the .* MODLOAD, it worked before that.  I uncommented the
.* and it still does not work, something else must have changed.

> I don't know what a "perms" file is. I know Debian uses some
> convoluted directory tree for devfsd configuration, but frankly, I
> don't want to know about that. If you have one of these monstrosities,
> please collapse them all into a single /etc/devfsd.conf file a report
> based on that.

OK.  I have nothing but REGISTER PERMISSIONS for floppy in devfsd.conf.

> > I have many LOOKUP entries.  I did not have any specific to
> > /dev/fd*, but that was caught by the .* LOOKUP entry.  I commented
> > that out, which is probably why mdir and other commands do not work
> > w/o manually loading floppy.o.
> 
> Oh! Well, duh!

I uncommented .* LOOKUP and it still did not autoload.

> Hm. Please try a virgin 2.4.9 kernel with CONFIG_DEVFS_FS=n and try
> again. I have this feeling that I'm chasing someone else's bug...

OK, done.  I did not get the oops with DEVFS turned off (in 2.4.9).

