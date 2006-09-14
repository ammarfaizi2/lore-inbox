Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWINPEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWINPEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWINPEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:04:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25233 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750733AbWINPED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:04:03 -0400
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <200609132200.51342.dtor@insightbb.com>
	 <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
	 <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
	 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 14 Sep 2006 17:03:57 +0200
Message-Id: <1158246237.2931.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 10:58 -0400, Dmitry Torokhov wrote:
> On 9/14/06, Jiri Kosina <jikos@jikos.cz> wrote:
> > On Thu, 14 Sep 2006, Dmitry Torokhov wrote:
> >
> > > Can we add lock_class_key to the struct psmouse and use it to define
> > > per-device mutex class regardless of whether it is a child, grandchild
> > > or a parent?
> >
> > Hi Dmitry,
> >
> > what do you think about the patches below? I have used a slightly
> > different approach, as we also need to get rid of the spurious lockdep
> > warning in case of recursive call of serio_interrupt(), which can't be
> > handled well with lock subclass stored in struct psmouse. What do you
> > think about this? It shuts up the lockdep, and seems much cleaner to me.
> >
> 
> Yes, this is much, much better. Could you please tell me if depth
> should be a true depth or just an unique number? The reason I am
> asking is that I hope to get rid of parent/child pointers in serio
> (they were introduced when driver core could not handle recursive
> addition/removing of devices on the same bus).

lockdep sort of expects the depth to be a number between 0 and 7.
Other than that lockdep does not assume an ordering based on numerical
value at all; it figures that out at runtime. 


