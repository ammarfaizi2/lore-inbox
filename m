Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTDXJRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbTDXJRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:17:12 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:19387 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262272AbTDXJRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:17:11 -0400
Date: Thu, 24 Apr 2003 11:27:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424092742.GD3039@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1051142550.4306.10.camel@laptop-linux> <1605730000.1051145146@flay> <1051152437.2453.26.camel@laptop-linux> <28790000.1051159060@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28790000.1051159060@[10.10.2.4]>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Regarding #2, my algorithm (ie not the version in 2.5 at the mo)
> > separates pages to be saved into 2 types. Pageset1 are pages we expect
> > to be needed during suspend. Pageset2 is those that will definitely not
> > be needed. My algorithm for saving the data goes: Save pageset2 pages to
> > disk then (as per the original/current method) make a copy of pageset1
> > pages (using the pageset2 locations + extra allocated memory if needsbe)
> > and save the copy. Loading the image is the reverse process. Pageset 2
> > currently only consists of all highmem pages + active and inactive list
> > pages. 
> 
> Not sure that quite works ... don't you need PTE's to know what to swap
> out? Those can be in highmem. However, all user pages would fit in pageset
> 2, I think.
> 
> > If we refined the algorithm, perhaps that would address your
> > issue. The other point here is that since we have to be able to make a
> > copy of pageset1 pages, and since I haven't inlined kmap/unmap in the
> > routine to copy pageset1 pages back on resume (Pavel will say whew to
> > that, I'm sure!), pageset1 has a miximum size of half normal memory. I
> > reckon refining the algoritm so that pageset1 can be [nearly] guaranteed
> > to always be smaller is the better area to focus on, and I'm perfectly
> > happy to try suggestions, particularly when they come in the form of a
> > code fragment that include a call to SetPagePageset2(struct page * page)
> > for the relevant targets :>
> 
> The more I think about this, the more it seems so much simpler to just
> require a reserved swap area the size of your RAM to suspend into. Would
> make the code so much simpler ... forget the option bit I suggested earlier
> ;-)

Reserved area does not make anything any simpler... Remember, you want
to avoid having second set of poll-driven disk drivers just for
suspend-to-disk. Its quite hard to design with that in mind.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
