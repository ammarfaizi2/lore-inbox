Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTKMMEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTKMMEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:04:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25867 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263898AbTKMMEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:04:05 -0500
Date: Thu, 13 Nov 2003 06:52:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Pascal Schmidt <der.eremit@email.de>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311111706530.1694-100000@home.osdl.org>
Message-ID: <Pine.LNX.3.96.1031113064731.23748A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:

> 
> On Wed, 12 Nov 2003, Pascal Schmidt wrote:
> > 
> > My guess would be that an MO drive needs a different way to find out
> > the capacity than a CD-ROM. After all, when using ide-scsi, it is the
> > sd driver and not sr that handles the drive. The rest of the problems
> > could be due to the wrong capacity information?
> 
> Yes. That would explain a lot. 
> 
> The ide-scsi thing never uses "cdrom_get_last_written" crud. It just uses
> the regular READ_CAPACITY command (0x25).
> 
> Which is what ide-cd.c will fall back to as well ("cdrom_read_capacity()")
> but I think it should _start_ with that rather than fall back on it.
> That's the simple case, after all.

Are there any cases when the last_written size is really what's wanted,
rather than the capacity? Such as unclosed multi-session iso9660, ufs, or
whatever else I'm ignoring?
> 
> Does it work if you change the order of those two things in ide-cd.c (or
> just remove the call to "cdrom_get_last_written()" entirely, so that it
> always just does the sane thing).

For a read-only access, I think the size is what's written, while for
writing it's the physical size, I think. Does it need to be as complex as
having the order depend on the access mode? It seems that a size of zero
is correct for a read access to an unwritten media.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

