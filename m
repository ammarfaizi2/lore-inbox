Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSB1OdZ>; Thu, 28 Feb 2002 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293302AbSB1Oa6>; Thu, 28 Feb 2002 09:30:58 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:35847 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293408AbSB1O2z>; Thu, 28 Feb 2002 09:28:55 -0500
Date: Thu, 28 Feb 2002 15:28:52 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/mounts: two different loop devices mounted on same mountpoint?!
Message-ID: <20020228152852.B23019@devcon.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020228095948.GG774@elf.ucw.cz> <Pine.LNX.4.33.0202281200230.15246-100000@unicef.org.yu> <20020228134455.GA28490@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020228134455.GA28490@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Thu, Feb 28, 2002 at 02:44:55PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 02:44:55PM +0100, Pavel Machek wrote:
> 
> > I think that is normal behaviour in 2.4.X
> > that one can mount more than once
> > on same mount point.
> But two different devices? What's the semantics, then?

All accesses go to the filesystem mounted last. The one mounted first
is inaccessible until you unmount the filesystem covering it. Well,
not really inaccessible, if any process happened to have a working
directory or an open file on the first filesystem at the time you
mounted the second, it can still access it.

There is nothing special involved, after all, it's the same as if you
mount a single filesystem to /mnt, the only difference is that the
second mount this time doesn't cover a single dirtree on the root
partition, but instead it covers a complete other filesystem.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
