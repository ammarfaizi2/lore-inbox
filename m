Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVBDWLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVBDWLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266518AbVBDWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:08:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:45952 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265633AbVBDWAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:00:53 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.61573.300431.860574@tut.ibm.com>
Date: Fri, 4 Feb 2005 16:00:37 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
In-Reply-To: <20050204211014.GA25680@infradead.org>
References: <16899.55393.651042.627079@tut.ibm.com>
	<20050204211014.GA25680@infradead.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > First set of comments.  Mostly ignores the actual filesystem sematics
 > bits, that'll come next.
 > 
 > 
 > > +#
 > > +# relayfs Makefile
 > > +#
 > 
 > probably superflous comment ;-)
 > 
 > > +	mem = vmap(*page_array, *page_count, GFP_KERNEL, PAGE_KERNEL);
 > 
 > Do you really need to vmap it, and eat up vmallocspace and TLB entries?
 > Maybe some simple arithmetics on a page array could replace it?
 > 

I would really like to not vmap it, but I don't know how else to
create a large kernel virtual address space for the large buffers that
might be needed for some applications like ltt.  Maybe managing a
bunch of large kmalloc'ed buffers instead would work, but there's no
guarantee how many of those you'd be able to get at one time.  Doing
arithmetic on pages seems like it would be too much overhead for the
fast logging path, but please let me know if I'm missing something.

Thanks for all the other comments - I'll be sure to make those fixes.

Tom

