Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262552AbTCMT3Q>; Thu, 13 Mar 2003 14:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262553AbTCMT3Q>; Thu, 13 Mar 2003 14:29:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:22231 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262552AbTCMT3N>;
	Thu, 13 Mar 2003 14:29:13 -0500
Date: Thu, 13 Mar 2003 11:39:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: Matthew Wilcox <willy@debian.org>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH] concurrent block allocation for ext2
 against 2.5.64
Message-Id: <20030313113951.44270caf.akpm@digeo.com>
In-Reply-To: <20030313190908.GC29631@parcelfarce.linux.theplanet.co.uk>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313103948.Z12806@schatzie.adilger.int>
	<m3d6kvhzuu.fsf@lexa.home.net>
	<20030313190908.GC29631@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 19:39:49.0271 (UTC) FILETIME=[4F310A70:01C2E998]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> On Thu, Mar 13, 2003 at 09:43:05PM +0300, Alex Tomas wrote:
> > 
> > fs/attr.c:
> >         if (ia_valid & ATTR_SIZE) {
> >                 if (attr->ia_size == inode->i_size) {
> >                         if (ia_valid == ATTR_SIZE)
> >                                 goto out;       /* we can skip lock_kernel() */
> >                 } else {
> >                         lock_kernel();
> >                         error = vmtruncate(inode, attr->ia_size);
> >                         unlock_kernel();
> >                         if (error)
> >                                 goto out;
> >                 }
> >         }
> > 
> > so, all (!) truncates are serialized
> 
> This looks like a bug.  It should be safe to delete them.

Probably.  I was running without them for months.  But this is the
ftruncate() path and not the unlink() path, so I kinda forgot about it.

Most truncations are unlinks, and they are not under lock_kernel.
