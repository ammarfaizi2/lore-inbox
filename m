Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWGDWSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWGDWSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWGDWSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:18:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932317AbWGDWSk (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:18:40 -0400
Date: Tue, 4 Jul 2006 15:18:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: hch@infradead.org, vs@namesys.com, Linux-Kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
Message-Id: <20060704151832.9f2d87b3.akpm@osdl.org>
In-Reply-To: <44AAA8ED.5030906@namesys.com>
References: <44A42750.5020807@namesys.com>
	<20060629185017.8866f95e.akpm@osdl.org>
	<1152011576.6454.36.camel@tribesman.namesys.com>
	<20060704114836.GA1344@infradead.org>
	<44AAA8ED.5030906@namesys.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2006 10:44:13 -0700
Hans Reiser <reiser@namesys.com> wrote:

> Christoph Hellwig wrote:
> 
> >On Tue, Jul 04, 2006 at 03:12:56PM +0400, Vladimir V. Saveliev wrote:
> >  
> >
> >>>Should this be an address_space_operation or a file_operation?
> >>>
> >>>      
> >>>
> >>I was seeking to be minimal in my changes to the philosophy of the code.
> >>So, it was an address_space operation. Now it is a file operation.
> >>    
> >>
> >
> >It definitly should not be a file_operation! It works at the address_space
> >not the much higher file level.  Maybe all three should become callbacks
> >for the generic write routines, but that's left for the future.
> >
> >
> >  
> >
> I don't have a commitment to one way or the other, probably because
> there are some things that are unclear in my mind.  Could you help me
> with them?  Can you define what is the address space vs. the file level
> please?  It is odd to be asking such a basic question, but these things
> are genuinely unclear to me.  If the use of something varies according
> to the file, is it a file method?  What things vary according to address
> space and not according to file?  Should things that vary according to
> address space be address space ops and things that vary according to
> file be file ops?  If that logic seems valid, should a lot more be changed?
> 
> Oh, and Andrew, while such things are discussed, could you just pick one
> way or the other and let the patch go in?
> 

I wasn't sure, which was I asked rather than suggested..

Looking closer, yes I agree with Christoph, sorry.  It's called at the same
level as ->prepare_write/commit_write so if there's any logic to this, it's
logical that batched_write be an a_op too.

