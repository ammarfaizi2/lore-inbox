Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWFFKq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWFFKq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWFFKq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:46:57 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:19195 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750914AbWFFKq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:46:56 -0400
Subject: Re: [PATCH -mm] misroute-irq: Don't call desc->chip->end because
	of edge interrupts
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060605212033.072bb47d.akpm@osdl.org>
References: <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
	 <1149438131.29652.5.camel@localhost.localdomain>
	 <1149456375.23209.13.camel@localhost.localdomain>
	 <1149456532.29652.29.camel@localhost.localdomain>
	 <20060604214448.GA6602@elte.hu>
	 <1149564830.16247.11.camel@localhost.localdomain>
	 <20060605212033.072bb47d.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 06:46:11 -0400
Message-Id: <1149590771.16247.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 21:20 -0700, Andrew Morton wrote:
> On Mon, 05 Jun 2006 23:33:50 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > 
> > Hit the following BUG with irqpoll.  The below patch fixes it.
> > 
> 
> Call me a cynic, but
> 
> > +		if (work && disc->chip && desc->chip->end)
> 
> that doesn't look super-tested to me.

No, it hasn't been refreshed! Damn quilt!

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.17-rc5-mm3/kernel/irq/spurious.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/irq/spurious.c	2006-06-05 17:26:15.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/irq/spurious.c	2006-06-06 06:43:43.000000000 -0400
@@ -77,7 +77,7 @@ static int misrouted_irq(int irq, struct
 		 * If we did actual work for the real IRQ line we must let the
 		 * IRQ controller clean up too
 		 */
-		if (work)
+		if (work && desc->chip && desc->chip->end)
 			desc->chip->end(i);
 		spin_unlock(&desc->lock);
 	}



