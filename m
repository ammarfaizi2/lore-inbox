Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUIBTqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUIBTqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUIBTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:46:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46574 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268440AbUIBTqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:46:07 -0400
Date: Thu, 2 Sep 2004 21:46:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@linuxmail.org, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
Message-ID: <20040902194600.GE15358@fs.tum.de>
References: <20040831221348.GW3466@fs.tum.de> <20040831153649.7f8a1197.akpm@osdl.org> <20040831225244.GY3466@fs.tum.de> <1093993946.8943.33.camel@laptop.cunninghams> <20040831163914.4c7c543c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831163914.4c7c543c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 04:39:14PM -0700, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> >
> > Hi.
> > 
> > On Wed, 2004-09-01 at 08:52, Adrian Bunk wrote:
> > > On Tue, Aug 31, 2004 at 03:36:49PM -0700, Andrew Morton wrote:
> > > > Adrian Bunk <bunk@fs.tum.de> wrote:
> > > > >
> > > > > An issue that we already discussed at 2.6.8-rc2-mm2 times:
> > > > > 
> > > > > 2.6.9-rc1 includes __always_inline which was formerly in  -mm.
> > > > > __always_inline doesn't make any sense:
> > > > > 
> > > > > __always_inline is _exactly_ the same as __inline__, __inline and inline .
> > > > > 
> > > > > 
> > > > > The patch below removes __always_inline again:
> > > > 
> > > > But what happens if we later change `inline' so that it doesn't do
> > > > the `always inline' thing?
> > > > 
> > > > An explicit usage of __always_inline is semantically different than
> > > > boring old `inline'.
> > 
> > Excuse me if I'm being ignorant, but I thought always_inline was
> > introduced because with some recent versions of gcc, inline wasn't doing
> > the job (suspend2, which requires a working inline, was broken by it for
> > example).
> 
> IIRC, the compiler was generating out-of-line versions of functions in
> every compilation unit whcih included the header file.  When we the
> developers just wanted `inline' to mean `inline, dammit'.

`inline, dammit' is
  __attribute__((always_inline))

The original `inline' never guarantees that the function will be 
inlined.

Therefore, `inline' is already #define'd in the Linux kernel to always 
be __attribute__((always_inline)).

> If that broke swsusp in some manner then the relevant swsusp functions
> should be marked always_inline, because they have some special needs.
> 
> > That is to say, doesn't the definition of always_inline vary
> > with the compiler version?
> 
> If the compiler supports attribute((always_inline)) then the kernel build
> system will use that.  If the compiler doesn't support
> attribute((always_inline)) then we just emit `inline' from cpp and hope
> that it works out.

That's exactly how `inline' is already #define'd in the Linux kernel.

And __always_inline is currently simply #define'd to `inline' ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

