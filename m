Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWA0F4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWA0F4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWA0F4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:56:18 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61634 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751200AbWA0F4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:56:18 -0500
Date: Fri, 27 Jan 2006 06:56:07 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060127055607.GA9331@osiris.boeblingen.de.ibm.com>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com> <20060127032513.GA12559@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127032513.GA12559@suse.de>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There seems to be a bug in debugfs: it seems it doesn't get the hard link
> > count right. See the output below. This happened on s390x with git tree
> > of today. Any ideas?
> What code were you using that called debugfs?  Is it in the mainline
> tree?

It's the s390 debug feature in arch/s390/kernel/debug.c. It's completely in
the mainline tree.

> $ cd /sys/kernel/debug/
> $ find .
> .
> ./uhci
> [...]
> $ stat .
>   File: `.'
>   Size: 0               Blocks: 0          IO Block: 4096   directory
> Device: eh/14d  Inode: 15528       Links: 2

Links should be 3, I thought? For an empty directory it's 2 and as soon as
you create a new directory in there it should be increased by 1. Therefore
it should be 3. Or am I missing something?

Btw.: my find version: "GNU find version 4.2.20".

Thanks,
Heiko
