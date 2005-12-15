Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVLOQXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVLOQXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVLOQXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:23:48 -0500
Received: from spirit.analogic.com ([204.178.40.4]:17675 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750793AbVLOQXs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:23:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4743.1134662116@warthog.cambridge.redhat.com>
X-OriginalArrivalTime: 15 Dec 2005 16:23:36.0259 (UTC) FILETIME=[E651F930:01C60193]
Content-class: urn:content-classes:message
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Thu, 15 Dec 2005 11:22:48 -0500
Message-ID: <Pine.LNX.4.61.0512151112520.17970@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Thread-Index: AcYBk+ZeQXPZJwcWQDGts10QLLiOWg==
References: <17313.37200.728099.873988@gargle.gargle.HOWL>  <1134559121.25663.14.camel@localhost.localdomain> <13820.1134558138@warthog.cambridge.redhat.com> <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com> <14242.1134558772@warthog.cambridge.redhat.com> <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca> <20051214155432.320f2950.akpm@osdl.org> <17313.29296.170999.539035@gargle.gargle.HOWL> <1134658579.12421.59.camel@localhost.localdomain>  <4743.1134662116@warthog.cambridge.redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Howells" <dhowells@redhat.com>
Cc: "Nikita Danilov" <nikita@clusterfs.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andrew Morton" <akpm@osdl.org>,
       <tglx@linutronix.de>, <pj@sgi.com>, <mingo@elte.hu>,
       <hch@infradead.org>, <torvalds@osdl.org>, <arjan@infradead.org>,
       <matthew@wil.cx>, <linux-kernel@vger.kernel.org>,
       <linux-arch@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Dec 2005, David Howells wrote:

> Nikita Danilov <nikita@clusterfs.com> wrote:
>
>> And to convert almost all calls to down/up to mutex_{down,up}. At which
>> point, it no longer makes sense to share the same data-type for
>> semaphore and mutex.
>
> But what to do about DECLARE_MUTEX? :-/
>
> David

Isn't "struct semaphore" already an opaque type. Nobody, except
the optimizer wizards, should even care what's in them. They are
already manipulated with init_MUTEX, up, down, etc. There shouldn't
be any code changes if the actual internal workings are changed.

If some code is peeking into the internal workings, then it's
broken. Don't break the whole kernel by a name-change. Sharing
the same data-type, as long as there are no alignment problems,
has no negative impact at all. If there is stuff inside those
structures that is not used for a particular instance, who cares?
Somebody doing debugging? If they are doing kernel debugging,
they should know what they are doing, you don't dumb-down the
kernel to the lowest common denominator because there may be
different structure members used for different purposes!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
