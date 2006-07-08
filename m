Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWGHJv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWGHJv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWGHJv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:51:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56289 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932305AbWGHJv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:51:57 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AF78CE.7060904@argo.co.il>
References: <1152348696.3120.9.camel@laptopd505.fenrus.org>
	 <44AF78CE.7060904@argo.co.il>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 11:51:48 +0200
Message-Id: <1152352309.3120.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 12:20 +0300, Avi Kivity wrote:
> Arjan van de Ven wrote:
> >
> > >
> > > It could be argued that gcc's implementation of volatile is wrong, and
> > > that gcc should add the appropriate serializing instructions before and
> > > after volatile accesses.
> > >
> > > Of course, that would make volatile even more suboptimal, but at least
> > > correct.
> >
> > with PCI, and the PCI posting rules, there is no "one" serializing
> > instruction, you need to know the specifics of the device in question to
> > cause the flush. So at least there is no universal possible
> > implementation of volatile as you suggest ;-)
> >
> 
> A serializing volatile makes it possible to write portable code to 
> access pci mmio.  You'd just follow a write with a read or whatever the 
> rules say.

yeah except that the compiler cannot know what to read; reading back the
same memory location is NOT correct nor safe. It's device specific, for
some devices it'll be safe, for others you have to read some OTHER
location.


