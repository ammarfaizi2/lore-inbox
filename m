Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288440AbSADCBr>; Thu, 3 Jan 2002 21:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288450AbSADCBi>; Thu, 3 Jan 2002 21:01:38 -0500
Received: from svr3.applink.net ([206.50.88.3]:5129 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S288440AbSADCBc>;
	Thu, 3 Jan 2002 21:01:32 -0500
Message-Id: <200201040200.g0420PSr029316@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Alexander Viro <viro@math.psu.edu>, "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: LSB1.1: /proc/cpuinfo
Date: Thu, 3 Jan 2002 19:56:46 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Joerg Schilling <schilling@fokus.gmd.de>, anderson@metrolink.com,
        hch@caldera.de, lsb-discuss@lists.linuxbase.org,
        lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 January 2002 18:56, Alexander Viro wrote:
> On Thu, 3 Jan 2002, Eric S. Raymond wrote:
> > Well, hell.  If the "/proc is a blight on the face of the planet" ranting
> > that I've been hearing is just about the *name* /proc, then let's
> > separate the name issue from the content issue.
>
> It's more than just a name.
> 	a) granularity.  Current "all or nothing" policy in procfs has
> a lot of obvious problems.
> 	b) tree layout policy (lack thereof, to be precise).
> 	c) horribly bad layout of many, many files.  Any file exported by
> kernel should be treated as user-visible API.  As it is, common mentality
> is "it's a common dump; anything goes here".  Inconsistent across
> architectures for no good reason, inconsistent across kernel versions,
> just plain stupid, choke-full of buffer overruns...
>
> Fixing these problems will _hurt_.  Badly.  We have to do it, but it
> won't be fast and it certainly won't happen overnight.


Talking from the SysAdmin point of view, procfs is one of the truly
cool things which separates Linux from the others.   I'd rather tune
/proc/sys stuff than use sysctl or Solaris' funky /etc/system and
ndd crap.  It's the next best thing to "point and click" without going
over to the dark side.

Sure /system is a better name (extra typing becaue we can't have 
/sys/sys can we??).  

And while you all are  at it, why not take a look at some of the naming 
conventions that BeOS makes too.  I'm _not_ being sarcastic.    


Example1: Excellent devfs layout.

Example 2:  BeOS root directory is a ramfs off of which the
other drives/filesystems are mounted.   (I haven't thought 
this one out too much but I could image that it would make
some things easier.)

Example 3:  Kernel Modules are in the directory:
	/boot/beos/system/add-ons/kernel
Perhaps we could have directories something like:

/boot/kernel
/boot/grub
/boot/lilo
/dev	 using devfs !
/etc
/home
/system/config/sys
                    /net
/system/modules/kernelversion/ (modules in devfs similar tree)
/system/info  (for cpuinfo, ioports, meminfo, filesystems, etc.)
/sbin	(or even in /system/bin ???)
/tmp
/usr
/var

Example 3:    BeOS moves /usr/local stuff to more of a per user 
configuration where each user has a $HOME/config directory.
Of course, we would put things like .Xdefaults, kde, gnome, etc.
directories here which vary according to user while still keeping
/usr/local for all users.

My ~/config contains things like "find ~/config -type d | hand edit some"

config/add-ons/media/decoders
config/add-ons/media/encoders
config/add-ons/media/extractors
config/add-ons/media/writers
config/add-ons/net_server
config/be/Applications
config/be/Demos
config/be/Preferences
config/bin
config/boot		(Things my personal boot/login preferences)
config/doc
config/doc/postgresql
config/doc/postgresql/html
config/documentation
config/etc
config/fonts
config/include
config/include/openssl
config/include/postgresql
config/include/postgresql/lib
config/include/postgresql/libpq
config/lib
config/lib/perl5
config/lib/perl5/5.00503
config/lib/perl5/site_perl
config/lib/perl5/site_perl/5.005/BePC-beos
config/man
config/man/man1
config/servers
config/settings
config/settings/beos_mime
config/settings/beos_mime/application
config/settings/beos_mime/audio
config/settings/beos_mime/image
config/settings/beos_mime/message
config/settings/beos_mime/text
config/settings/beos_mime/video
config/share
config/share/postgresql
config/ssl
config/ssl/certs
config/ssl/lib
config/ssl/man
config/ssl/man/man1


Of course, on heavily user subscribed systems, some sort of
NT like COW technique might be nesc. if too many file duplications
occur in the ~/config directories.  Having a good /usr/local would
prevent much of this growth, at least in theory.  As would strict
quotas. :-)



Just some thoughts.

-- 
timothy.covell@ashavan.org.
