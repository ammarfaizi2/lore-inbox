Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWIOFds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIOFds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 01:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWIOFds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 01:33:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750719AbWIOFdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 01:33:47 -0400
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <d120d5000609141211o76432bd3l82582ef3896e3be@mail.gmail.com>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
	 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
	 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
	 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
	 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
	 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
	 <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
	 <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
	 <1158260584.4200.3.camel@laptopd505.fenrus.org>
	 <d120d5000609141211o76432bd3l82582ef3896e3be@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 15 Sep 2006 07:33:24 +0200
Message-Id: <1158298404.4332.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 15:11 -0400, Dmitry Torokhov wrote:
> On 9/14/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > >
> > > I think it is - as far as I understand the reason for not tracking
> > > every lock individually is just that it is too expensive to do by
> > > default.
> >
> > that is not correct. While it certainly plays a role,
> > the other reason is that you can find out "class" level locking rules
> > (such as inode->i_mutex comes before <other lock>) for all inodes at a
> > time; eg no need to see every inode do this before you can find the
> > deadlock.
> >
> 
> OK, I can see that. However you must agree that for certain locks we
> do want to track them individually, right?

I agree that if locks really represent different objects with different
locking semantics they should not share the class. Lockdep provides a
mechanism for that; however I'm very afraid that for the input layer,
they really are not that, they are not different objects with different
semantics; they are the same objects with nesting semantics! In that
case the "separate lock class" stuff has only disadvantages.
The worst thing is that as I understand it this separate class is
*dynamic*. Eg it's not even "one class per driver" ;(


