Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUBFTRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBFTOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:14:52 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:18306 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265775AbUBFTLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:11:43 -0500
Date: Fri, 6 Feb 2004 20:11:08 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Valdis.Kletnieks@vt.edu, Roland Dreier <roland@topspin.com>,
       "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040206191107.GA6340@vana.vc.cvut.cz>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com> <Pine.LNX.4.53.0402061258110.4045@chaos> <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu> <Pine.LNX.4.53.0402061336120.4238@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402061336120.4238@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 01:50:42PM -0500, Richard B. Johnson wrote:
> On Fri, 6 Feb 2004 Valdis.Kletnieks@vt.edu wrote:
> 
> > On Fri, 06 Feb 2004 13:00:38 EST, "Richard B. Johnson" said:
> >
> > > Yes you can. You just don't use an ';' if you are going
> > > to use 'else'.
> >
> > You did realize we've changed things from macros to inline functions
> > (and vice versa) on occasion?
> >
> > Yes, you *can* hack around the "problem".  Is there any actual
> > evidence that any real performance issues arise from the null
> > do/while?  Does said issue outweigh the increased fragility of
> > the code?
> >
> 
> Well the 'problem' is a demonstration. The last time I answered
> a query about the "do {} while(0)", stuff (as an advocate), there
> were tons of 'experts' that jumped on me for helping to propagate
> this "atrocious" (as I recall) abuse of the 'C' language. I
> was severely tongue-lashed into believing that there was no
> actual reason for doing it that way.

> running off to the head. I have spent a bunch of time looking
> at C/C++ headers for Sun and W$ and the only place I've
> ever seen the "do {} while(0)" stuff is in Linux. I think
> it started with Linux (was a Linux Invention!), as some
> kind of work-around, then it became a "Linux Signature".

Yes, because Linux programmers are only one who care about quality. 
Microsoft happilly offers (W2k DDK,inc/ddk/ntddk.h)

/* PLIST_ENTRY RemoveHeadList(PLIST_ENTRY ListHead) */

#define RemoveHeadList(ListHead) \
	(ListHead)->Flink;\
	{RemoveEntryList((ListHead)->Flink)}

and they do not care that you cannot use it in an expression, or
after if () statement, or anywhere else, except directly in an
assignment which is not in if/while body. So you must know that
RemoveHeadList() is macro, even that it is macro built from two
statements, and that you cannot use it as a function at all, as
it has a value only from left side - from right side it is
void :-( And of course it evaluates ListHead two times.

Please do not add such traps into Linux kernel code.
					Petr Vandrovec
					vandrove@vc.cvut.cz

