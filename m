Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269693AbUINUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269693AbUINUDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269751AbUINUCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:02:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38553 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269708AbUINT7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:59:34 -0400
Date: Tue, 14 Sep 2004 15:19:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.28-pre3] I2C driver core gcc-3.4 fixes
Message-ID: <20040914181916.GA30422@logos.cnet>
References: <200409121510.i8CFA5Ji015615@harpo.it.uu.se> <20040912174312.5ea8d2ef.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912174312.5ea8d2ef.khali@linux-fr.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 05:43:12PM +0200, Jean Delvare wrote:
> > Yes, it results in code doing void* pointer arithmetic, but
> > the kernel uses that particular gcc extension in a lot of
> > places. It's ugly but known to work exactly like char*.
> 
> OK, I didn't know that. Thanks for the info.
> 
> > However, I'm no fan of void* arithmetic. Would code like
> > buffer = (void*)((char*)buffer + buflen); make you happier?
> 
> Well, it makes things even uglier IMHO, so let's not do it.
> 
> > >After a quick look at the code I'd say that the buffer-like
> > >parameters involved should be declared as char* instead of void* in
> > >the first place, which would effectively make all further casts
> > >unnecessary, and still work exactly as before.
> > 
> > Maybe, but that's potentially a much larger change. I'm just
> > looking for the minimal changes to make the 2.4 kernel safe for
> > gcc-3.4 and later (cast-as-lvalue is an error in gcc-3.5/4.0).
> 
> I'm not much in favor of "fixing" old code just to make it gcc-3.5
> compliant, especially when at the same time we won't clean it up,
> potentially resulting in less readable code. I would be perfectly happy
> with being able to compile 2.4 kernels with gcc versions up to 3.3 and
> not above. What's the exact benefit of changing old and stable code in
> the end of its life cycle for it to support future compilers? I don't
> get it (but at the same time I am not the one deciding here).

I'm applying these gcc 3.4 changes because they look straightforward to me
and I quite a lot of people were complaining about this.

I dont pretend to accept any further (gcc 3.5 and beyond) changes.

> This was a general comment. For the specific changes you propose, if
> void* works like char* when it comes to arithmetics, it looks safe and
> as such is (technically) fine with me.

Mikael?


