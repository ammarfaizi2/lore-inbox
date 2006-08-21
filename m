Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWHUL1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWHUL1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWHUL1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:27:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63150 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964961AbWHUL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:27:41 -0400
Subject: Re: [take12 3/3] kevent: Timer notifications.
From: Arjan van de Ven <arjan@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>, tglx@linutronix.de
In-Reply-To: <20060821111848.GB8608@2ka.mipt.ru>
References: <11561555893621@2ka.mipt.ru> <1156155589287@2ka.mipt.ru>
	 <20060821111239.GA30945@infradead.org>  <20060821111848.GB8608@2ka.mipt.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 21 Aug 2006 13:27:22 +0200
Message-Id: <1156159642.23756.144.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 15:18 +0400, Evgeniy Polyakov wrote:
> ]> > +	lockdep_set_class(&t->ktimer_storage.lock, &kevent_timer_key);
> > 
> > When looking at the kevent_storage_init callers most need to do
> > those lockdep_set_class class.  Shouldn't kevent_storage_init just
> > get a "struct lock_class_key *" argument?
> 
> It will not work, since inode is used for both socket and inode
> notifications (to save some space in struct sock), lockdep initalization
> is performed on the highest level, so I put it alone.

Call me a cynic, but I'm always a bit sceptical about needing lockdep
annotations like this... Can you explain why you need it in this case,
including the proof that it's safe?


