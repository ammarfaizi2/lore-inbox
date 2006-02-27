Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWB0Av1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWB0Av1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWB0Av0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:51:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750718AbWB0Av0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:51:26 -0500
Date: Sun, 26 Feb 2006 16:51:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: col-pepper@piments.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
Message-Id: <20060226165114.e87fe056.akpm@osdl.org>
In-Reply-To: <op.s5lrw0hrj68xd1@mail.piments.com>
References: <op.s5lrw0hrj68xd1@mail.piments.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

col-pepper@piments.com wrote:
>
> There is nothing in the spec of vfat that suggests the FAT will be written
> 10.000 during the writing of one large file. Indeed it is hard to imagine
> that any other implementation on any other OS or any previous linux kernel
> behaves like that.

We sync the file metadata once per write() syscall.  If your app writes a
large file in lots of little bits, it'll do a lot of syncs.  Other
implementations of fatfs will (must) do the same thing.

> It would seem that the first step could be to revert to the 2.6.11
> behaviour which was more appropriate and probably safer even from the data
> point of view.

fatfs used to be buggy - it didn't implement `-o sync'.  Now it does, and
what we're seeing is the fallout from the late fixing of that bug.

You're right - people need to understand what they're doing, make their own
decision, then remove the `-o sync' option.  There aren't any easy
solutions.

