Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVLOSUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVLOSUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVLOSUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:20:41 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:61364 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750880AbVLOSUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:20:40 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17313.46085.921398.819760@gargle.gargle.HOWL>
Date: Thu, 15 Dec 2005 21:20:53 +0300
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Paul Jackson <pj@sgi.com>,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, tglx@linutronix.de,
       mingo@elte.hu, hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
In-Reply-To: <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
References: <20051215085602.c98f22ef.pj@sgi.com>
	<17313.37200.728099.873988@gargle.gargle.HOWL>
	<1134559121.25663.14.camel@localhost.localdomain>
	<13820.1134558138@warthog.cambridge.redhat.com>
	<20051213143147.d2a57fb3.pj@sgi.com>
	<20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
	<14242.1134558772@warthog.cambridge.redhat.com>
	<16315.1134563707@warthog.cambridge.redhat.com>
	<1134568731.4275.4.camel@tglx.tec.linutronix.de>
	<43A0AD54.6050109@rtr.ca>
	<20051214155432.320f2950.akpm@osdl.org>
	<17313.29296.170999.539035@gargle.gargle.HOWL>
	<1134658579.12421.59.camel@localhost.localdomain>
	<4743.1134662116@warthog.cambridge.redhat.com>
	<7140.1134667736@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > 
 > On Thu, 15 Dec 2005, David Howells wrote:
 > > 
 > > 	FROM				TO
 > > 	==============================	=========================
 > > 	DECLARE_MUTEX			DECLARE_SEM_MUTEX
 > > 	DECLARE_MUTEX_LOCKED		DECLARE_SEM_MUTEX_LOCKED
 > > 	Proper counting semaphore	DECLARE_SEM
 > 
 > That sounds fine. I wouldn't be adverse to doing that - but it would have 
 > to be independently of any other changes, and it would need to simmer for 
 > a while for out-of-tree drivers etc to notice (ie you should _not_ just 
 > introduce a new "DECLARE_MUTEX()" immediately to confuse things).

Going off at a tangent (or tangle, rather), why do we need DECLARE_FOO()
macros at all? They

 - do not look like C variable declarations, hide variable type, and
 hence are confusing,

 - contrary to their naming actually _define_ rather than _declare_ an
 object.

In most cases 

        type var = INIT_FOO;

is much better (more readable and easier to understand) than

        DECLARE_FOO(var); /* what is the type of var? */

In the cases where initializer needs an address of object being
initialized

        type var = INIT_FOO(var);

can be used.

Nikita.
