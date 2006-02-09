Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWBIInQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWBIInQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWBIInQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:43:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWBIInO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:43:14 -0500
Date: Thu, 9 Feb 2006 00:42:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209004208.0ada27ef.akpm@osdl.org>
In-Reply-To: <43EAFEB9.2060000@yahoo.com.au>
References: <20060209071832.10500.qmail@science.horizon.com>
	<20060209001850.18ca135f.akpm@osdl.org>
	<43EAFEB9.2060000@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> 
> > 
> > 2.4:
> > 
> > 	MS_ASYNC: dirty the pagecache pages, start I/O
> > 	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O
> > 
> > 2.6:
> > 
> > 	MS_ASYNC: dirty the pagecache pages
> > 	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O.
> > 
> > So you're saying that doing the I/O in that 25-100msec window allowed your
> > app to do more pipelining.
> > 
> > I think for most scenarios, what we have in 2.6 is better: it gives the app
> > more control over when the I/O should be started. 
> 
> How so?
> 

Well, for example you might want to msync a number of disjoint parts of the
mapping, then write them all out in one hit.

Or you may not actually _want_ to start the I/O now - you just want pdflush
to write things back in a reasonable time period, so you don't have unsynced
data floating about in memory for eight hours.  That's a quite reasonable
application of msync(MS_ASYNC).

