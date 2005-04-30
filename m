Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVD3S1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVD3S1N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVD3S1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:27:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261332AbVD3S1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:27:06 -0400
Date: Sat, 30 Apr 2005 20:26:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: [2.6 patch] fs/jbd/: possible cleanups
Message-ID: <20050430182651.GG3571@stusta.de>
References: <20050422235717.GI4355@stusta.de> <20050425222416.GX4752@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425222416.GX4752@schnapps.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 04:24:16PM -0600, Andreas Dilger wrote:
> On Apr 23, 2005  01:57 +0200, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - make needlessly global functions static
> > - #if 0 the following unused global functions:
> >   - journal.c: __journal_internal_check
> 
> >  /* Static check for data structure consistency.  There's no code
> >   * invoked --- we'll just get a linker failure if things aren't right.
> 
> The comment above this function specifically says no code is generated
> here - the purpose of this function is to generate an error if the
> journal superblock is the wrong size (e.g. someone adds fields without
> updating the padding).

Ah, that's the part I didn't understand about it.

I still don't like this creating an empty global function.

What about moving it into one of the other functions (e.g. 
journal_init)?

>...
> >   - journal.c: journal_check_used_features
> 
> I'm not aware of any current users of journal_check_used_features(), but
> the complementary function journal_check_available_features() IS used by
> ext3 and I can imagine that if we ever need to add some more journaling
> features it would be useful instead of mucking in the journal internals.
>...

My patch changes it from a global EXPORT_SYMBOL'ed function to a static 
function.

If ext3 will ever require it undoing my change shouldn't be a problem.

> Cheers, Andreas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

