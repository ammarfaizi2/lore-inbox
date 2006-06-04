Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932257AbWFDV3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFDV3P (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWFDV3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:29:15 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:130 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932257AbWFDV3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:29:14 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1149456375.23209.13.camel@localhost.localdomain>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
	 <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
	 <1149438131.29652.5.camel@localhost.localdomain>
	 <1149456375.23209.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 17:28:52 -0400
Message-Id: <1149456532.29652.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 22:26 +0100, Alan Cox wrote:
> Ar Sul, 2006-06-04 am 12:22 -0400, ysgrifennodd Steven Rostedt:
> > But can't this machine still cause an interrupt storm if the interrupt
> > comes on a wrong line, and we don't call the handler for the interrupt
> > source because we are now honoring disable_irq?
> 
> Yes - that is why we can't honour disable_irq in this case but have to
> hope 8)
> 

Hmm, maybe this can be solved with something like what the -rt patch
does with threading interrupts and the interrupt mask.  I'm not
suggesting threading interrupts.  But, if the misrouted irq comes across
a disabled_irq, that it sets some flag, and doesn't unmask the interrupt
when finished.  Have enable_irq see the flag and have it unmask the
interrupt if it is safe to do so.

This all may be pretty hacky, but it's trying to fix code for hardware
that is already hacky.  Note, that this would need to be compiled in as
on option to actually implement any of this crap.

-- Steve


