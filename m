Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWFPHh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWFPHh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 03:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFPHh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 03:37:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:3470 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751154AbWFPHh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 03:37:29 -0400
From: Andi Kleen <ak@suse.de>
To: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 09:37:22 +0200
User-Agent: KMail/1.9.3
Cc: Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz
References: <200606140942.31150.ak@suse.de> <200606160822.23898.ak@suse.de> <44925C78.7030100@suse.de>
In-Reply-To: <44925C78.7030100@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606160937.22274.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 09:23, Gerd Hoffmann wrote:
> Andi Kleen wrote:
> >> Alternatively it means that this will almost always do the right thing, but
> >> once in a while it won't, your application will happen to have been migrated
> >> to a different cpu/node at the point it makes the call, and from then on
> >> this instance will behave oddly (running slowly because it allocates most
> >> of its memory on the wrong node).  When you try to reproduce the problem,
> >> the application will work normally.
> > 
> > That's inherent in NUMA. No good way around that.
> 
> Hmm, maybe it makes sense to allow binding memory areas to threads
> instead of nodes.  That way the kernel may attempt to migrate the pages
> to another node in case it migrates threads / processes.  Either via
> mbind(), or maybe better via madvise() to make clear it's a hint only.

I haven't tried that but I have talked to others who tried to implement
automatic page migration and they say they couldn't make that work (or rather
make it a win) either.

-Andi
