Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbULVXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbULVXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbULVXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:08:29 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9901 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262077AbULVXIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:08:22 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Kristian Eide <kreide@online.no>
Date: Thu, 23 Dec 2004 10:08:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16841.65119.240314.917998@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid5 crash
In-Reply-To: message from Kristian Eide on Wednesday December 22
References: <200412222304.36585.kreide@online.no>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 22, kreide@online.no wrote:
> I am running kernel 2.6.9-gentoo-r10 on an Athlon XP 2400+ computer with a SiI 
> 3114 SATA controller hosting 4 WD2500JD-00G drives. I have combined these 
> drives into a raid5 array using software raid, but unfortunately the array is 
> not stable. I have tried several filesystems (ext3, reiserfs, xfs), but after 
> copying several gigabytes of data into the array (using scp) and then trying 
> to read them back (using rsync to compare over the network) always results in 
> data corruption. Here is the output from 'dmesg':
> 
> kernel BUG at drivers/md/raid5.c:813!

This BUG happens when there are two outstanding read (or write)
requests for the same piece of storage (more accurately, two "bio"s
that overlap).
raid5 cannot currently handle this situation.
Most filesystems would never make requests like this.
I note that you are using reiserfs in this case.  It is possible that
reiserfs with tail-packing enabled could do this.

I doubt very much that this would happen with ext3.  I don't know
about xfs, but I doubt it would happen their either.

When using some other filesystem, what sort of data corruption are you
getting?

NeilBrown
