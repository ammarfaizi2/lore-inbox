Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWFLTxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWFLTxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWFLTxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:53:38 -0400
Received: from silver.veritas.com ([143.127.12.111]:57495 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932160AbWFLTxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:53:37 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="39137497:sNHT27583436"
Date: Mon, 12 Jun 2006 20:38:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: "Robin H. Johnson" <robbat2@gentoo.org>, Al Viro <viro@zeniv.linux.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards.
 Also VFS time granularity bug on creat(). (Repost, more content)
In-Reply-To: <p73ac8isgv9.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0606122024330.18760@blonde.wat.veritas.com>
References: <20060611115421.GE26475@curie-int.vc.shawcable.net>
 <p73ac8isgv9.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jun 2006 19:53:36.0675 (UTC) FILETIME=[E4B21F30:01C68E59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> > 
> > This patch should probably be included for 2.6.17, despite how long the
> > bug has been around. It's a one-liner, with no side-effects.
> 
> Agreed. Good catch.
> 
> That was my bug when doing the conversion - but for my defense
> having file systems outside fs/* is error prone.

Yes.  And my bug for not noticing your s_time_gran patch to the others.

> Can we perhaps move tmpfs or at least the fs parts of shmem.c
> into fs/ in the future?  (the file is too big anyways)

The file is shamefully big, yes.  I'd hate to move the swap entry
part of it out of mm/, but it might be a possibility to divide it up:
the filesystem entry points in fs/, the use of swap in mm/ - be nice
if all that could be under obj-$(CONFIG_SWAP) in the Makefile.

I did once embark on looking at it from a CONFIG_SWAP point of view;
but didn't get far before more urgent work intervened.  And your
argument grows weaker, with filesystems spreading through drivers,
and even to arch (spufs).

Hugh
