Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFHXDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFHXDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFHXDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:03:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:2471 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261351AbVFHXC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:02:57 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Adam Belay <abelay@novell.com>, greg@kroah.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
In-Reply-To: <20050608122320.GC1898@elf.ucw.cz>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>
	 <20050607105552.GA27496@pingi3.kke.suse.de>
	 <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston>
	 <1118196980.3245.68.camel@localhost.localdomain>
	 <20050608122320.GC1898@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 09:00:04 +1000
Message-Id: <1118271605.6850.137.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I think we should also use the pm_message_t defines.  We will need to
> > add PMSG_FREEZE eventually.  I decided to default to the current state
> > rather than panic.  Does this patch look ok?
> 
> No.

Hrm... I don't follow you anymore here ...

>         case PM_EVENT_ON:
>                 return PCI_D0;
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_SUSPEND:
>                 return PCI_D3hot;

What are these new PM_EVENT_* things ? I though we defined PMSG_* ?

> You passed invalid argument; I see no reason why you should paper over
> it and risk continuing. This happens during system suspend; it is
> quite possible that user will not see your printk when machine powers
> off just after that; and remember that it will not be in syslog after
> resume.

Crap. I don't think a BUG() makes any useful help neither in this place,
and when I locally turn PMSG_FREEZE to something sane I suddenly blow up
in there (and I wonder in how many other places).

Ben.


