Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWAKIFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWAKIFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWAKIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:05:50 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:8626 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751048AbWAKIFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:05:49 -0500
Message-ID: <43C4CE39.3326BFBB@tv-sign.ru>
Date: Wed, 11 Jan 2006 12:22:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: balbir@in.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <Pine.LNX.4.64.0512191148460.4827@g5.osdl.org> <43A985E6.CA9C600D@tv-sign.ru> <20060110102851.GB18325@in.ibm.com> <43C3F6DB.FEFDA101@tv-sign.ru> <20060111063322.GA9261@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> 
> On Tue, Jan 10, 2006 at 09:03:07PM +0300, Oleg Nesterov wrote:
> 
> > I don't have an answer, only a wild guess.
> >
> > Note that if P1 releases this semaphore before pre-woken P2 actually
> > gets cpu what happens is:
> >
> >       P1->up() just increments ->count, no wake_up() (fastpath)
> >
> >       P2 takes the semaphore without schedule.
> >
> > So *may be* it was designed this way as some form of optimization,
> > in this scenario P2 has some chances to run with sem held earlier.
> >
> 
> P1->up() will do a wake_up() only if count < 0. For no wake_up()
> the count >=0 before the increment. This means that there is no one
> sleeping on the semaphore.

And this exactly happens. P1 returns from __down() with ->count == 0
and P2 pre-woken.

Oleg.
