Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVHHHXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVHHHXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVHHHXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:23:05 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:7835 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750746AbVHHHXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:23:04 -0400
Subject: Re: overcommit verses MAP_NORESERVE
From: Nicholas Miell <nmiell@comcast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1123415381.9464.29.camel@localhost.localdomain>
References: <1123386755.26540.9.camel@localhost.localdomain>
	 <1123415381.9464.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 00:22:57 -0700
Message-Id: <1123485777.17857.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8.njm.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 12:49 +0100, Alan Cox wrote:
> On Sad, 2005-08-06 at 20:52 -0700, Nicholas Miell wrote:
> > Why does overcommit in mode 2 (OVERCOMMIT_NEVER) explicitly force
> > MAP_NORESERVE mappings to reserve memory?
> > 
> > My understanding is that MAP_NORESERVE is a way for apps to state that
> > they are aware that the memory allocated may not exist and that they
> > might get a SIGSEGV and that's OK with them.
> 
> Because a MAP_NORESERVE space that is filled with pages might cause
> insufficient memory to be left available for another object that is not
> MAP_NORESERVE.
> 
> You are right it could be improved but that would require someone
> writing code that forcibly reclaimed MAP_NORESERVE objects when we were
> close to out of memory.  At the moment nobody has done this, but nothing
> is stopping someone having a go.

I don't think you can forcibly reclaim MAP_NORESERVE objects (I'm
assuming you mean completely throwing away dirty pages).

MAP_NORESERVE isn't standardized, so all we can go by is what everybody
else does (and what makes the most sense).

Based on the Linux and Solaris man pages (none of FreeBSD, Irix, HP-UX,
or AIX implement anything similar), I think calls to mmap() with
MAP_NORESERVE should always succeed (regardless of memory conditions,
not other errors) and individual writes to unallocated pages in a
MAP_NORESERVE region should either allocate a new page if possible or
send a SIGSEGV without triggering the OOM killer.

-- 
Nicholas Miell <nmiell@comcast.net>

