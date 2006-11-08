Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965716AbWKHNIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965716AbWKHNIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 08:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965718AbWKHNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 08:08:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59804 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965716AbWKHNIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 08:08:46 -0500
Date: Wed, 8 Nov 2006 14:08:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jason Baron <jbaron@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
Message-ID: <20061108130833.GA9599@elf.ucw.cz>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com> <20061106200529.GA15370@elte.hu> <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * Jason Baron <jbaron@redhat.com> wrote:
> > 
> > > I've implemented this as a /proc file, but Ingo suggested that it 
> > > might be better for us to simply produce an adjaceny list, and then 
> > > generate a locking hierarchy or anything else of interest off of that 
> > > list.... [...]
> > 
> > this would certainly be the simplest thing to do - we could extend 
> > /proc/lockdep with the list of 'immediately after' locks separated by 
> > commas. (that list already exists: it's the lock_class.locks_after list)
> > 
> > i like your idea of using lockdep to document locking hierarchies.
> > 
> > 	Ingo
> > 
> 
> hi,
> 
> So below is patch that does what you suggest, although i had to add the 
> concept of 'distance' to the patch since the locks_after list loses this 
> dependency info afaict. i also wrote a user space program to sort the 
> locks into cluster of interelated locks and then sorted within these 
> clusters...the results show one large clump of locks...perhaps there are a 
> few locks that time them all together like scheduler locks...but i 
> couldn't figure out which ones to exclude to make the list look really 
> pretty (also, there could be a bug in my program :). Anyways i'm including 
> my test program and its output too...

Perhaps presenting it as a tree is worth it?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
