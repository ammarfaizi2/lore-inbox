Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJMMUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJMMUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:20:39 -0400
Received: from asplinux.ru ([195.133.213.194]:63752 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261699AbTJMMUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:20:37 -0400
From: Kirill Korotaev <kk@sw.ru>
Reply-To: kk@sw.ru
Organization: SWsoft
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Date: Mon, 13 Oct 2003 16:21:33 +0400
User-Agent: KMail/1.5.1
References: <200310131318.09234.kk@sw.ru> <200310131602.20479.kk@sw.ru> <20031013121109.GJ16158@holomorphy.com>
In-Reply-To: <20031013121109.GJ16158@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131621.33079.kk@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point in the past, I wrote:
> >> Sorry if I was unclear, I had in mind SMP performance testing of mount
> >> and unmount -heavy workloads, like uni setups with many automounted
> >> fs's, not stability testing per se.
>
> On Mon, Oct 13, 2003 at 04:02:20PM +0400, Kirill Korotaev wrote:
> > Oh, sorry for misunderstanding.
> > In our internal testcase on 8-CPU 8Gb RAM machine with 4gb split kernel
> > w/o this patch mount/umount test longs in many-many (>10) times longer.
> > Moreover, during the test machine is very slow (due to lock_kernel)
> > and typing simple commands takes up to 30 seconds or so.
> > I think such a long hangs are due to number of umounts executed
> > subsequently. But ofcourse it's not numbers, just for you to know where
> > the patch comes from :)
>
> Is this testcase available and/or trivial? Actually, even if it's trivial
> it might just save us the pain of writing the scripts ourselves.
no, testcase is not available :( And it uses functionality
not available in mainstream kernel. But the problem can be hit with
very simple script instead:

1. mount N filesystems.
2. work on them, so that inode cache grows to its maximum
possible size (it was 1,000,000 of inodes in our case).
3. umount these filesystems.

During operation #3 node is very slow and it is quite noticable
on ssh console when typing commands.

Kirill

