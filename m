Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbUCJT77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUCJT7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:59:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:42373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262759AbUCJT7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:59:44 -0500
Date: Wed, 10 Mar 2004 12:01:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/root: which approach ? [PATCH]
Message-Id: <20040310120145.248ae62d.akpm@osdl.org>
In-Reply-To: <20040310162003.GA25688@cistron.nl>
References: <20040310162003.GA25688@cistron.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
> Currently if you boot from a blockdevice with a dynamically
> allocated major number (such as LVM or partitionable raid),
> there is no way to check the root filesystem. The root
> fs is still read-only, so you cannot create a device node
> anywhere to point fsck at.
> 
> This was discussed on the linux-raid mailinglist, and I proposed
> (as proof of concept) a simple check in bdget() to see if the
> device is being opened is the /dev/root node and if so redirect
> it to the current root device. This is a 8-line patch, the only
> disadvantage I can think of is that for an open file, inode->i_rdev
> is then different from blockdevice->bd_dev.

The /dev/root alias resolution looks nice to me, which probably means that
it has a fatal flaw.

Is it not possible to create a device node on ramfs or ramdisk and point
fsck at that?

