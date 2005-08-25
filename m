Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVHYNJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVHYNJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVHYNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:09:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22939 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964967AbVHYNJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:09:46 -0400
Date: Thu, 25 Aug 2005 14:12:52 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Al Viro <viro@www.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
Message-ID: <20050825131251.GR9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.62.0508251038360.28348@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508251038360.28348@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 10:41:27AM +0200, Geert Uytterhoeven wrote:
> >  
> > +static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
> 					^^^^^^^^^^^^^^^^^^^^^
> 					const struct task_struct *p?

Umm...  Wouldn't be a problem, but what does it buy?  The only caller
has p very much _not_ const pointer and since it's inlined, you won't
gain any optimizations in the caller out of it.
 
> > +{
> > +	*ti = *p->thread_info;
> > +}
> > +
> > +static inline unsigned long *end_of_stack(struct task_struct *p)
> 					     ^^^^^^^^^^^^^^^^^^^^^
> 					     const struct task_struct *p?

That one is OK, but then you really want const pointer out of it.
