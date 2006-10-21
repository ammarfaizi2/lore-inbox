Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993024AbWJUOxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993024AbWJUOxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 10:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993074AbWJUOxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 10:53:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10418 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S2993024AbWJUOxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 10:53:33 -0400
Subject: Re: various laptop nagles - any suggestions?   (note:
	2.6.19-rc2-mm1 but applies to multiple kernels)
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061020112627.04a4035a.akpm@osdl.org>
References: <4537A25D.6070205@wintersgift.com>
	 <20061019194157.1ed094b9.akpm@osdl.org> <4538F9AD.8000806@wintersgift.com>
	 <20061020110746.0db17489.akpm@osdl.org>
	 <1161368034.5274.278.camel@localhost.localdomain>
	 <20061020112627.04a4035a.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 21 Oct 2006 16:52:59 +0200
Message-Id: <1161442379.3128.82.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 11:26 -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2006 20:13:54 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > Also, NO_HZ breaks my laptop (and presumably quite a few others) quite
> > > horridly, which means nobody can ship the feature.  Some runtime
> > > turn-it-off work needs to be done there.
> > 
> > We can make a commandline switch as for highres. Is that sufficient ?
> 
> I doubt it.
> 
> I don't know how many machines will be affected by this, but I'd expect
> it's quite a few - the Vaio has a less-than-one-year-old Intel CPU in it.
> 
> I'd expect that if a distro were to enable NO_HZ, they'd have a large
> number of unhappy users whose machines run like crap, some of whom would
> find out that they need to add some funny dont-run-like-crap option and
> some of whom would, after wasting considerable amounts of time, just give
> up and use windows or RH5.2 or something.


well NO_HZ as is is incompatible with any machine which has support for
the C3 state (at least if they have an Intel CPU) since the local apic
timer just plain stops in C3 unfortunately.

We really need to think about using HPET for this, and potentially on a
single socket system, not do per core timer queues but just 1 global
timer queue. 


