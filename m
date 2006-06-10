Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWFJOyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWFJOyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWFJOyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:54:23 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:18875 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751119AbWFJOyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:54:23 -0400
Message-ID: <448ADD15.3040109@garzik.org>
Date: Sat, 10 Jun 2006 10:54:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
CC: Adrian Bunk <bunk@stusta.de>, Mike Snitzer <snitzer@gmail.com>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org> <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com> <20060610134946.GC11634@stusta.de> <20060610135122.GA9039@infradead.org>
In-Reply-To: <20060610135122.GA9039@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Jun 10, 2006 at 03:49:46PM +0200, Adrian Bunk wrote:
>>> And no real-world near-term progress is made for production users with
>>> modern requirements. What you're advocating breeds instability in the
>>> near-term.
>> There's also the old-fashioned "no regressions" requirement.
>>
>> You are trading near-term instability for the few users with "modern 
>> requirements" against possible regressions for a large userbase.
> 
> Alex mentioned a few times that the extents code just adds three if.
> I'm pretty sure that will not give you any regressions in the existing
> codebase.  Can we concentrate on the more useful discussion topics now?

Alex is off by an order of magnitude.  I've re-read the 13-patch series, 
and this is the result of the review:

There are _five_ "if (new) .. else .." constructs added in JBD alone.

Three added in extent map support.

Twenty-seven (27) such constructs in 48-bit physical block support.

Two more in 48-bit ACL support.

And finally, the superblock changes don't add any branches, like the 
other code does, but it does double the endian conversion work that 
-every- user must do, even if they don't use 48bit at all.

	Jeff


