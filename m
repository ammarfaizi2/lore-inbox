Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTDXA1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTDXA1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:27:25 -0400
Received: from [12.47.58.232] ([12.47.58.232]:45248 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264340AbTDXA1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:27:23 -0400
Date: Wed, 23 Apr 2003 17:37:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: cat@zip.com.au, pavel@ucw.cz, mbligh@aracnet.com, gigerstyle@gmx.ch,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423173720.6cc5ee50.akpm@digeo.com>
In-Reply-To: <1051143408.4305.15.camel@laptop-linux>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
	<20030423170759.2b4e6294.akpm@digeo.com>
	<20030424001733.GB678@zip.com.au>
	<1051143408.4305.15.camel@laptop-linux>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 00:39:24.0420 (UTC) FILETIME=[F426DC40:01C309F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> wrote:
>
> On Thu, 2003-04-24 at 12:17, CaT wrote:
> > I'm curious. What does a swapfile solve that a swapdev does not? Either
> > way you need to prealloc the case (either have a chunky file in a
> > partition or a partition set aside) or you need to keep enough room
> > avail to fit the file when it's needed.
> 
> Nothing but further bloat in swsusp :> With a swapfile, we need to know
> the location of the file (and be able to find it again when it changes,
> and know how to find the next block in the file system - it might be
> fragmented).

That's because swsusp is using the mm/page_io.c functions for suspend, but
is using the fs/buffer.c functions direct to the blockdev for resume.

If you can use the swapper_space a_ops for both suspend and resume (say:
"cleanup") then it will just work.

