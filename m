Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTJMM3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJMM3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:29:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:3286 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261695AbTJMM3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:29:07 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16266.39568.286607.206395@laputa.namesys.com>
Date: Mon, 13 Oct 2003 16:29:04 +0400
To: kk@sw.ru
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalidate_inodes can be very slow
In-Reply-To: <200310131621.33079.kk@sw.ru>
References: <200310131318.09234.kk@sw.ru>
	<200310131602.20479.kk@sw.ru>
	<20031013121109.GJ16158@holomorphy.com>
	<200310131621.33079.kk@sw.ru>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev writes:
 > > At some point in the past, I wrote:
 > > >> Sorry if I was unclear, I had in mind SMP performance testing of mount
 > > >> and unmount -heavy workloads, like uni setups with many automounted
 > > >> fs's, not stability testing per se.
 > >
 > > On Mon, Oct 13, 2003 at 04:02:20PM +0400, Kirill Korotaev wrote:
 > > > Oh, sorry for misunderstanding.
 > > > In our internal testcase on 8-CPU 8Gb RAM machine with 4gb split kernel
 > > > w/o this patch mount/umount test longs in many-many (>10) times longer.
 > > > Moreover, during the test machine is very slow (due to lock_kernel)
 > > > and typing simple commands takes up to 30 seconds or so.
 > > > I think such a long hangs are due to number of umounts executed
 > > > subsequently. But ofcourse it's not numbers, just for you to know where
 > > > the patch comes from :)
 > >
 > > Is this testcase available and/or trivial? Actually, even if it's trivial
 > > it might just save us the pain of writing the scripts ourselves.
 > no, testcase is not available :( And it uses functionality
 > not available in mainstream kernel. But the problem can be hit with
 > very simple script instead:
 > 
 > 1. mount N filesystems.
 > 2. work on them, so that inode cache grows to its maximum
 > possible size (it was 1,000,000 of inodes in our case).
 > 3. umount these filesystems.
 > 
 > During operation #3 node is very slow and it is quite noticable
 > on ssh console when typing commands.

This can be due to a number of reasons (worst case behavior of
shrink_dcache_parent() for example). What /proc/profile shows?

 > 
 > Kirill

Nikita.

 > 
