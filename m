Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHaXyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHaXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbUHaXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:47:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:37767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269291AbUHaXgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:36:04 -0400
Date: Tue, 31 Aug 2004 16:39:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@linuxmail.org
Cc: bunk@fs.tum.de, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
Message-Id: <20040831163914.4c7c543c.akpm@osdl.org>
In-Reply-To: <1093993946.8943.33.camel@laptop.cunninghams>
References: <20040831221348.GW3466@fs.tum.de>
	<20040831153649.7f8a1197.akpm@osdl.org>
	<20040831225244.GY3466@fs.tum.de>
	<1093993946.8943.33.camel@laptop.cunninghams>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> Hi.
> 
> On Wed, 2004-09-01 at 08:52, Adrian Bunk wrote:
> > On Tue, Aug 31, 2004 at 03:36:49PM -0700, Andrew Morton wrote:
> > > Adrian Bunk <bunk@fs.tum.de> wrote:
> > > >
> > > > An issue that we already discussed at 2.6.8-rc2-mm2 times:
> > > > 
> > > > 2.6.9-rc1 includes __always_inline which was formerly in  -mm.
> > > > __always_inline doesn't make any sense:
> > > > 
> > > > __always_inline is _exactly_ the same as __inline__, __inline and inline .
> > > > 
> > > > 
> > > > The patch below removes __always_inline again:
> > > 
> > > But what happens if we later change `inline' so that it doesn't do
> > > the `always inline' thing?
> > > 
> > > An explicit usage of __always_inline is semantically different than
> > > boring old `inline'.
> 
> Excuse me if I'm being ignorant, but I thought always_inline was
> introduced because with some recent versions of gcc, inline wasn't doing
> the job (suspend2, which requires a working inline, was broken by it for
> example).

IIRC, the compiler was generating out-of-line versions of functions in
every compilation unit whcih included the header file.  When we the
developers just wanted `inline' to mean `inline, dammit'.

If that broke swsusp in some manner then the relevant swsusp functions
should be marked always_inline, because they have some special needs.

> That is to say, doesn't the definition of always_inline vary
> with the compiler version?

If the compiler supports attribute((always_inline)) then the kernel build
system will use that.  If the compiler doesn't support
attribute((always_inline)) then we just emit `inline' from cpp and hope
that it works out.
