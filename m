Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTEFSFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTEFSFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:05:42 -0400
Received: from mail1.ewetel.de ([212.6.122.16]:61326 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263902AbTEFSFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:05:41 -0400
Date: Tue, 6 May 2003 20:18:06 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030506180408.GH905@suse.de>
Message-ID: <Pine.LNX.4.44.0305062007330.1351-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

>> ------------[ cut here ]------------
>> kernel BUG at fs/buffer.c:2607!
> Not good. Does it work correctly with 2kb block size? I would not be
> surprised if ide-cd had multi page bio bugs...

The ext2 filesystem in question uses 2kb block size. The drive can also 
handle disks with 1kb and 512b block sizes, but I don't have of those
disks (MOs are hard sectored, so you can't format one to use a different
hw block size).

Under 2.4 with ide-scsi/sd, ext2 with 2kb block size works, other block
sizes for the filesystem don't work (at least that was the case about a
year ago when I tried other sizes the last time).

>> My patch:
> Not bad, see that wasn't so hard.

Turned out to be quite easy once I found out that ide_cdrom_attach was
checking for drive->media == ide_cdrom. I had only looked as far as
ide_cdrom_setup before. :)

Too bad writing doesn't work out quite yet. At least the directory entry
got written, so part of it seems to work.

> Does it load ide-cd without errors with this one?

Yes, the error messages are gone. I skipped all the capability tests that 
go to the drive. Maybe that skips to much. Where does the hw block size 
get detected? I hope I didn't skip that part...

-- 
Ciao,
Pascal

