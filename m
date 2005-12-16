Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVLPQdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVLPQdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVLPQdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:33:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbVLPQdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:33:35 -0500
Date: Fri, 16 Dec 2005 08:33:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
In-Reply-To: <12186.1134732601@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org>
References: <11202.1134730942@warthog.cambridge.redhat.com> 
 <43A21E55.3060907@yahoo.com.au> <1134560671.2894.30.camel@laptopd505.fenrus.org>
 <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain>
 <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com>
 <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain>
 <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain>
 <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain>
 <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com>
  <12186.1134732601@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, David Howells wrote:
> 
> Of course, CMPXCHG doesn't have to store either, though it still performs a
> locked-write-cycle on x86 if I remember correctly.

It does so on any sane architecture (side note: you don't do locked 
memory cycles on the bus these days. You do cache coherency protocols).

>From a bus standpoint you _have_ to do the initial read with intent to 
write, nothing else makes any sense. You'll just waste bus cycles 
otherwise. Sure, the write may never come, but it just isn't sensible to 
optimize for the case where the compare will fail. If that's the common 
case, then software is doing something wrong (it should do just a much 
cheaper "load + compare" first if it knows it's probably going to fail).

		Linus
