Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVDEPXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVDEPXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVDEPXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:23:49 -0400
Received: from web25610.mail.ukl.yahoo.com ([217.12.10.169]:11185 "HELO
	web25610.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261777AbVDEPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:23:46 -0400
Message-ID: <20050405152345.18321.qmail@web25610.mail.ukl.yahoo.com>
Date: Tue, 5 Apr 2005 17:23:44 +0200 (CEST)
From: Uwe Zybell <u_zybell@yahoo.de>
Subject: Re: fs/partitions/msdos.c, scripts/packages/Makefile
To: Andries Brouwer <aebr@win.tue.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andries Brouwer <aebr@win.tue.nl> wrote:
> On Fri, Apr 01, 2005 at 07:18:52PM +0200, Uwe Zybell wrote:
> 
> > There is a line in fs/partitions/msdos.c that lets extended
> partitions 
> > be max 1k (..."==1 ? 1 : 2"...). The comment explains it to protect
> 
> > sysadmins from themselves. But now I have found a legitimate use
> > for extended partitions in their full length. Emulation.
> > Please remove this, or make it a config option.
> 
> Config options are evil. Adding them is a bad form of bloat.
Then remove.
> 
> Whatever you want to do, there are many ways to do it without
> changing this part of the kernel code. After all, any partition
> is just part of the entire disk.
> 
But I don't want to rewrite the disk access code of the emulator
either,
because I would have to duplicate that kernelcode into the application.
Besides it would have the same alias access to the *mounted* root
partition. Not that it would *intend* to go there, but a stray fseek
could
do some damage. Something that would be easier than a stray open:-).
Open _does_ check access rights.
> Note that there are aliasing problems - it is bad to access data
> both via a file system and via raw disk or partition.
> 
If that partition isn't mounted there is no problem. The emulator does
the mount. If the emulator isn't running and I want to change some
Files,
then I *can* mount without problems.
There is another way. Make "partitions" a full
(pseudo)(read-only?)filesystem. So that "mount -t partitions /dev/hda
/dev/hd/a" and
"mount -t ext2 /dev/hd/a/1 /usr" works. Note that the blockdevice for
the partition is in logically in the full device. If this "partitions"
filesystem permits the writing of inodes, it could be a standard
interface for fdisk et al.
 


	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
