Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUBGDGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBGDGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:06:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:30416 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266554AbUBGDGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:06:01 -0500
Date: Sat, 7 Feb 2004 03:05:29 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>, Valdis.Kletnieks@vt.edu,
       Roland Dreier <roland@topspin.com>,
       "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040207030529.GK12503@mail.shareable.org>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com> <Pine.LNX.4.53.0402061258110.4045@chaos> <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu> <Pine.LNX.4.53.0402061336120.4238@chaos> <20040206191107.GA6340@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206191107.GA6340@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Yes, because Linux programmers are only one who care about quality. 
> Microsoft happilly offers (W2k DDK,inc/ddk/ntddk.h)
> 
> /* PLIST_ENTRY RemoveHeadList(PLIST_ENTRY ListHead) */
> 
> #define RemoveHeadList(ListHead) \
> 	(ListHead)->Flink;\
> 	{RemoveEntryList((ListHead)->Flink)}
> 
> and they do not care that you cannot use it in an expression, or
> after if () statement, or anywhere else, except directly in an
> assignment which is not in if/while body. So you must know that
> RemoveHeadList() is macro, even that it is macro built from two
> statements, and that you cannot use it as a function at all, as
> it has a value only from left side - from right side it is
> void :-( And of course it evaluates ListHead two times.


Oh, it is much worse than that.

You _can_ use it after an if() statement.  Your program compiles just
fine.  The only problem is it has a serious bug which is invisible and
may not be noticed for years.

I have seen code shipped with this exact bug, and watched someone
spend days debugging a program that contained it, until they brought
the problem to me.  Then we found it quickly - because I already
know why that macro kind is bad, thanks to the GNU CPP manual.

In short, any programmer managed by me who wrote a macro like that
would be educated why it is not acceptable.  If they still wrote code
like that afterwards, they wouldn't remain with me for long.

-- Jamie
