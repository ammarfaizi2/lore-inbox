Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTK3N1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTK3N1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:27:51 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:43020 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264911AbTK3N1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:27:49 -0500
Date: Sun, 30 Nov 2003 14:26:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130132649.GC5738@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <20031129222722.GA505@gnu.org> <20031130003428.GA5465@win.tue.nl> <Pine.LNX.4.58.0311301210540.2329@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311301210540.2329@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 01:10:36PM +0200, Szakacsits Szabolcs wrote:
> 
> On Sun, 30 Nov 2003, Andries Brouwer wrote:
> 
> > Just ask yourself this question: does Windows XP require a bootable
> > partition to start below the 1024 cylinder mark?
> > Windows NT4 has such a restriction. Not Windows 2000 or XP.
> 
> Wrong:
> 	http://support.microsoft.com/default.aspx?scid=kb;en-us;282191

"Wrong" - what a pessimism. That URL just confirms what I wrote:
Windows XP has no such restriction. If you explicitly ask Windows XP
to use oldfashioned means, then of course that is your own choice.

> > > > Usually booting goes like this: the BIOS reads sector 0 (the MBR)
> > > > from the first disk, and starts the code found there. What happens
> > > > afterwards is up to that code. If that code uses CHS units to find
> > > > a partition, and if the program that wrote the table has different
> > > > ideas about those units than the BIOS, booting may fail.
> > > Exactly.
> > Good. We agree.
> 
> I'm glad also. So what actually [cs]fdisk do with the CHS entries in the
> partition table? Ignore them? Might they convert a given partition start to
> different CHS units if the partition entry was deleted then recreated at
> the same cylinder? 

Ha, now we are getting down to business.
*fdisk evolves in time, so the answer is very version dependent.
Let me answer for today's fdisk.

Disk geometry is determined as follows (see fdisk.c:get_geometry())

        heads = user_heads ? user_heads :
                pt_heads ? pt_heads :
                kern_heads ? kern_heads : 255;
        sectors = user_sectors ? user_sectors :
                pt_sectors ? pt_sectors :
                kern_sectors ? kern_sectors : 63;

that is, if the user has specified a geometry on the command line,
then that is what we use; otherwise, if there is a partition
table already and we are able to guess a geometry from that, use that;
otherwise, if the kernel has some idea, use that; finally use */255/63
when no information is available.

Andries

