Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWELPFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWELPFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWELPFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:05:53 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51404 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932082AbWELPFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:05:52 -0400
Date: Fri, 12 May 2006 17:03:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sfrench@us.ibm.com,
       stable@kernel.org, urban@teststation.com
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
In-Reply-To: <20060511175143.GH25646@redhat.com>
Message-ID: <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
 <20060511175143.GH25646@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The patch titled
> > 
> >      deprecate smbfs in favour of cifs
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      deprecate-smbfs-in-favour-of-cifs.patch
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> > 
> > 
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > smbfs is a bit buggy and has no maintainer.  Change it to shout at the user on
> > the first five mount attempts - tell them to switch to CIFS.
> > 
> > Come November we'll mark it BROKEN and see what happens.

Sorry for falling in late but we can't do that.
Win 98 (95 too?) shared can not be mounted with CIFS, it requires SMBFS. 
Furthermore, there seems to be a strange CIFS error when trying to do so 
(varying error codes)...:

13:11 shanghai:/etc # mount //wideland/hda1 /mnt/wideland -t smbfs -o password=realw
13:11 shanghai:/etc # ls /mnt/wideland
.               cygwin             DRVSPACE.BIN                      msdos.sys
..              tcpp               IO.SYS                            system.1st
DA              windows            SCANDISK.LOG                      tools.conf
Eigene Dateien  AUTOEXEC.BAT       SETUPXLG.TXT
Programme       COMMAND.COM        Verkn?pfung mit Scandisk.log.lnk
RECYCLED        CYGWIN_SYSLOG.TXT  config.sys
13:11 shanghai:/etc # umount /mnt/wideland
13:11 shanghai:/etc # mount //wideland/hda1 /mnt/wideland -t cifs -o password=realw
mount error 2 = No such file or directory
Refer to the mount.cifs(8) manual page (e.g.man mount.cifs)
13:11 shanghai:/etc # mount //wideland/hda1 /mnt/wideland -t cifs -o password=realw
mount error 112 = Host is down
Refer to the mount.cifs(8) manual page (e.g.man mount.cifs)

It's certainly not down.


Jan Engelhardt
-- 
