Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWCaQxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCaQxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWCaQxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:53:37 -0500
Received: from mx1.suse.de ([195.135.220.2]:42988 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750763AbWCaQxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:53:37 -0500
From: Andi Kleen <ak@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Date: Fri, 31 Mar 2006 18:53:32 +0200
User-Agent: KMail/1.9.1
Cc: Jes Sorensen <jes@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <87irpupo3y.fsf@duaron.myhome.or.jp>
In-Reply-To: <87irpupo3y.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311853.32870.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 18:37, OGAWA Hirofumi wrote:
> Jes Sorensen <jes@sgi.com> writes:
> 
> >   	struct poll_list *walk;
> >  	struct fdtable *fdt;
> >  	int max_fdset;
> > -	/* Allocate small arguments on the stack to save memory and be faster */
> > -	char stack_pps[POLL_STACK_ALLOC];
> > +	/* Allocate small arguments on the stack to save memory and be 
> > +	   faster - use long to make sure the buffer is aligned properly
> > +	   on 64 bit archs to avoid unaligned access */
> > +	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
> >  	struct poll_list *stack_pp = NULL;
> 
> struct poll_list stack_pps[POLL_STACK_ALLOC / sizeof(struct poll_list)];
> 
> is more readable, and probably gcc align it rightly?

Yes, but it would be wrong

-Andi

