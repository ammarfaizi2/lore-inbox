Return-Path: <linux-kernel-owner+w=401wt.eu-S932507AbWLLWjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWLLWjQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWLLWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:39:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:48661 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932507AbWLLWjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:39:15 -0500
Subject: Re: Mach-O binary format support and Darwin syscall personality
	[Was: uts banner changes]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <0B8F288E-4FCD-409E-9BA2-C524CF31E9A3@mac.com>
References: <457D750C.9060807@shadowen.org>
	 <20061211163333.GA17947@aepfle.de>
	 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
	 <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de>
	 <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
	 <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com>
	 <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
	 <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
	 <Pine.LNX.4.64.0612121008490.3535@woody.osdl.org>
	 <0B8F288E-4FCD-409E-9BA2-C524CF31E9A3@mac.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 09:38:59 +1100
Message-Id: <1165963139.11914.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 17:34 -0500, Kyle Moffett wrote:
> On Dec 12, 2006, at 13:20:19, Linus Torvalds wrote:
> > That said, powerpc simply doesn't historically do any system call  
> > translation, so you'll just have to implement the same kind of  
> > translation layer that sparc has done, for example.
> 
> Thanks a lot for all your help.  I've got two last questions:  From  
> the code in entry_32.s I can dig up "current" from ((struct  
> paca_struct *)r13)->__current to read a personality flag from it,  
> right?  Digging up offsets in assembly can't be very fun :-\   

That's what asm-offset.c is for :-) It generates all the offsets you
need. In general though, you probably want to copy your personality flag
to thread_info, along with other bits in there (like 32 vs. 64 bits).
Look how it's done on ppc64.

> Secondly, is there a preferred existing field into which I should  
> stick said flag or just stuff it somewhere?

Yes, thread_info->flags.

> Ok, I figured it was going to be ugly; maybe not quite _that_ ugly  
> but my hopes weren't high enough for you to dash to any real degree :-D.

Well... it can't be pretty :-)

Ben.


