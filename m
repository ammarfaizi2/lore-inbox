Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSHITRs>; Fri, 9 Aug 2002 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHITRs>; Fri, 9 Aug 2002 15:17:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14792 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315708AbSHITRs>;
	Fri, 9 Aug 2002 15:17:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Daniel Phillips <phillips@arcor.de>, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 15:17:55 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com> <200208091432.38561.frankeh@watson.ibm.com> <E17dEje-0001Ro-00@starship>
In-Reply-To: <E17dEje-0001Ro-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208091517.55019.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 02:43 pm, Daniel Phillips wrote:
> On Friday 09 August 2002 20:32, Hubertus Franke wrote:
> > On Friday 09 August 2002 11:20 am, Daniel Phillips wrote:
> > > On Sunday 04 August 2002 19:19, Hubertus Franke wrote:
> > > > "General Purpose Operating System Support for Multiple Page Sizes"
> > > > htpp://www.usenix.org/publications/library/proceedings/usenix98/full_
> > > >pape rs/ganapathy/ganapathy.pdf
> > >
> > > This reference describes roughly what I had in mind for active
> > > defragmentation, which depends on reverse mapping.  The main additional
> > > wrinkle I'd contemplated is introducing a new ZONE_LARGE, and
> > > GPF_LARGE, which means the caller promises not to pin the allocation
> > > unit for long periods and does not mind if the underlying physical page
> > > changes spontaneously.  Defragmenting in this zone is straightforward.
> >
> > I think the objection to that is that in many cases the cost of
> > defragmentation is to heavy to be recollectable through TLB miss handling
> > alone.
>
> You pay the cost only on transition from a load that doesn't use many large
> pages to one that does, it is not an ongoing cost.
>

Correct. Maybe I misunderstood, when are you doing the coalloction of 
adjacent pages (page-clusters, super pages).
Our intend was to do it at page fault time and breakup only during 
memory pressure. 

> > [...]
> >
> > Defragmenting to me seems a matter of last resort, Copying pages is
> > expensive.
>
> It is the only way to ever have a seamless implementation.  Really, I don't
> understand this fear of active defragmentation.  Oh well, like davem said,
> code talks.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
