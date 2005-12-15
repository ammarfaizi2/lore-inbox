Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVLOCqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVLOCqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLOCqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:46:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030349AbVLOCqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:46:54 -0500
Date: Wed, 14 Dec 2005 18:46:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Mark Lord <lkml@rtr.ca>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jackson <pj@sgi.com>,
       mingo@elte.hu, hch@infradead.org, akpm@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <1134605406.2542.91.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0512141840370.3292@g5.osdl.org>
References: <1134559121.25663.14.camel@localhost.localdomain> 
 <13820.1134558138@warthog.cambridge.redhat.com>  <20051213143147.d2a57fb3.pj@sgi.com>
 <20051213094053.33284360.pj@sgi.com>  <dhowells1134431145@warthog.cambridge.redhat.com>
  <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> 
 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> 
 <20051213100015.GA32194@elte.hu>  <6281.1134498864@warthog.cambridge.redhat.com>
  <14242.1134558772@warthog.cambridge.redhat.com>  <16315.1134563707@warthog.cambridge.redhat.com>
  <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
  <1134604667.2542.86.camel@tglx.tec.linutronix.de> <43A0B172.7020800@rtr.ca>
 <1134605406.2542.91.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Dec 2005, Thomas Gleixner wrote:
> 
> Well, depends on the POV. A counting sempahore is a different beast than
> a mutex. At least as far as my limited knowledge of concurrency controls
> goes.

A real semaphore is counting. 

Dammit, unless the pure mutex has a _huge_ performance advantage on major 
architectures, we're not changing it. There's absolutely zero point. A 
counting semaphore is a perfectly fine mutex - the fact that it can _also_ 
be used to allow more than 1 user into a critical region and generally do 
other things is totally immaterial.

It's _extra_ stupid to re-use the names "down()" and "up()" on a 
non-counting mutex, since then the names make zero sense at all. Use 
"lock_mutex()" and "unlock_mutex()" or something, and don't break existing 
code for no measurable gain.

			Linus
