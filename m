Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSFOWWx>; Sat, 15 Jun 2002 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSFOWWw>; Sat, 15 Jun 2002 18:22:52 -0400
Received: from crack.them.org ([65.125.64.184]:13321 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S315619AbSFOWWu>;
	Sat, 15 Jun 2002 18:22:50 -0400
Date: Sat, 15 Jun 2002 17:22:44 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linux-kernel@vger.kernel.org
Subject: Inexplicable disk activity trying to load modules on devfs
Message-ID: <20020615172244.C19123@crack.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted into 2.4.19-pre10-ac2 for the first time, and noticed
something very odd: my disk activity light was flashing at about
half-second intervals, very regularly, and I could hear the disk
moving.  I was only able to track it down to which disk controller, via
/proc/interrupts (are there any tools for monitoring VFS activity? 
They'd be really useful).  Eventually I hunted down the program causing
it: xmms.

The reason turned out to be that I hadn't remembered to build my sound
driver for this kernel version.  Every half-second xmms tried to open
/dev/mixer (and failed, ENOENT).  Every time it did that there was
actual disk activity.  Easily reproducible without xmms.  Reproducible
on any non-existant device in devfs, but not for nonexisting files on
other filesystems.  Is something bypassing the normal disk cache
mechanisms here?  That doesn't seem right at all.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
MontaVista Software                         Carnegie Mellon University
