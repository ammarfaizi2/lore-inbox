Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265474AbUF2FkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbUF2FkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUF2FkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:40:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265474AbUF2FkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:40:18 -0400
Date: Tue, 29 Jun 2004 06:40:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Paul Menage <menage@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race in iput()?
Message-ID: <20040629054017.GZ12308@parcelfarce.linux.theplanet.co.uk>
References: <6599ad830406282140a6310fe@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830406282140a6310fe@mail.google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 09:40:10PM -0700, Paul Menage wrote:
> Hi,
> 
> Is the following sequence of events possible? If so, that would seem
> to be a bug.
> 
> - inode on non-MS_ACTIVE superblock is on unused list (fs being unmounted?)
> - prune_icache() starts processing inode, so sets I_LOCK
> - in another thread, someone calls iget() then iput() on inode 

Umm...  What would that other thread be?  MS_ACTIVE is removed upon the final
umount, all right, but that's done only when nobody except the filesystem
itself should be able to even see it...
