Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752019AbWAETAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbWAETAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWAETAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:00:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54149 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751908AbWAETAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:00:09 -0500
Date: Thu, 5 Jan 2006 14:00:08 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <autofs@linux.kernel.org>, <raven@themaw.net>
Subject: Re: [linux-usb-devel] Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs
 uninterruptable sleep
In-Reply-To: <87fyo2k1zr.fsf@hardknott.home.whinlatter.ukfsn.org>
Message-ID: <Pine.LNX.4.44L0.0601051355090.6460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Roger Leigh wrote:

> > By any chance, does autofs or autofs4 mount your device with -o sync?  
> > Doing that with flash memory devices is a grave mistake -- although it 
> > shouldn't cause the sort of lock-up you described.
> 
> Yes.  I have
> 
> pen-secure  -fstype=ext2,sync,nodev,nosuid,noatime  :/dev/sda2
> 
> in /etc/auto.misc.  Removing the sync option does prevent the lockups.
> I just added it back and it locked up immediately.

Sync for flash devices is generally a bad idea.  Especially with vfat 
filesystems but to some extent with all of them, it causes constant 
rewriting of sectors containing metadata.  Flash memory behaves poorly 
when the same sector gets written over and over again; it tends to slow 
down and eventually wear out completely.

> The usb/usb-storage logs are attached (device mount + command which
> broke it).  Would you like any more information?

The log you provided shows only two commands, both of which completed 
successfully.  Is that really the place where things got hung?  If it is 
then the problem isn't in the USB stack but someplace higher up: the SCSI 
stack, the block layer, or the filesystem layer.

Alan Stern

