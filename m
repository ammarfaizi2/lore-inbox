Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263472AbUJ3BiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUJ3BiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUJ2TiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:38:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:29635 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261477AbUJ2SzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:55:07 -0400
Date: Fri, 29 Oct 2004 11:54:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Richard Henderson <rth@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410291150360.28839@ppc970.osdl.org>
References: <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com>
 <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com>
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com> <20041029175527.GB25764@redhat.com>
 <Pine.LNX.4.61.0410291416040.4844@chaos.analogic.com>
 <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Linus Torvalds wrote:
> 
> Anyway, making "asmlinkage" imply "regparm(3)" would make the whole 
> discussion moot, so I'm wondering if anybody has the patches to try it 
> out? It requires pretty big changes to all the x86 asm code, but I do know 
> that people _had_ patches like that at least long ago (from when people 
> like Jan were playing with -mregaparm=3 originally). Maybe some of them 
> still exist..

Looking at just doing this for the semaphore code, I hit on the fact that
we already do this for the rwsem's.. So changing just the regular
semaphore code to use "fastcall" should fix this particular bug, but I'm
still interested in hearing whether somebody has a patch for the system
calls and faults too?

		Linus
