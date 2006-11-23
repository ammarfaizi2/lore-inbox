Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933941AbWKWUyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933941AbWKWUyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757364AbWKWUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:54:39 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:29633 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1755256AbWKWUyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:54:39 -0500
Date: Thu, 23 Nov 2006 15:54:37 -0500
To: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <20061123205436.GA16440@csclub.uwaterloo.ca>
References: <ek2nva$vgk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ek2nva$vgk$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:54:03AM +0100, Gunter Ohrner wrote:
> (PEBKAC warning. I'm probably doing something dump. I just don't know
> what...)
> 
> I seem to have an entropy pool on a headless machine which is not nearly
> empty (a common problem in this case, I know), but completely empty and
> stuck in this state...
> 
> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0
> Hornburg:~# fuser /dev/urandom
> Hornburg:~# lsof | grep random
> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0
> Hornburg:~# dd if=/dev/hdf of=/dev/urandom bs=512 count=1
> 1+0 records in
> 1+0 records out
> 512 bytes transferred in 0.016268 seconds (31473 bytes/sec)
> Hornburg:~# dd if=/dev/hdf of=/dev/random bs=512 count=1
> 1+0 records in
> 1+0 records out
> 512 bytes transferred in 0.031943 seconds (16029 bytes/sec)
> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0
> Hornburg:~# fuser /dev/urandom
> Hornburg:~# fuser /dev/random
> Hornburg:~# lsof | grep random
> Hornburg:~# cat /proc/sys/kernel/random/poolsize
> 4096
> Hornburg:~#
> 
> Also causing disk activities doesn't help at all. (Two disks on a Promise
> PDC20268 controller.)
> 
> The system runs a rather ancient Debian Sarge 2.4 kernel:
> Linux Hornburg 2.4.27-3-386 #1 Thu Sep 14 08:44:58 UTC 2006 i486 GNU/Linux
> 
> However as the machine itself is also ancient, the 2.4 seems like a good
> match. And also 2.4 ought to have a refilling entropy pool, doesn't it?
> 
> Maybe someone can shed some light on what's happening here...

Only some devices/drivers generate entropy data.  Some network drivers,
mouse, keyboard.  None of the disk drivers are appear to do so.  Serial
ports do not in general either.  On my headless systems I patched
pcnet32 and the 8250 driver to generate entropy since otherwise I tended
to run out very quickly.

--
Len Sorensen
