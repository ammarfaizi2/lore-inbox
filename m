Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSKCMRk>; Sun, 3 Nov 2002 07:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSKCMRk>; Sun, 3 Nov 2002 07:17:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22412 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261624AbSKCMRj>; Sun, 3 Nov 2002 07:17:39 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:45:15 +0000
Message-Id: <1036327515.29646.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 02:03, Linus Torvalds wrote:
> So I'd suggest _not_ attaching that capability to the sendmail binary
> itself, or to any inode number of that binary. A binary is a binary is a
> binary - it's just the data. Instead, I'd attach the information to the
> directory entry, either directly (ie the directory entry really has an
> extra field that lists the capabilities) or indirectly (ie the directory
> entry is really just an "extended symlink" that contains not just the path
> to the binary, but also the capabilities associated with it).

So what are the semantics for writing to the file. If I modify a setuid
(or setpartlysetuid) type file then I wan't the setuidness revoked as
happens now. That is done for very good reason. Your system appears to
need a scan of the entire file system to find directory references to
this object, done atomically. 
 
> The reason I like directory entries as opposed to inodes is that if you
> work this way, you can actually give different people _different_
> capabilities for the same program.  You don't need to have two different
> installs, you can have one install and two different links to it.

I'll trade 500K of disk space for a working security model especially as
the case in question is not that common.

Alan

