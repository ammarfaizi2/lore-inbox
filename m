Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVLOREZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVLOREZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVLOREZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:04:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48319
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750778AbVLOREY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:04:24 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Nikita Danilov <nikita@clusterfs.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       pj@sgi.com, Ingo Molnar <mingo@elte.hu>, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512150817170.3292@g5.osdl.org>
References: <17313.37200.728099.873988@gargle.gargle.HOWL>
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
	 <Pine.LNX.4.64.0512150817170.3292@g5.osdl.org>
Content-Type: text/plain
Organization: Linutronix
Date: Thu, 15 Dec 2005 18:04:54 +0100
Message-Id: <1134666294.3577.10.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 08:28 -0800, Linus Torvalds wrote:
> I would suggest that if you create a new "mutex" type, you just keep the 
> lower-case name. Don't re-use the DECLARE_MUTEX format, just do
> 
> 	struct mutex my_mutex = UNLOCKED_MUTEX;
> 
> for new code that uses the new stuff.
> 
> Think about it a bit. We don't have DECLARE_SPINLOCK either. Why?

Well, we have DEFINE_SPINLOCK() and we should have a matching one for
mutexes DEFINE_MUTEX().

The reason is that you can implement complex initialization for
debugging or extensions which can't be done by a var = INITIALZER,
because you dont have a reference to var.

	tglx


