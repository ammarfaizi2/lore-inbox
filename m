Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWGCWAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWGCWAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWGCWAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:00:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16550 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932138AbWGCWAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:00:36 -0400
Subject: Re: ext4 features
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>, arjan@infradead.org,
       zdzichu@irc.pl, helgehaf@aitel.hist.no, sithglan@stud.uni-erlangen.de,
       tytso@mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20060703232547.2d54ab9b.diegocg@gmail.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <44A9904F.7060207@wolfmountaingroup.com>
	 <20060703232547.2d54ab9b.diegocg@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 23:17:13 +0100
Message-Id: <1151965033.16528.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 23:25 +0200, ysgrifennodd Diego Calleja:
> > Add a salvagable file system to ext4, i.e. when a file is deleted, you 
> > just rename it and move it to a directory called DELETED.SAV and recycle 
> > the files as people allocate new ones.  Easy to do (internal "mv" of 
> 
> 
> Easily doable in userspace, why bother with kernel programming

To get the semantics you need and avoid rewriting all of user space. At
the moment some GNU apps support this type of stuff but its not in the
core libraries so it isn't generalised.

There are some big problems with "deleted" however and doing it in
kernel space. A lot of programs just overwrite data. You would have to
look for things like O_TRUNC on a file open and ftruncate.

The ftruncate case is particularly ugly because there are programs that
do lots of ftruncate calls as they run and don't neccessarily
"overwrite" data but are merely trimming logs or database files. 

To add to the fun the 'old' file needs to be the one which ends up with
a new inode number and the like.

Alan
