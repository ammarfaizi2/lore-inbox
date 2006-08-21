Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWHVRC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWHVRC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWHVRC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:02:26 -0400
Received: from www.osadl.org ([213.239.205.134]:9112 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932187AbWHVRCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:02:25 -0400
Subject: Re: [take12 3/3] kevent: Timer notifications.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
In-Reply-To: <20060821111848.GB8608@2ka.mipt.ru>
References: <11561555893621@2ka.mipt.ru> <1156155589287@2ka.mipt.ru>
	 <20060821111239.GA30945@infradead.org>  <20060821111848.GB8608@2ka.mipt.ru>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 16:25:49 +0200
Message-Id: <1156170349.4725.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 15:18 +0400, Evgeniy Polyakov wrote:
> On Mon, Aug 21, 2006 at 12:12:39PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > On Mon, Aug 21, 2006 at 02:19:49PM +0400, Evgeniy Polyakov wrote:
> > > 
> > > 
> > > Timer notifications.
> > > 
> > > Timer notifications can be used for fine grained per-process time 
> > > management, since interval timers are very inconvenient to use, 
> > > and they are limited.
>
> > Shouldn't this at leat use a hrtimer?
> 
> Not everymachine has them 

Every machine has hrtimers - not necessarily with high resolution timer
support, but the core code is there in any case and it is designed to
provide fine grained timers. 

In case of high resolution time support one would expect that the "fine
grained" timer event is actually fine grained.

> and getting into account possibility that
> userspace can be scheduled away, it will be overkill.

If you think out your argument then everything which is fine grained or
high responsive should be removed from userspace access for the very
same reason. Please look at the existing users of the hrtimer subsystem
- all of them are exposed to userspace.

	tglx


