Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUGDWoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUGDWoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUGDWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:44:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:26824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265828AbUGDWoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:44:09 -0400
Date: Sun, 4 Jul 2004 15:43:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-Id: <20040704154303.4eb0fbaf.akpm@osdl.org>
In-Reply-To: <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <20040703202242.GA31656@MAIL.13thfloor.at>
	<20040703202541.GA11398@infradead.org>
	<20040703133556.44b70d60.akpm@osdl.org>
	<20040703210407.GA11773@infradead.org>
	<20040703143558.5f2c06d6.akpm@osdl.org>
	<20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk>
	<20040704145542.4d1723f5.akpm@osdl.org>
	<20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Sun, Jul 04, 2004 at 02:55:42PM -0700, Andrew Morton wrote:
> > 
> > Some do.  On my test box 1000-odd /proc inodes get allocated and fully
> > freed on each `ls -R /proc'.  65 /proc inodes are freed during `ls -lR
> > /proc/net'.  So maybe it isn't working completely.
> > 
> > But proc_notify_change() copies the inode's uid, gid and mode into the
> > proc_dir_entry, so they get correctly initialised when the inode is
> > reinstantiated, so afaict we have no bug here.
> 
> Why on the earth do we ever want to allow chown/chmod on procfs in the first
> place?

We always have done, even current 2.4 permits it.  But the changes go away
when the /proc file is closed.

> Al, who'd missed that stuff back in 2.5.42, but would love to hear explanation
> anyway.

That change made the chown/chgrp/chmod changes persist after the file is
closed, which seems sensible.

The alternative would be to disallow these changes altogether.  That might
break something, but it seems doubtful.

As for why anyone would _want_ to change these things: no idea.
