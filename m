Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbUKZVh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUKZVh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbUKZVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:34:58 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:3749 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262598AbUKZUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:05:30 -0500
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125183923.GK1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296166.5805.279.camel@desktop.cunninghams>
	 <20041125183923.GK1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101420908.27250.71.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:15:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:39, Pavel Machek wrote:
> Hi!
> 
> > +#include "../../../kernel/power/suspend.h"
> 
> Ouch.
> 
> > +#define loaddebug(thread,register) > +               __asm__("movl %0,%%db" #register  > +                       : /* no output */ > +                       :"r" ((thread)->debugreg[register]))
> 
> This should be already defined somewhere...

Will look for it.

> > + * Note that the context and timing of this function is pretty critical.
> > + * With a minimal amount of things going on in the caller and in here, gcc
> > + * does a good job of being just a dumb compiler.  Watch the assembly output
> > + * if anything changes, though, and make sure everything is going in the right
> > + * place. 
> 
> You should include assembly source (unless you can test all the compilers...). Feel free
> to include C version, too, but #ifdef it out.

I'm thinking I should actually be removing the comment. The C is simple,
clear, fast and easy to maintain and we haven't actually had any
problems at all with compilers. All my tweaking in here has turned out
to be irrelevant to the real cause of problems (I recently found a bug
where work queues were wrongly inheriting freezer flags; since fixing
that, all the symptoms in this area have gone away).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

