Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTKDThH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 14:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTKDThH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 14:37:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:29595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbTKDThF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 14:37:05 -0500
Date: Tue, 4 Nov 2003 11:36:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
In-Reply-To: <1067973024.23788.24.camel@d8000>
Message-ID: <Pine.LNX.4.44.0311041130480.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, Paul Venezia wrote:
>
> I've been running bonnie++ filesystems testing on an IBM x335 server
> recently. This box uses the MPT RAID controller, but I've disabled the
> RAID and am addressing the disks individually. I'm getting wildly
> different results between 2.4.20-20-9 (RedHat mod), 2.4.22 (stock), and
> 2.6.0-test9.

Interesting. The 2.4.22 sequential "per char" results are totally out of
line with anything else.

The thing is, the overhead for the per-char stuff really should be almost 
all in user space unless I'm mistaken. It's just using getch/putch, no?

Which makes me suspect that either the libc does something different
depending on kernel version, _or_ 2.4.22 returns a different st_blksize
thing, causing stdio to use a different blocking size.

Have you tried stracing the "per char" parts of the benchmark to see what 
the system call patterns are? That should show both effects.

			Linus

