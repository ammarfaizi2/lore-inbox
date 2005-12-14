Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbVLNXkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVLNXkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVLNXkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:40:12 -0500
Received: from rtr.ca ([64.26.128.89]:60881 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965056AbVLNXkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:40:10 -0500
Message-ID: <43A0AD54.6050109@rtr.ca>
Date: Wed, 14 Dec 2005 18:40:04 -0500
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
References: <1134559121.25663.14.camel@localhost.localdomain>	 <13820.1134558138@warthog.cambridge.redhat.com>	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>	 <dhowells1134431145@warthog.cambridge.redhat.com>	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>	 <20051213100015.GA32194@elte.hu>	 <6281.1134498864@warthog.cambridge.redhat.com>	 <14242.1134558772@warthog.cambridge.redhat.com>	 <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de>
In-Reply-To: <1134568731.4275.4.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
>
> You can do a full scripted rename of up/down to the mutex API and then
> fix up the 100 places used by semaphores manually.

Again, folks, this only works for current in-tree kernel code.

There are huge amounts of kernel code out-of-tree that still use
up/down as (or potentially as) counting semaphores.

Yes, some of that code is closed-source, but most of it is open-source
stuff in people's "queues", such as the network patch-o-matic queue
and other stuff.  Lots of open-source out-of-tree drivers, too.

Re-using the existing up()/down() names for a new purpose is
a very very Bad Idea.  Removing up()/down() entirely is not quite so bad,
because at least then people will eventually notice the change.

Leaving up()/down() as-is is really the most sensible option.

Cheers
