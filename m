Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWB0Xpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWB0Xpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWB0Xpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:45:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:22931 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751304AbWB0Xpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:45:42 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, rth@redhat.com
Subject: Re: [patch] i386: make bitops safe
Date: Tue, 28 Feb 2006 00:47:22 +0100
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
References: <200602271700_MC3-1-B969-F4A5@compuserve.com> <Pine.LNX.4.64.0602271502410.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602271502410.22647@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280047.22909.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 00:06, Linus Torvalds wrote:
> On Mon, 27 Feb 2006, Chuck Ebbert wrote:
> > Make i386 bitops safe.  Currently they can be fooled, even on
> > uniprocessor, by code that uses regions of the bitmap before
> > invoking the bitop.  The least costly way to make them safe
> > is to add a memory clobber and tag all of them as volatile.
>
> Actually, the least costly way should be to make the "ADDR" define work
> right again.
>
> It used to do something magic like

I remember asking rth about this at some point and IIRC
he expressed doubts if it would actually do what expected. Richard?

-Andi

>
> 	struct fake_area {
> 		unsigned long members[1000];
> 	};
>
> 	#define ADDR (*(volatile struct fake_area *)addr)
>
> which was correct. I forget why it got broken into using just a "long *"
> (it happened a long long time ago).
>
> 		Linus
