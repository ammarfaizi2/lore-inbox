Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUBTUoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUBTUn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:43:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261380AbUBTUlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:41:51 -0500
From: Daniel Phillips <phillips@arcor.de>
To: paulmck@us.ibm.com
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Fri, 20 Feb 2004 15:37:26 -0500
User-Agent: KMail/1.5.4
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20040216190927.GA2969@us.ibm.com> <200402200007.25832.phillips@arcor.de> <20040220120255.GA1269@us.ibm.com>
In-Reply-To: <20040220120255.GA1269@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402201535.47848.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> I cannot think of any reasonable alternative to passing the parameter
> down either, as it certainly does not be reasonable to duplicate the
> code...

Yes, it's simply the (small) price that has to be paid in order to be able to 
boast about our accurate semantics.

> How about something like "private_too" instead of "zap"?

How about just "all", which is what we mean.

> > -void zap_page_range(struct vm_area_struct *vma,
> > -			unsigned long address, unsigned long size)
> > +void invalidate_page_range(struct vm_area_struct *vma,
>
> Would it be useful for this to be inline?  (Wouldn't seem so,
> zapping mappings has enough overhead that an extra level of
> function call should be deep down in the noise...)

Yes, it doesn't seem worth it just to save a stack frame.

Actually, I erred there in that invalidate_mmap_range should not export the 
flag, because it never makes sense to pass in non-zero from a DFS.

> Doesn't the new argument need to be passed down through
> invalidate_mmap_range_list()?

It does, thanks for the catch.  Please bear with me for a moment while I 
reroll this, then hopefully we can move on to the more interesting discussion 
of whether it's worth it.  (Yes it is :)

Regards,

Daniel

