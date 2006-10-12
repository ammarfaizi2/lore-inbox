Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWJLPhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWJLPhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWJLPhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:37:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932629AbWJLPht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:37:49 -0400
Date: Thu, 12 Oct 2006 08:37:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <npiggin@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
In-Reply-To: <20061012033358.GC22558@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0610120834580.3952@g5.osdl.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
 <20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org>
 <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org>
 <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org> <20061011165717.GB5259@wotan.suse.de>
 <Pine.LNX.4.64.0610111007000.3952@g5.osdl.org> <20061011172120.GC5259@wotan.suse.de>
 <Pine.LNX.4.64.0610111031020.3952@g5.osdl.org> <20061012033358.GC22558@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Oct 2006, Nick Piggin wrote:
> 
> > Are you saying that something like this would be preferable?
> 
> I think so, it is neater and clearer. I actually didn't even bother relocking
> and checking the page again on readpage error so got rid of quite a bit of
> code.

Well, the readpage error should be rare (and for the _normal_ case we just 
do the "wait_on_page_locked()" thing). And I think we should lock the page 
in order to do the truncation check, no?

But I don't have any really strong feelings. I'm certainly ok with the 
patch I sent out. How about putting it through -mm? Here's my sign-off:

	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

if you want to send it off to Andrew (or if Andrew wants to just take it 
himself ;)

Btw, how did you even notice this? Just by reading the source, or because 
you actually saw multiple errors reported?

		Linus
