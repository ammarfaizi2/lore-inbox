Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275641AbRIZVri>; Wed, 26 Sep 2001 17:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275640AbRIZVr2>; Wed, 26 Sep 2001 17:47:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52498 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275641AbRIZVrS>; Wed, 26 Sep 2001 17:47:18 -0400
Date: Wed, 26 Sep 2001 17:24:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10aa1 - 0-order allocation failed.
In-Reply-To: <20010926233451.V27945@athlon.random>
Message-ID: <Pine.LNX.4.21.0109261722010.957-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Sep 2001, Andrea Arcangeli wrote:


<snip>

> > Andrea, 
> > 
> > This is going to make __GFP_NOFS allocations call writepage(): deadlock. 
> 
> (side note: I assume you mean GFP_NOFS)
> 
> GFP_NOFS will never call writepage with the above change, obviously
> because __GFP_FS isn't set. So it can't deadlock.

if ((gfp_mask & __GFP_FS) && ((gfp_mask & __GFP_HIGHIO) || !PageHighMem(page)) && writepage) {
					
							^^ ^^^^^  ^^^^     ^^^^^

If the page is not highmem, we are going to write the page. (independantly
of any GFP flag)

I'm I over looking something ? 


