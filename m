Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTKMMU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTKMMU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:20:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10426 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264132AbTKMMU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:20:57 -0500
Date: Thu, 13 Nov 2003 13:20:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031113122039.GJ4441@suse.de>
References: <Pine.LNX.4.44.0311111706530.1694-100000@home.osdl.org> <Pine.LNX.3.96.1031113064731.23748A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1031113064731.23748A-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Bill Davidsen wrote:
> On Tue, 11 Nov 2003, Linus Torvalds wrote:
> 
> > 
> > On Wed, 12 Nov 2003, Pascal Schmidt wrote:
> > > 
> > > My guess would be that an MO drive needs a different way to find out
> > > the capacity than a CD-ROM. After all, when using ide-scsi, it is the
> > > sd driver and not sr that handles the drive. The rest of the problems
> > > could be due to the wrong capacity information?
> > 
> > Yes. That would explain a lot. 
> > 
> > The ide-scsi thing never uses "cdrom_get_last_written" crud. It just uses
> > the regular READ_CAPACITY command (0x25).
> > 
> > Which is what ide-cd.c will fall back to as well ("cdrom_read_capacity()")
> > but I think it should _start_ with that rather than fall back on it.
> > That's the simple case, after all.
> 
> Are there any cases when the last_written size is really what's wanted,
> rather than the capacity? Such as unclosed multi-session iso9660, ufs, or
> whatever else I'm ignoring?

Yes, for packet written media.

-- 
Jens Axboe

