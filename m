Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285210AbRLSKMD>; Wed, 19 Dec 2001 05:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285207AbRLSKLm>; Wed, 19 Dec 2001 05:11:42 -0500
Received: from codepoet.org ([166.70.14.212]:54793 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S285186AbRLSKLi>;
	Wed, 19 Dec 2001 05:11:38 -0500
Date: Wed, 19 Dec 2001 03:11:36 -0700
From: Erik Andersen <andersen@codepoet.org>
To: James A Sutherland <james@sutherland.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011219031136.A23980@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	James A Sutherland <james@sutherland.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk> <9vo4b3$iet$1@cesium.transmeta.com> <T57ead5b988ac1785ed28e@pcow035o.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <T57ead5b988ac1785ed28e@pcow035o.blueyonder.co.uk>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.16-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 19, 2001 at 09:27:29AM +0000, James A Sutherland wrote:
> 
> What I was suggesting is that using an initfs (whether initrd, initramfs or 
> something else) is a better approach than trying to get the bootloader 
> grovelling around in the kernel innards - initramfs strengthens this 
> argument, I think. Just put the modules into archives, and use initramfs to 
> access them and a copy of insmod...

Here is a simple example...  Take busybox, disable everything but
insmod and lash (the simplest of the busybox shells).  Staticly
link vs uClibc -- the result is 61k (far less then the 440k from
glibc).  Now make a root fs that contains just /bin/sh (the
busybox binary), /sbin/insmod (a symlink to /bin/sh), and then
fill up / of your root fs with all the modules you wish to load.
Add in a simple script as /linuxrc or /sbin/init with something
like:

    #!/bin/sh
    /sbin/insmod /foo.o

Now, gzip the result.  With about 60k worth of modules, the final
initrd will compress to about 60k.  Simple, easy, small, and all
in userspace,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
