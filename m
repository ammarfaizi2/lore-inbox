Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965308AbVKBWZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbVKBWZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbVKBWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:25:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:41652 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965308AbVKBWZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:25:20 -0500
Subject: Re: Nick's core remove PageReserved broke vmware...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
	 <4368139A.30701@vc.cvut.cz>
	 <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
	 <1130965454.20136.50.camel@gaston>
	 <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
	 <1130967936.20136.65.camel@gaston>
	 <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 09:22:10 +1100
Message-Id: <1130970131.20136.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 22:02 +0000, Hugh Dickins wrote:

> I wish everyone else would see it that way!  (But some people do
> have valid scenarios where it can't just be ruled out completely.)

Hehe, well, in my case it's not one, at least not yet :)

> > > Take a look at Andrew's educational comment on set_page_dirty_lock
> > > in mm/page-writeback.c.  You do have the list of pages you need to
> > > page_cache_release, don't you?  So it should be easy to dirty them.
> > 
> > Ok, so just passing 'write' to get_user_pages() is good enough; right ?
> 
> Not quite, I think: you need to pass 'write' to get_user_pages()
> initially; but at the end, if it was indeed writing into user space,
> you need to do the set_page_dirty_lock thing on each of the pages
> before page_cache_release, just in case a race cleaned them before
> the DMA completed.  I think (I've never used it myself).

Oh, I see... I can't prevent them from being cleaned during the DMA
then... Ok, will do that.

Also, what do you suggest as a good threshold to use on the max amount
of memory I can let the X server "pin" that way ? I was thinking it as
equivalent to mlock, thus I could maybe hijack mm->locked_vm & use
RLIMIT_MEMLOCK or is that too gross ?

Ben.



