Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282373AbRLQTI6>; Mon, 17 Dec 2001 14:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282275AbRLQTIs>; Mon, 17 Dec 2001 14:08:48 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:32765 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282222AbRLQTId>;
	Mon, 17 Dec 2001 14:08:33 -0500
Date: Mon, 17 Dec 2001 12:07:49 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Otto Wyss <otto.wyss@bluewin.ch>
Cc: Alexander Viro <viro@math.psu.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011217120749.P855@lynx.no>
Mail-Followup-To: Otto Wyss <otto.wyss@bluewin.ch>,
	Alexander Viro <viro@math.psu.edu>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0112161542420.937-100000@weyl.math.psu.edu> <3C1E3E4D.FFCAC861@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C1E3E4D.FFCAC861@bluewin.ch>; from otto.wyss@bluewin.ch on Mon, Dec 17, 2001 at 07:49:49PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17, 2001  19:49 +0100, Otto Wyss wrote:
> > Somebody not attributed wrote:
> > > Well a simple solution would be if Linux supports the multiple streams
> > > file format. 

Well "multiple streams file format" is purely a FILESYSTEM issue.  When it
is outside of the filesystem, it is an ARCHIVE (e.g. tar, cpio, zip, SHA, etc).
So this whole concept is bogus.

> I don't want to bring in any ...-Design if standard tools are enough! If
> cpio/tar do suffice, then much better. I don't know if they are simple and
> fitting enough to be handled by any boot loader and the kernel. Maybe you
> could elaborate more on this.
> 
> You have to admit that a multiple streams file format (regardless which kind)
> would be a good solution to the booting of a modular kernel. Anyway this
> format has to be supported by the kernel itself and in some extend by any
> boot loader.
> So anybody has to write a kernel module for the cpio/tar format and help with
> implementing it into  boot loaders. Maybe you could give some help. 

Well, the good news is that this whole discussion is moot.  Al Viro has
already written a kernel patch which does all of this, and I'm sure he
is just waiting to get it into the 2.5 kernel.  It creates an "initramfs"
which is populated from a cpio (or tar, can't remeber) archive attached
to the kernel image.

This does things like BOOTP/DHCP discovery, mount the rootfs, load
modules, etc, all before the root filesystem is mounted.  This allows
removing all sorts of junk from the kernel which was there because it
needed to be done before the root filesystem was mounted.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

