Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTKLBOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 20:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTKLBOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 20:14:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:27815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261305AbTKLBOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 20:14:38 -0500
Date: Tue, 11 Nov 2003 17:14:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311120039090.909-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0311111706530.1694-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Nov 2003, Pascal Schmidt wrote:
> 
> My guess would be that an MO drive needs a different way to find out
> the capacity than a CD-ROM. After all, when using ide-scsi, it is the
> sd driver and not sr that handles the drive. The rest of the problems
> could be due to the wrong capacity information?

Yes. That would explain a lot. 

The ide-scsi thing never uses "cdrom_get_last_written" crud. It just uses
the regular READ_CAPACITY command (0x25).

Which is what ide-cd.c will fall back to as well ("cdrom_read_capacity()")
but I think it should _start_ with that rather than fall back on it.
That's the simple case, after all.

Does it work if you change the order of those two things in ide-cd.c (or
just remove the call to "cdrom_get_last_written()" entirely, so that it
always just does the sane thing).

		Linus

