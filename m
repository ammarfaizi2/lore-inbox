Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTKYUYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTKYUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:24:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:21161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263130AbTKYUYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:24:50 -0500
Date: Tue, 25 Nov 2003 12:25:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: gwingerde@home.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT-3 bug with 2.6.0-test9
Message-Id: <20031125122504.47de1ea5.akpm@osdl.org>
In-Reply-To: <200311252051.15501.gwingerde@home.nl>
References: <200311252051.15501.gwingerde@home.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gertjan van Wingerde <gwingerde@home.nl> wrote:
>
> Hi,
> 
> (Please CC me in any replies, as I'm not subscribed to the list)
> 
> I've just experienced the strange behaviour that my /usr mount auto-magically 
> got mounted read-only, where it was mounted read-write (obviously). 
> Investigating the cause of this I've found the following EXT-3 related BUG in 
> my log-files:
> 
> 	kernel BUG at fs/jbd/journal.c:1733!

Yes.  This newly-added BUG check was too easy to trigger and in test10 it
was changed to a printk-and-fix-it-up.

> Nov 25 20:24:20 localhost vmunix: EXT3-fs warning (device md1): ext3_unlink: 
> Deleting nonexistent file (230991), 0
> Nov 25 20:24:21 localhost vmunix: EXT3-fs warning (device md1): ext3_unlink: 
> Deleting nonexistent file (230990), 0
> Nov 25 20:24:21 localhost vmunix: EXT3-fs warning (device md1): ext3_unlink: 
> Deleting nonexistent file (346096), 0

And it is this stuff which triggered the bogus BUG.  I do not know why this
happened, but it is probably some form of data loss problem at the md
layer.

It could have happened at any time after the most recent fsck, so if you
have been running earlier kernels on that machine it could even be that the
bug which caused this has already been fixed.

You should run a fsck across all filesystems, and maybe upgrade to test10
plus ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test10-bk1.gz


