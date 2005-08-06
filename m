Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVHFXAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVHFXAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 19:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVHFXAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 19:00:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261277AbVHFXAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 19:00:11 -0400
Date: Sat, 6 Aug 2005 15:58:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: hch@infradead.org, ak@suse.de, linux-kernel@vger.kernel.org,
       riel@redhat.com, chrisw@osdl.org, pratap@vmware.com
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch
 layer (i386)
Message-Id: <20050806155832.28f77c37.akpm@osdl.org>
In-Reply-To: <42F5016A.2020900@vmware.com>
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel>
	<p73wtmz1ekk.fsf@bragg.suse.de>
	<20050806115619.GA1560@infradead.org>
	<20050806115836.GN8266@wotan.suse.de>
	<20050806120141.GA1827@infradead.org>
	<42F5016A.2020900@vmware.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> wrote:
>
> >Yeah, I said ugly ones specificly.  There's been some nice previous ones,
>  >but most in this series (all the move of stuff to subarches) are rather
>  >horrible and lack lots of explanation.
>  >  
>  >
> 
>  All of my previous patches have been aimed at fixing bugs, improving 
>  performance, reliability and maintinability of the i386 architecture.  

Yup, with one or two semi-exceptions, all the patches up to this series
seem to be good general cleanups - certainly it's good to move all those
open-coded asm statements into single-site inlines and macros: people keep
on screwing them up.

We do need to wake the Xen poeple up, make sure that these changes suit
them as well, or at least don't screw them over (hard to see how it could
though).

>  If you found something that didn't fit one of those categories in my 
>  previous patches, then it is either not well enough explained or perhaps 
>  inadvertently slipped through from one of my more radical trees - or it 
>  could be a bug.
> 
>  There is a simple explanation for all of this series.  The goal is to 
>  move all privileged instructions, sensitive instructions, and privilege 
>  awareness into a layer where it can be overridden by new code without 
>  disrupting the default architecture.  On x86, there are a lot of 
>  instructions - popf, iret, sgdt, and others which behave differently 
>  under different privilege levels, but do not trap.  These architectural 
>  features must be redefined by any architecture which virtualizes the 
>  x86, be it Xen, UML, or an alternative approach.  Similarly, certain 
>  privileged processor data structures (page tables, descriptor tables) 
>  must be protected and accessed in a different manner if one is to 
>  utilize the principles of paravirtualization to achieve high performance 
>  inside of a virtual machine.  I believe this series of patches is one 
>  almost clean solution to this.  There are obvious problems with the MMU 
>  patch, and I'm still trying to come up with a way to properly address that.

Yes this later series is in a different category and will require more
review/coordination/discussion/waking-up from the Xen team.
