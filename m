Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbUGDV5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUGDV5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUGDV5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:57:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:58537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265802AbUGDV5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:57:03 -0400
Date: Sun, 4 Jul 2004 14:55:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-Id: <20040704145542.4d1723f5.akpm@osdl.org>
In-Reply-To: <20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <20040703202242.GA31656@MAIL.13thfloor.at>
	<20040703202541.GA11398@infradead.org>
	<20040703133556.44b70d60.akpm@osdl.org>
	<20040703210407.GA11773@infradead.org>
	<20040703143558.5f2c06d6.akpm@osdl.org>
	<20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Sat, Jul 03, 2004 at 02:35:58PM -0700, Andrew Morton wrote:
> > > Because it turns the question what permissions a procfs file has into
> > > a lottery game.  He only changes the incore inode owner and as soon as
> > > the inode is reclaimed the old ones return.
> > 
> > procfs inodes aren't reclaimable.
> 
> WTF do you mean "not reclaimable"?

Got confused.

>  They do get freed under memory pressure
> and recreated on later lookups.

Some do.  On my test box 1000-odd /proc inodes get allocated and fully
freed on each `ls -R /proc'.  65 /proc inodes are freed during `ls -lR
/proc/net'.  So maybe it isn't working completely.

But proc_notify_change() copies the inode's uid, gid and mode into the
proc_dir_entry, so they get correctly initialised when the inode is
reinstantiated, so afaict we have no bug here.
