Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSC3DdE>; Fri, 29 Mar 2002 22:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSC3Dcz>; Fri, 29 Mar 2002 22:32:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39439 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312379AbSC3Dch>;
	Fri, 29 Mar 2002 22:32:37 -0500
Message-ID: <3CA53175.FBBBB649@zip.com.au>
Date: Fri, 29 Mar 2002 19:31:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: Your message of "Fri, 29 Mar 2002 10:41:11 -0800."
	             3CA4B547.AB359F0E@zip.com.au> <1886.1017457546@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Fri, 29 Mar 2002 10:41:11 -0800,
> Andrew Morton <akpm@zip.com.au> wrote:
> >Christoph Hellwig wrote:
> >>
> >> On Fri, Mar 29, 2002 at 09:36:26AM -0800, Andrew Morton wrote:
> >> > Here's the diff.  Comments?
> >>
> >> I don't see who having to independand declaration in the same kernel
> >> image are supposed to work..
> >
> >It goes in lib/lib.a.  The linker will only pick up
> >the default version if the architecture doesn't
> >have its own dump_stack().
> >
> >bust_spinlocks() has worked that way for quite some time.
> 
> I have a problem with putting routines in lib.a and relying on the
> linker to pull them out by default.  It does not work for routines
> called from modules, modules do not include lib.a.  Remember the recent
> problems with crc32.o?
> 
> bust_spinlocks() is not an issue because it is only called from built
> in code.  show_stack() has been used as a debugging facility and it
> could be called from a module.

Yes, that's a good point.  We're safe as long as core kernel
always contains a call to dump_stack(). Which is the case,
but that's a bit subtle for general usage.
