Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVLNX5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVLNX5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVLNX5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:57:45 -0500
Received: from rtr.ca ([64.26.128.89]:44475 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965100AbVLNX5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:57:44 -0500
Message-ID: <43A0B172.7020800@rtr.ca>
Date: Wed, 14 Dec 2005 18:57:38 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Jackson <pj@sgi.com>, mingo@elte.hu, hch@infradead.org,
       akpm@osdl.org, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134559121.25663.14.camel@localhost.localdomain>	 <13820.1134558138@warthog.cambridge.redhat.com>	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>	 <dhowells1134431145@warthog.cambridge.redhat.com>	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>	 <20051213100015.GA32194@elte.hu>	 <6281.1134498864@warthog.cambridge.redhat.com>	 <14242.1134558772@warthog.cambridge.redhat.com>	 <16315.1134563707@warthog.cambridge.redhat.com>	 <1134568731.4275.4.camel@tglx.tec.linutronix.de>  <43A0AD54.6050109@rtr.ca> <1134604667.2542.86.camel@tglx.tec.linutronix.de>
In-Reply-To: <1134604667.2542.86.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Wed, 2005-12-14 at 18:40 -0500, Mark Lord wrote:
...
>>Leaving up()/down() as-is is really the most sensible option.
> 
...
>Doing a s/down/lock_mutex/ s/up/unlock_mutex/ - or whatever naming
> convention we want to use - all over the place for mutexes while keeping
> the up/down for counting semaphores is an one time issue.
> 
> After the conversion every code breaks at compile time which tries to do
> up/down(mutex_type).
> 
> So the out of tree drivers have a clear indication what to fix. This is
> also a one time issue.
> 
> So where is the problem - except for fixing "huge" amounts of out of
> kernel code once ?

Pointless API breakage.  The same functions continue to exist,
the old names CANNOT be reused for some (longish) time,
so there's no point in renaming them.  It just breaks an API
for no good reason whatsoever.

Cheers
