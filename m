Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWCTRzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWCTRzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 12:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWCTRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 12:55:40 -0500
Received: from [198.99.130.12] ([198.99.130.12]:26837 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964772AbWCTRzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 12:55:39 -0500
Date: Mon, 20 Mar 2006 12:56:33 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
Message-ID: <20060320175633.GA5797@ccure.user-mode-linux.org>
References: <17436.60328.242450.249552@cse.unsw.edu.au> <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr> <17438.13214.307942.212773@cse.unsw.edu.au> <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr> <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:17:59PM -0300, Matheus Izvekov wrote:
> If a filesystem is nodev, then what would you fsck? Am i missing something?

There's a UML filesystem for which the nodev-implies-no-fsck behavior
is inconvenient.  It stores its files as files on the host, where the
file metadata is stored separately from the file data.  If the two
fall out of sync after a crash, we need to fsck it.  In this case,
fsck would do a hostfs mount of the data and metadata (where the files
are available as they exist on the host) and fix things up.

So, in this case, the thing being fscked is a directory hierarchy on
the host.

				Jeff
