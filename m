Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWJLPlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWJLPlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWJLPlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:41:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:21968 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932257AbWJLPk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:40:59 -0400
Date: Thu, 12 Oct 2006 17:40:57 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-ID: <20061012154057.GC18463@wotan.suse.de>
References: <20061010213843.4478ddfc.akpm@osdl.org> <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org> <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org> <20061011165717.GB5259@wotan.suse.de> <Pine.LNX.4.64.0610111007000.3952@g5.osdl.org> <20061011172120.GC5259@wotan.suse.de> <Pine.LNX.4.64.0610111031020.3952@g5.osdl.org> <20061012033358.GC22558@wotan.suse.de> <Pine.LNX.4.64.0610120834580.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610120834580.3952@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 08:37:39AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 12 Oct 2006, Nick Piggin wrote:
> > 
> > > Are you saying that something like this would be preferable?
> > 
> > I think so, it is neater and clearer. I actually didn't even bother relocking
> > and checking the page again on readpage error so got rid of quite a bit of
> > code.
> 
> Well, the readpage error should be rare (and for the _normal_ case we just 
> do the "wait_on_page_locked()" thing). And I think we should lock the page 
> in order to do the truncation check, no?

Definitely.

> But I don't have any really strong feelings. I'm certainly ok with the 
> patch I sent out. How about putting it through -mm? Here's my sign-off:
> 
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> if you want to send it off to Andrew (or if Andrew wants to just take it 
> himself ;)

OK... maybe it can wait till the other changes, and we can think about
it then. I'll carry around the split out patct, though.

> Btw, how did you even notice this? Just by reading the source, or because 
> you actually saw multiple errors reported?

Reading the source, thinking about the cleanups we can do if filemap_nopage
takes the page lock...

