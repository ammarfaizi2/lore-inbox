Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUANWpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUANWpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:45:18 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:23196 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264476AbUANWpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:45:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 14 Jan 2004 14:45:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrew Morton <akpm@osdl.org>
cc: jdike@addtoit.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] /dev/anon
In-Reply-To: <20040114143221.25dd7c7e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0401141442520.2091-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, Andrew Morton wrote:

> Davide Libenzi <davidel@xmailserver.org> wrote:
> >
> > On Wed, 14 Jan 2004, Jeff Dike wrote:
> > 
> > > > I thought your goal was to release memory 
> > > > to the host, that's why I proposed sys_madvise(MADV_DONTNEED).
> > > 
> > > It is, I want memory released immediately as though it were clean, and
> > > MADV_DONTNEED doesn't help.
> > 
> > Strange, I didn't notice this before. If you look at the comment in 
> > mm/madvise.c:madvise_dontneed, it advertises that dirty pages are actually 
> > thrown away (that would be what you're actually looking for). But if you 
> > go down to zap_page_range -> unmap_vmas -> unmap_page_range -> 
> > zap_pmd_range -> zap_pte_range, if the page is dirty, set_page_dirty -> 
> > __set_page_dirty_buffers pushes the page into the mapping dirty pages list 
> > and __mark_inode_dirty push the inode inside the superblock dirty list. So 
> > the comment seems to be wrong (I also verified this with a simple program, 
> > and pages are actually flushed).
> > 
> 
> We cannot invalidate the pages due to MADV_DONTNEED: there may be
> freshly-allocated, unwritten file blocks associated with them.  You'd have
> to be playing games with write() amd MAP_SHARED to do this.

That's fine Andrew. It was the comment that looked strange to me. We 
actually do sync dirty pages, while the comment says we throw them away.



- Davide


