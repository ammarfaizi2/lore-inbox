Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275650AbRIZV6I>; Wed, 26 Sep 2001 17:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275649AbRIZV56>; Wed, 26 Sep 2001 17:57:58 -0400
Received: from [195.223.140.107] ([195.223.140.107]:11249 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275648AbRIZV5n>;
	Wed, 26 Sep 2001 17:57:43 -0400
Date: Wed, 26 Sep 2001 23:58:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10aa1 - 0-order allocation failed.
Message-ID: <20010926235817.W27945@athlon.random>
In-Reply-To: <20010926233451.V27945@athlon.random> <Pine.LNX.4.21.0109261722010.957-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109261722010.957-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Sep 26, 2001 at 05:24:28PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 05:24:28PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> 
> 
> <snip>
> 
> > > Andrea, 
> > > 
> > > This is going to make __GFP_NOFS allocations call writepage(): deadlock. 
> > 
> > (side note: I assume you mean GFP_NOFS)
> > 
> > GFP_NOFS will never call writepage with the above change, obviously
> > because __GFP_FS isn't set. So it can't deadlock.
> 
> if ((gfp_mask & __GFP_FS) && ((gfp_mask & __GFP_HIGHIO) || !PageHighMem(page)) && writepage) {
			    ^^
> 					
> 							^^ ^^^^^  ^^^^     ^^^^^
> 
> If the page is not highmem, we are going to write the page. (independantly
> of any GFP flag)
> 
> I'm I over looking something ? 

the && on the left of the (((gfp_mask & __GFP_HIGHIO) || !PageHighMem(page)).

Andrea
