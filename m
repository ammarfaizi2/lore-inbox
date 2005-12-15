Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVLOU6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVLOU6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVLOU6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:58:52 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:63117 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751081AbVLOU6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:58:51 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, matthew@wil.cx,
       arjan@infradead.org, hch@infradead.org, mingo@elte.hu,
       tglx@linutronix.de, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Paul Jackson <pj@sgi.com>, David Howells <dhowells@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <17313.46085.921398.819760@gargle.gargle.HOWL>
References: <20051215085602.c98f22ef.pj@sgi.com>
	 <17313.37200.728099.873988@gargle.gargle.HOWL>
	 <1134559121.25663.14.camel@localhost.localdomain>
	 <13820.1134558138@warthog.cambridge.redhat.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
	 <20051214155432.320f2950.akpm@osdl.org>
	 <17313.29296.170999.539035@gargle.gargle.HOWL>
	 <1134658579.12421.59.camel@localhost.localdomain>
	 <4743.1134662116@warthog.cambridge.redhat.com>
	 <7140.1134667736@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
	 <17313.46085.921398.819760@gargle.gargle.HOWL>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 15:58:27 -0500
Message-Id: <1134680307.13138.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 21:20 +0300, Nikita Danilov wrote:

> Going off at a tangent (or tangle, rather), why do we need DECLARE_FOO()
> macros at all? They
> 
>  - do not look like C variable declarations, hide variable type, and
>  hence are confusing,
> 
>  - contrary to their naming actually _define_ rather than _declare_ an
>  object.
> 
> In most cases 
> 
>         type var = INIT_FOO;
> 
> is much better (more readable and easier to understand) than
> 
>         DECLARE_FOO(var); /* what is the type of var? */
> 
> In the cases where initializer needs an address of object being
> initialized
> 
>         type var = INIT_FOO(var);
> 
> can be used.

That's just error prone.  In the RT patch we had several bugs caused by
cut and paste errors like:

type foo = INIT_TYPE(foo);
type bar = INIT_TYPE(foo);

These are not always easy to find.

-- Steve


