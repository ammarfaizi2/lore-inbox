Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUCZVbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCZVbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:31:18 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:50311 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261158AbUCZVbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:31:09 -0500
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was
	Re: Your opinion on the merge?]]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Michael Frank <mhf@linuxmail.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040326102206.GD388@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz>
	 <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz>
	 <200403250857.08920.matthias.wieser@hiasl.net>
	 <1080247142.6679.3.camel@calvin.wpcb.org.au>
	 <20040325222745.GE2179@elf.ucw.cz> <opr5gf93ik4evsfm@smtp.pacific.net.th>
	 <20040326102206.GD388@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080333011.2022.9.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Sat, 27 Mar 2004 08:30:11 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning.

On Fri, 2004-03-26 at 22:22, Pavel Machek wrote:
> > /proc is needed a lot
> > 
> > - enable escape
> > - select reboot mode
> > 	which is essential for multibooting. We use it all the time to
> > 	boot various installations of Linux
> 
> Perhaps reboot() can have parameter for that.

Sounds feasible. Who maintains the package with reboot/shutdown and so
on?

> > - select compression none, lzw or gzip
> > 	none is used when disk faster that cpu-limited lzf
> > 	lzf is used when cpu is fast enough to compress to disk
> > 		Fast CPU can do 100MB/s+ to 50MB/s drives
> > 	gzip is used by some who care about image size eg flash users
> 
> If you are doing "resume=swap:<something>", why not "resume=lzw-swap:something"?

Because it's ugly? resume= is supposed to specify where the image's
header is found, nothing more. More than that, though, doing this still
doesn't solve the issue of how to enable/disable a compressor (or
encryption when such a plugin appears) after booting. (Yes, I know - you
don't want that much flexibility).

> > - keep image mode (when compiled in)
> > 	which is used for embedded kiosks for example
> > 		Boeing requested and uses it
> 
> Boeing can keep external patch, this seems like pretty dangerous
> feature for joe user. And it should not be selected at /proc, but as
> command line parameter.

It relies upon both a compile time CONFIG option (because yes, it is
rarely used) and a /proc entry. The proc entry is necessary so that the
image can be updated and set up in the first place.

> > - default console level
> > 	Controls console messages or nice display
> > - access debug info header
> > 	This is needed to analyze swsusp2 performance
> > - access resume parameters
> > 	Saves a reboot when changing parameters
> > - activate
> > 	swsusp2 activation independent of apci, apm
> 
> Should not be needed. There's reboot() syscall to do that.

That's fine once we get one implementation. For now, I've been trying to
play nicely with swsusp and pmdisk. That's why I used resume2= and its
also why I supported 13 headers; I needed to recognise pmdisk and swsusp
headers so that I could know to ignore them (I tried leaving swsusp
first in the boot order, and it paniced when I'd suspended from suspend2
because it didn't recognise the header format).

> > - last result
> > 	info on why swsusp2 did not suspend such as out of
> > 	memory or swap or freezing failure
> 
> That should be return value of reboot() syscall.

Could be.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

