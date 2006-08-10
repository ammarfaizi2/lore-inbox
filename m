Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWHJReV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWHJReV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWHJReV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:34:21 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:46552 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1422643AbWHJReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:34:20 -0400
Date: Thu, 10 Aug 2006 19:33:13 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
Message-ID: <20060810173312.GC21123@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jiri Slaby <jirislaby@gmail.com>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu> <20060809130151.f1ff09eb.akpm@osdl.org> <200608092043.k79KhKdt012789@turing-police.cc.vt.edu> <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu> <44DB1AF6.2020101@gmail.com> <20060810082749.6b39a07b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810082749.6b39a07b.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc3-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 08:27:49AM -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 13:39:11 +0159
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
> > Valdis.Kletnieks@vt.edu wrote:
> > > On Wed, 09 Aug 2006 16:43:20 EDT, Valdis.Kletnieks@vt.edu said:
> > > 
> > >>> Usually this means that there's an IO request in flight and it got lost
> > >>> somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
> > >>> lost interrupt (hardware bug, PCI setup bug, etc).
> > > 
> > >> Aug  9 14:30:24 turing-police kernel: [ 3535.720000] end_request: I/O error, dev fd0, sector 0
> > > 
> > > Red herring.  yum just wedged again, this time with no reference to floppy drive.
> > > Same traceback.  Anybody have anything to suggest before I start playing
> > > hunt-the-wumpus with a -mm bisection?
> > 
> > Hmm, I have the accurately same problem...
> > yum + CFQ + BLK_DEV_PIIX + nothing odd in dmesg

oooh, same setup and same trace here, but no yum, see some screenshots
here:
http://oioio.altervista.org/linux/dsc03448.jpg
http://oioio.altervista.org/linux/dsc03449.jpg

The use case for me was simply: 
- boot (in single user for the 2 shots)
- suspend
- resume
- wait some seconds and do anything that accesses the disk

[...]
> Is yum the only process which was stuck in D state?

in my case anything accessing the disk, leading to lockup shortly

> If so, I'd still be expecting a device driver/iosched bug.
> 
> If not, it's probably a vfs/fs deadlock.

I reverted the full git-block.patch and I'm now using rc3-mm2 since
then suspending to ram, disk and using my laptop for daily stuff:

reboot   system boot  2.6.18-rc3-mm2-1 Tue Aug  8 00:02 - 19:30 (2+19:27)

PS: my previous pasts are here: http://lkml.org/lkml/2006/8/7/264
    probably an unfortunate Cc list :)

-- 
mattia
:wq!
