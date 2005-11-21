Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVKUXaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVKUXaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVKUXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:30:46 -0500
Received: from havoc.gtf.org ([69.61.125.42]:28389 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932461AbVKUXap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:30:45 -0500
Date: Mon, 21 Nov 2005 18:30:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Neil Brown <neilb@suse.de>
Cc: sander@humilis.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Please help me understand ->writepage. Was Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-ID: <20051121233041.GC24565@havoc.gtf.org>
References: <431B9558.1070900@baanhofman.nl> <17179.40731.907114.194935@cse.unsw.edu.au> <20051116133639.GA18274@favonius> <20051116142000.5c63449f.akpm@osdl.org> <17275.48113.533555.948181@cse.unsw.edu.au> <20051117075041.GA5563@favonius> <20051117101251.GA2883@favonius> <20051117101511.GB2883@favonius> <17282.21309.229128.930997@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17282.21309.229128.930997@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:07:41AM +1100, Neil Brown wrote:
> To write the pages out it effectively does ->prepare_write,
> ->commit_write, and then ->writepage.
> I'm not sure that prepare/commit is needed, but they don't seem to be
> the problem.  writepage is.

That's a bit weird.  Typically you have two separate callpaths,
non-page-aligned (prepare_write + commit_write) or writepage(s).
Not both.

	Jeff



