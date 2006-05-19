Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWESVMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWESVMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 17:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWESVMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 17:12:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964845AbWESVMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 17:12:50 -0400
Date: Fri, 19 May 2006 14:15:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: sct@redhat.com, torvalds@osdl.org, aia21@cam.ac.uk,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
Message-Id: <20060519141522.76c2938e.akpm@osdl.org>
In-Reply-To: <20060519205550.GI5964@schatzie.adilger.int>
References: <m364k4zfor.fsf@bzzz.home.net>
	<20060517235804.GA5731@schatzie.adilger.int>
	<1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
	<20060518185955.GK5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
	<Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.64.0605181526240.10823@g5.osdl.org>
	<20060518232324.GW5964@schatzie.adilger.int>
	<1148067412.5156.65.camel@sisko.sctweedie.blueyonder.co.uk>
	<20060519131130.71c390d9.akpm@osdl.org>
	<20060519205550.GI5964@schatzie.adilger.int>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
>
> One extra suggestion that might be safe and acceptible all around is if
> a device is larger than 2TB w/o a 64-bit sector_t that the block device
> size itself be truncated in the kernel to 2TB-512.  This at least prevents
> userspace tools from trying to e.g. format a 3TB filesystem on a device
> that will just corrupt the filesystem.

'twould be good if we could do something like that - doing it on every
single IO submission in submit_bh() Just Feels Wrong.

Also, there's always the option (or enhancement) of emitting lots of scary
warnings and then just proceeding.
