Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJETIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJETIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUJETIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:08:24 -0400
Received: from mail.dif.dk ([193.138.115.101]:46535 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261724AbUJETIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:08:19 -0400
Date: Tue, 5 Oct 2004 21:15:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Johnson, Richard" <rjohnson@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
In-Reply-To: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
Message-ID: <Pine.LNX.4.61.0410052100110.2913@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Johnson, Richard wrote:

> 
> 
> In order to use Linux version 2.6.x, I installed the
> stuff that came with the "Red Hat Fedora(tm) Linux 2"
> book. I even bought a new hard disk so that it wouldn't
> break anything I have on my other disks.
> 
> It installed, but I needed to set up a module development
> environment so I attempted to compile the kernel with
> the provided files.
> 
> First I copied a .config file from /usr/src/linux-2.6.5-1.358/configs
> that came with the other software. Then I did:
> 
> make oldconfig
> make bzImage
> make modules
> make modules_install
> 

$ make oldconfig
$ make
$ su
# make modules_install 

is the normal way for 2.6 kernels. A plain "make" takes care of all the 
magic of building the kernel proper and the modules.


> This seemed to go alright. Then I entered:
> 
> make install
> 

Only do that if you are sure your systems bootloader configuration is able 
to deal with it. Maybe Fedora is configured so that "make install" can 
work, I wouldn't know I'm a Slackware user myself.

Personally I prefer to manually
# cp System.map /boot/System.map-<kernel-version>
# cp arch/i386/boot/bzImage /boot/vmlinuz-<kernel-version>
# ln -sf /boot/System.map-<kernel-version> /boot/System.map

and then edit /etc/lilo.conf to add an entry for the new kernel, followed 
by /sbin/lilo to reinstall the bootloader of course.


> This had some warning about module versions, but it seemed to work.
> 
> Then I re-booted. Naturally nothing worked.

<flamebait snipped>

May I suggest reading /path/to/your/kernel/source/README it describes the 
details of building and installing the kernel, maybe you can find a clue 
to what you did wrong.


> 
> The following hand-copied error messages exist and the root-file
> system fails to be found because all the modules fail to install.
> 
> 
> aic7xxx: version magic '2.6.5-1.358 SMP 686 REGPARM 4KSTACKS gcc-3.3`
>              should be '2.6.5-1.358 SMP 686 REGPARM 4KSTACKS gcc-3.3`
> 
> 
> All the modules that get installed by initrd have the same kind
> of error message where "version magic" claims that it doesn't
> compare with something that looks okay to the eye.
> 

Could it be you accidentally installed your new modules in the same 
location as the old ones or that your initrd holds modules compiled for a 
different kernel than the one you just build - did you remember to update 
your initrd?


> Also, the repair provisions don't have any capability of
> copying back the contents of /lib/modules/  in any usable
> way. I had to reinstall everything from scratch, just like
> Windows. Nice work.
> 
I assume you are here refering to "repair provisions" provided in the book 
"Red Hat Fedora(tm) Linux 2" you mentioned above. What does that have to 
do with the kernel? I'd suggest you take that up with RedHat and/or the 
books author.


--
Jesper Juhl

