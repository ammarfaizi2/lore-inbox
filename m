Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTDXNPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTDXNPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:15:12 -0400
Received: from bamb-d9b9740c.pool.mediaWays.net ([217.185.116.12]:32007 "EHLO
	rz.zidlicky.org") by vger.kernel.org with ESMTP id S263600AbTDXNPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:15:11 -0400
Date: Thu, 24 Apr 2003 15:14:46 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Bradford <john@grabjohn.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
Message-ID: <20030424131446.GB3073@linux-m68k.org>
References: <20030424094732.GA925@linux-m68k.org> <Pine.GSO.4.21.0304241309200.19942-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304241309200.19942-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 01:26:12PM +0200, Geert Uytterhoeven wrote:

> 
> After some more thinking, Alan's suggestion (always doing the swapping) isn't
> that bad. Except for the loop layer on old slow machines, which I'd like to
> avoid.

convincing by simplicity, oversimplification also may have drawbacks.
 
> If we always swap, we only have to un-swap when reading/writing platter data
> from native disks. No more swapping has to be done in ide_fix_driveid(), apart
> from the obvious conversion from little to big endian of the driveid structure
> itself, which we cannot avoid.

yes. Smartdata and everything would be correct, except for the disk
contents.

> Since both Atari and Q40/Q60 use PIO only, this affects ata_{in,out}put_data()
> only. It's quite easy to add a swap flag to ide_drive_t (configurable through
> hdX=swapdata), that is checked in ata_{in,out}put_data().  To improve
> performance, we wouldn't swap twice, but just call the new routines
> hwif->{IN,OUT}S[WL]_NOSWAP.

contradicts previous paragraph? Still wrong smartdata etc unless
you mean to set the flag per request depending on the type of command
- which would be quite easy afaics. 

> All of this can be protected by #ifdef CONFIG_IDE_BYTESWAPPED_HWIF. Influence
> on generic code is limited to ata_{in,out}put_data() and the new routines
> hwif->{IN,OUT}S[WL]_NOSWAP.
> 
> Is this OK?

so to sum up, your idea is 
- cleanup and correct current solution for IDE_BYTESWAPPED_HWIF machines
- make all others use the loop layer

looks fine.

Richard
