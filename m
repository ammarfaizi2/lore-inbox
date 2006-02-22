Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWBVTDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWBVTDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWBVTDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:03:19 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:31992 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751309AbWBVTDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:03:18 -0500
Date: Wed, 22 Feb 2006 10:59:23 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222185923.GL16648@ca-server1.us.oracle.com>
Mail-Followup-To: Gabor Gombas <gombasg@sztaki.hu>,
	Theodore Ts'o <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
	penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de,
	rml@novell.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 06:33:54PM +0100, Gabor Gombas wrote:
> I don't think isnmod is broken. It's job is to load a chunk of code into
> the kernel, and it's doing just that.
> 
> ...
>
> But if your kernel has CONFIG_HOTPLUG enabled, then _you_ have asked for
> this exact behavior, therefore you should better fix userspace to cope
> with it. Your initrd should use the notification mechanisms provided by
> the kernel to wait for the would-be root device really becoming
> available; if it's not doing that, then IMHO you should not use a
> CONFIG_HOTPLUG enabled kernel.

        The issue isn't so much "insmod is right" vs "insmod is wrong".
It's that the behavior changed in a surprising fashion.  Red Hat's
kernel for RHEL4 (in our example) has CONFIG_HOTPLUG=y, yet it Just
Works.  A more recent kernel (.15 and .16 at least) with
CONFIG_HOTPLUG=y doesn't work.  Same disk drivers.  Same initramfs
script.
	We're discussing this very "kernel change broke userspace
expectations" issue.  You don't need to convince me that

  1. Insmod loads the driver
  2. Userspace initramfs sleeps waiting for hotplug
  3. Hotplug completes
  4. Userspace initramfs continues, using the now plugged devices.

is the "most correct".  It makes perfect technical sense.  If you were
starting from scratch, no one would be complaining, becuase no one would
see a problem.
	We're not starting from scratch.  We have large installed bases
of userspace code that expects a certain behavior from the kernel.
While it sometimes is necessary to say "you need to update", I think the
consensus is clear - only do that when it is necessary.  Don't call
people dumb or say they "need to update" just because you didn't
consider existing users.

Joel

-- 

 "I'm living so far beyond my income that we may almost be said
 to be living apart."
         - e e cummings

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
