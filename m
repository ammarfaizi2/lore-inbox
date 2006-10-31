Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422973AbWJaIoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422973AbWJaIoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWJaIoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:44:23 -0500
Received: from brick.kernel.dk ([62.242.22.158]:50791 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422973AbWJaIoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:44:22 -0500
Date: Tue, 31 Oct 2006 09:46:04 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Daniel Drake <ddrake@brontes3d.com>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jfs: Add splice support
Message-ID: <20061031084604.GB14055@kernel.dk>
References: <20061030163148.2412D7B40A0@zog.reactivated.net> <1162227415.24229.2.camel@kleikamp.austin.ibm.com> <Pine.LNX.4.61.0610310931020.23540@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610310931020.23540@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Jan Engelhardt wrote:
> 
> >> This allows the splice() and tee() syscalls to be used with JFS.
> >
> >Gosh, that was easy.  Why couldn't I do that?  :-)
> 
> You could add it to all the other filesystems that lack it. (Cautionary 
> question: Does that work at an instant like it did with jfs?)
> 
> Seems like only ext[234] gfs2 reiserfs and xfs have splice_read 
> currently.

If the file system uses the generic page cache functions for reading and
writing, it should be able to use the generic splice read/write
functions as well. If it doesn't, then more work is likely involved. In
short, check the .read/.write and .aio_read/.aio_write parts of the
file_operations[] structure. jfs uses the generic handlers, hence splice
support should just be the two-liner posted.

-- 
Jens Axboe

