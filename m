Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUKBQDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUKBQDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUKBQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:03:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:21168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262472AbUKBQCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:02:32 -0500
Date: Tue, 2 Nov 2004 08:02:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411020935010.3495@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0411020759040.2187@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
 <Pine.LNX.4.58.0411011342090.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0411020935010.3495@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Nov 2004, linux-os wrote:
> 
> The patch you provided patched without any rejects. However,
> the system won't boot.

Yes, there was a incorrect change to the "asmlinkage" definition that I 
had played with before deciding to make just the semaphores be reg-arg, 
and that change made it into my original patch by mistake. I sent out a 
second message asking people to remove that part of the patch some time 
later, but..

> I patched Linux-2.6.9. Could you please review your patch?
> I will await the possibility of a simple typo that I can
> fix by hand before reverting.

Just change the incorrect "3" in <asm-i386/linkage.h> (or whatever, this 
is from memory):

	#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(3)))

back to a "0". Asmlinkage still uses stack-based parameter passing, which
I'd love to fix eventually (we've had bugs in that area too), but it is
just too much pain to do right now.

		Linus
