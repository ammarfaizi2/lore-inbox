Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUEPKCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUEPKCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUEPKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 06:02:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:29372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263448AbUEPKCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 06:02:15 -0400
Date: Sun, 16 May 2004 03:01:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: torvalds@osdl.org, adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040516030136.2081898a.akpm@osdl.org>
In-Reply-To: <200405152231.15099.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
	<Pine.LNX.4.58.0405152029110.10718@ppc970.osdl.org>
	<200405152231.15099.elenstev@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> The script only reported one
>  iteration finished, while I got it to do 36 iterations over several hours earlier
>  today (with a 2.6.3-4mdk vendor kernel), so I'm going to add some timing 
>  tests to the script to see if things are really slowing down with current kernels,
>  or if it's just my worried imaginings.

I did a bit of testing on a 256MB laptop with a fairly slow disk, ext3. 
Three iterations of the test took:

2.6.6:		1055.53s user 327.14s system 32% cpu 1:10:06.71 total

2.4.27-pre2:	1042.03s user 307.21s system 32% cpu 1:09:46.00 total

2.6.3:		1053.23s user 326.16s system 27% cpu 1:22:07.24 total


So there's nothing particularly wild there.  It's possible I guess that the
2.6 VM is very sucky but something else made up for it - possibly the
anticipatory scheduler but more likely the Orlov allocator.

You're using reiserfs, yes?

Are you sure the IDE disks are in DMA mode?
