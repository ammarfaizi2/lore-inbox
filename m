Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWEJLqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWEJLqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWEJLqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:46:39 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:25249 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964934AbWEJLqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:46:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: cleanup swap unused warning
Date: Wed, 10 May 2006 21:46:25 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200605102132.41217.kernel@kolivas.org> <20060510043834.70f40ddc.akpm@osdl.org>
In-Reply-To: <20060510043834.70f40ddc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605102146.26080.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 21:38, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Are there any users of swp_entry_t when CONFIG_SWAP is not defined?
>
> Well there shouldn't be.  Making accesses to swp_entry_t.val fail to
> compile if !CONFIG_SWAP might be useful.
>
> > +/*
> > + * A swap entry has to fit into a "unsigned long", as
> > + * the entry is hidden in the "index" field of the
> > + * swapper address space.
> > + */
> > +#ifdef CONFIG_SWAP
> >  typedef struct {
> >  	unsigned long val;
> >  } swp_entry_t;
> > +#else
> > +typedef struct {
> > +	unsigned long val;
> > +} swp_entry_t __attribute__((__unused__));
> > +#endif
>
> We have __attribute_used__, which hides a gcc oddity.

I tried that.

In file included from arch/i386/mm/pgtable.c:11:
include/linux/swap.h:82: warning: ‘__used__’ attribute ignored
In file included from include/linux/suspend.h:8,
                 from init/do_mounts.c:7:
include/linux/swap.h:82: warning: ‘__used__’ attribute ignored
In file included from arch/i386/mm/init.c:22:
include/linux/swap.h:82: warning: ‘__used__’ attribute ignored
  AS      arch/i386/kernel/vsyscall-sysenter.o

etc..

and doesn't fix the warning in vmscan.c. __attribute_used__ is handled 
differently by gcc4 it seems (this is 4.1.0)

-- 
-ck
