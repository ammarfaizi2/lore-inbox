Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUHLXtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUHLXtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268893AbUHLXtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:49:08 -0400
Received: from thunk.org ([140.239.227.29]:16107 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268890AbUHLXtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:49:05 -0400
Date: Thu, 12 Aug 2004 19:48:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New concept of ext3 disk checks
Message-ID: <20040812234857.GA8098@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <2ssbz-jB-1@gated-at.bofh.it> <2swyz-3ny-13@gated-at.bofh.it> <m3acx0szwu.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acx0szwu.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 01:24:33AM +0200, Andi Kleen wrote:
> Theodore Ts'o <tytso@mit.edu> writes:
> 
> > 4) If there were no errors detecting by the fsck run, run the command
> > "tune2fs -C 0 -T now /dev/XXX" on the live filesystem.  This sets the
> > mount count and last filesystem checked time to the appropriate values
> > in the superblock.
> 
> Is it safe now to run tune2fs on a mounted busy fs? afaik it would
> need at least support to quiescence the fs temporarily. Otherwise you 
> have a race window where changes to the superblock could get lost.

Modern versions of e2fsprogs do byte-level writes only to the fields
that are being changed by the userspace program; given that these are
fields that are not touched by the kernel once the filesystem is
mounted, this is safe.

						- Ted

