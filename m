Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUCaDgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 22:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUCaDgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 22:36:31 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:16336 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261711AbUCaDg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 22:36:29 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 31 Mar 2004 13:36:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16490.15538.73836.274885@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1 - parse_early_options broken
In-Reply-To: message from Andrew Morton on Tuesday March 30
References: <20040330023437.72bb5192.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 30, akpm@osdl.org wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm1/
> 
> - Dropped the tty locking fix.  As predicted, it deadlocked.  I also
>   reverted the patch from bk-driver-core.patch which is causing this race to
>   trigger more frequently.
> 
> - Added the rest of Ingo's recent CPU scheduler work.  This is for people
>   to compare with 2.6.5-rc2-mm5.

I tried 2.6.5-rc3-mm1 with a lilo.conf which had:
           append="earlyprintk=vga acpi=off"

It booted all the way to trying to mount the root filesystem (which is
on /dev/sda1) and complained something about

        801earlyprintk=vga

being a bad device name.  It looks like the ' ' before earlyprintk has
been swallowed.
(lilo would have made a command line of
  auto BOOT_IMAGE=5 ro root=801 earlyprintk=vga acpi=off
)

I tried again with
           append="earlyprintk=vga acpi=off root=08:01"
and it worked fine.

I hunted around and found parse_early_options and commented out

					if (to != *cmdline_p)
						to -= 1;

one the basis that it look suspicious, and as "to" is never (as far as
I can see) going to have the same value as *cmdline_p.

With this change, it boots nicely with the original append= line.

(The broken-out patch has a comment, but no "From:" line so I wasn't
sure who really should be told....)

NeilBrown

