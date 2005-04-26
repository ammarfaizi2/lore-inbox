Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVDZWz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVDZWz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVDZWz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:55:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:18400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261808AbVDZWzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:55:49 -0400
Date: Tue, 26 Apr 2005 15:56:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
Message-Id: <20050426155609.06e3ddcf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org>
	<200504260713.26020.mason@suse.com>
	<aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
	<20050426135606.7b21a2e2.akpm@osdl.org>
	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 26 Apr 2005, Andrew Morton wrote:
> > 
> > Mounting as ext2 is a useful technique for determining whether the fs is
> > getting in the way.
> 
> What's the preferred way to try to convert a root filesystem to a bigger
> journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
> then the appropriate magic tune2fs? Or what?
> 

Gee, it's been ages.  umm,

- umount the fs
- tune2fs -O ^has_journal /dev/whatever
- fsck -fy                              (to clean up the now-orphaned journal inode)
- tune2fs -j -J size=nblocks    (normally 4k blocks)
- mount the fs

