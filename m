Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVLOO4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLOO4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVLOO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:56:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44494 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750754AbVLOO4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:56:49 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, dhowells@redhat.com,
       pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <17313.29296.170999.539035@gargle.gargle.HOWL>
References: <1134559121.25663.14.camel@localhost.localdomain>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Dec 2005 14:56:19 +0000
Message-Id: <1134658579.12421.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 16:41 +0300, Nikita Danilov wrote:
> But this change is about fixing bugs: mutex assumes that
> 
>  - only owner can unlock, and
> 
>  - owner cannot lock (immediate self-deadlock).

So add mutex_up/mutex_down that use the same semaphores but do extra
checks if lock debugging is enabled. All you need is an owner field for
debugging.

Now generate a trace dump on up when up and to check for sleeping on a
lock you already hold (for both sem and mutex).

Alan

