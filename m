Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWBJPnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWBJPnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWBJPnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:43:04 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:24644 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932141AbWBJPnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:43:03 -0500
Date: Fri, 10 Feb 2006 16:42:56 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210154256.GG28676@harddisk-recovery.com>
References: <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org> <43ECA934.nailJHD2NPUCH@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECA934.nailJHD2NPUCH@burner>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 03:54:44PM +0100, Joerg Schilling wrote:
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> > On Fri, Feb 10, 2006 at 03:32:28PM +0100, Joerg Schilling wrote:
> > > A particular file on the system must not change st_dev while the system
> > > is running.
> > > 
> > > http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
> >
> > 1)  File != device.
> 
> I am sorry, but it turns out that you did not understand the problem.

Why do you start an ad hominem attack every time somebody shows you're
wrong for technical reasons?

> Try to inform yourself about the relevence (and content) of st_dev before
> replying again.

It has no relevance. st_dev holds the device number of the device
containing the file. That means that if /dev/hda (3,01) is on /dev, it
contains the device number of filesystem of /dev, 0x0b in my case (udev
using tmpfs):

  root@arthur:/home # stat /dev/hda
    File: `/dev/hda'
    Size: 0               Blocks: 0          IO Block: 4096   block special file
  Device: bh/11d  Inode: 548         Links: 1     Device type: 3,0
  [...]

If I create that same special file "hda" in /home, I get:

  root@arthur:/home # mknod hda b 3 0
  root@arthur:/home # stat hda
    File: `hda'
    Size: 0               Blocks: 0          IO Block: 4096   block special file
  Device: 308h/776d       Inode: 3026        Links: 1     Device type: 3,0
  [...]

It's the same device because st_rdev is the same in both cases, it just
lives on a different filesystem. You can use either device to operate
on.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
