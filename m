Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSLIIN6>; Mon, 9 Dec 2002 03:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSLIIN6>; Mon, 9 Dec 2002 03:13:58 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:269
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261894AbSLIIN6>; Mon, 9 Dec 2002 03:13:58 -0500
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF44031.58A12F66@mvista.com>
References: <3DF2F8D9.6CA4DC85@mvista.com>
	 <1039341009.1483.3.camel@laptop.fenrus.com>  <3DF44031.58A12F66@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039422115.15169.7.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Dec 2002 03:21:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 02:03, george anzinger wrote:

> > > +     IF_SMP(if (old_base && (new_base != old_base))
> > > +            spin_unlock(&old_base->lock);
> > > +             )
> > 
> > Like here..... SMP dependent ifdef's of spinlock usage... shudder
> > 
> Well it does seem like a waste to do spinlock ordering code
> on a UP system...

Well the spin locks will compile away if !CONFIG_SMP, and then the
compiler will remove the empty branch.

But this is not just cleanliness: doesn't this evade the
preempt_disable() in the spin_unlock() on !CONFIG_SMP+CONFIG_PREEMPT?

	Robert Love

