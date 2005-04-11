Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVDKU0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVDKU0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVDKU0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:26:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63898 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261948AbVDKUXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:23:50 -0400
Date: Mon, 11 Apr 2005 22:23:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do not misuse Coverity please
Message-ID: <20050411202325.GE10401@elf.ucw.cz>
References: <OofSaT76.1112169183.7124470.khali@localhost> <200503301709.j2UH9WsA008556@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503301709.j2UH9WsA008556@laptop11.inf.utfsm.cl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> "Jean Delvare" <khali@linux-fr.org> said:
> > > > > No, there is a third case: the pointer can be NULL, but the compiler
> > > > > happened to move the dereference down to after the check.
> 
> > > > Wow. Great point. I completely missed that possibility. In fact I didn't
> > > > know that the compiler could possibly alter the order of the
> > > > instructions. For one thing, I thought it was simply not allowed to. For
> > > > another, I didn't know that it had been made so aware that it could
> > > > actually figure out how to do this kind of things. What a mess. Let's
> > > > just hope that the gcc folks know their business :)
> 
> > > The compiler is most definitely /not/ allowed to change the results the
> > > code gives.
> 
> > I think that Andrew's point was that the compiler could change the order
> > of the instructions *when this doesn't change the result*, not just in
> > the general case, of course. In our example, The instructions:
> > 
> >     v = p->field;
> >     if (!p) return;
> > 
> > can be seen as equivalent to
> > 
> >     if (!p) return;
> >     v = p->field;
> 
> They are not. If p == NULL, the first gives an exception (SIGSEGV), the
> second one doesn't. Just as you can't "optimize" by switching:
> 
>     x = b / a;   
>     if (a == 0) return;

Dereferencing NULL pointer is undefined. It *may* give SIGSEGV. That's
what enables optimization above. You can't rely on dereferencing NULL
to always give SIGSEGV. Sorry.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
