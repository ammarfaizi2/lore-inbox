Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUH3Rvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUH3Rvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268715AbUH3Rs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:48:26 -0400
Received: from [69.25.196.29] ([69.25.196.29]:3018 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268704AbUH3Rrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:47:37 -0400
Date: Mon, 30 Aug 2004 13:46:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
Message-ID: <20040830174632.GA21419@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040830163931.GA4295@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830163931.GA4295@bitwizard.nl>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 06:39:31PM +0200, Rogier Wolff wrote:
> We encounter "bad" drives with quite a lot more regularity than other
> people (look at the Email address). We're however, wondering why the
> IDE code still retries a bad block 8 times? 

I could see retrying 2 or 3 times, but 8 times does seem to be a bit
much, agreed.

> In fact we regularly are able to recover data from drives: we have a
> userspace application that retries over and over again, and this
> sometimes recovers "marginal" blocks. This could be considered "good
> practise" if there is a filesystem requesting the block. On the other
> hand, when this happens, the drive is usually beyond being usable for
> a filesystem: if we recover one block this way, the next block will be
> errorred and the filesystem "crashes" anyway. In fact this behaviour
> may masquerade the first warnings that something is going wrong....

If the block gets successfully read after 2 or 3 tries, it might be a
good idea for the kernel to automatically do a forced rewrite of the
block, which should cause the disk to do its own disk block
sparing/reassignment.  

						- Ted
