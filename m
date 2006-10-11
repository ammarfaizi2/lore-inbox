Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWJKRVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWJKRVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWJKRVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:21:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:23761 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161023AbWJKRVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:21:22 -0400
Date: Wed, 11 Oct 2006 19:21:20 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SPAM: Re: SPAM: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-ID: <20061011172120.GC5259@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org> <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org> <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org> <20061011165717.GB5259@wotan.suse.de> <Pine.LNX.4.64.0610111007000.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610111007000.3952@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 10:11:43AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 11 Oct 2006, Nick Piggin wrote:
> > > 
> > > The original IO could have been started by a person who didn't have 
> > > permissions to actually carry it out successfully, so if you enter with 
> > > the page locked (because somebody else started the IO), and you wait for 
> > > the page and it's not up-to-date afterwards, you absolutely _have_ to try 
> > > the IO, and can only return a real IO error after your _own_ IO has 
> > > failed.
> > 
> > Sure, but we currently try to read _twice_, don't we?
> 
> Well, we have the read-ahead, and then the real read. By the time we do 
> the real read, we have forgotten about the read-ahead details, so..

I mean filemap_nopage does *two* synchronous reads when finding a !uptodate
page. This is despite the comment saying that it retries once on error.

