Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUHaW6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUHaW6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUHaWz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:55:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1265 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268527AbUHaWwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:52:54 -0400
Date: Wed, 1 Sep 2004 00:52:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
Message-ID: <20040831225244.GY3466@fs.tum.de>
References: <20040831221348.GW3466@fs.tum.de> <20040831153649.7f8a1197.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831153649.7f8a1197.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 03:36:49PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > An issue that we already discussed at 2.6.8-rc2-mm2 times:
> > 
> > 2.6.9-rc1 includes __always_inline which was formerly in  -mm.
> > __always_inline doesn't make any sense:
> > 
> > __always_inline is _exactly_ the same as __inline__, __inline and inline .
> > 
> > 
> > The patch below removes __always_inline again:
> 
> But what happens if we later change `inline' so that it doesn't do
> the `always inline' thing?
> 
> An explicit usage of __always_inline is semantically different than
> boring old `inline'.

Who audits all current users of inline whether they are __always_inline?

Who ensures, that in the future there will always be the right one of 
inline and __always_inline choosen in the kernel?


If it doesn't give a compile or runtime error for anyone when it's 
wrong, many wrong inline/__always_inline will go into the kernel over 
time.

The intention might be a different semantics, but in the end, it won't 
work.


E.g., check how many wrong __init/__exit annotations show up in 2.6, 
each of whom would have been a compile error in 2.4 (and different 
from a wrong inline/__always_inline, a wrong __init/__exit annotation 
can cause real problems for users).


If you want to change inline at some point, you will have to audit all  
users of inline anyway - so why bother if you don't intend to change 
inline in the forseeable future?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

