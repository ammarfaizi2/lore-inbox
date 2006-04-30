Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWD3PUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWD3PUO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 11:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWD3PUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 11:20:14 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:17334 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S1751147AbWD3PUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 11:20:13 -0400
Message-ID: <4454D59C.7000501@dunaweb.hu>
Date: Sun, 30 Apr 2006 17:19:56 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Bad page state in process 'nfsd' with xfs
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> David Greaves wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > This was with 2.6.16.9
> > 
> > There's an nfs export from an xfs on an lvm on a raid5 on some
> > libata/sata disks.
> > (cc'ing xfs since I recall rumoured(?) badness in old nfs/xfs/md/lvm
> > setups and xfs_sendfile is mentioned)
> > 
> > dmesg had:
> > 
> > Bad page state in process 'nfsd'
> > page:b1602060 flags:0x80000008 mapping:00000000 mapcount:0 count:16777216
> > Trying to fix it up, but a reboot is needed
> > Backtrace:
> >  [<b013bda2>] bad_page+0x62/0x90
> >  [<b013c1c8>] prep_new_page+0x78/0x80
>
> Looks like you have a bit flipped in 'count', which was not flipped
> when the page was last freed. Probably buggy RAM.
>
> Running memtest overnight might confirm that.

Or not. I had an FC3/x86-64 system until two days ago, now I have FC5/86-64.

When FC3 was installed I chose to format the partitions to XFS and since 
then
I had Oopses regularly with or without VMWare modules.
I have run memtest64+ for 12+ hours and it indicated two separate single bit
errors in the topmost  64MB of my 1GB. Since then I was running with
mem=960M but I still got Oopses on a bit heavier disk loads and every time
XFS was involved.

I backed up my /home with rsync to a new harddisk in single mode,
the new disk was formatted to EXT3. During the backup I had Oopses
about 5 or 6 times and I had to reboot. Rsync was able to continue,
that's why I chose that for backup...

I installed FC5 using only EXT3 partitions and copied my 80+ GB data
back to /home. Guess what? No Oopses...

Best regards,
Zoltán Böszörményi

