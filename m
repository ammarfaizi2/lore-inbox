Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTHYW6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbTHYW6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:58:17 -0400
Received: from gate.firmix.at ([80.109.18.208]:50625 "EHLO buffy.firmix.at")
	by vger.kernel.org with ESMTP id S262386AbTHYW6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:58:10 -0400
Subject: Re: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep
	status report
From: Bernd Petrovitsch <bernd@firmix.at>
To: "P. Christeas" <p_christ@hol.gr>
Cc: acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200308260147.50968.p_christ@hol.gr>
References: <200308260125.30194.p_christ@hol.gr>
	<1061851218.12331.23.camel@gimli.at.home> 
	<200308260147.50968.p_christ@hol.gr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Aug 2003 00:57:44 +0200
Message-Id: <1061852265.8896.36.camel@gimli.at.home>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 00:47, P. Christeas wrote:
> Bernd Petrovitsch wrote:
> > On Tue, 2003-08-26 at 00:25, P. Christeas wrote:
> > > Just found out that by 'echo sth_wrong > /sys/power/state' the kernel
> > > would oops in a fatal way (no clean exit from there).
> > > The oops suggested that the code would enter an invalid fn.
> > >
> > > You may apply the included patch to solve the bug. IMHO doing a clean
> > > exit is much preferrable than having BUG() there.
> >
> > > diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c
> > > /usr/src/linux/kernel/power/main.c ---
> > > /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23
> > > 12:13:17.000000000 +0300 +++
> > > /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300 @@
> > > -500,7 +514,7 @@
> > >  		if (s->name && !strcmp(buf,s->name))
> > >  			break;
> > >  	}
> > > -	if (s)
> > > +	if ( (s) && (state < PM_SUSPEND_MAX) )
> > >  		error = enter_state(state);
> > >  	else
> > >  		error = -EINVAL;
> >
> > What do you think about the attached patch to solve the bug and remove a
> > warning?
[...]

> Already tried that. If you look more closely, the s will receive the state 
> *before* the name *in it* is strcmp()'ed. This means it won't be NULL anyway.
> >               if (s->name && !strcmp(buf,s->name))
> >                       break;

*arrgl*, yes. Could only change somthing if the PM_SUSPEND_MAX == 0.
Hmm, the check on `s != NULL' seems also pretty superflous since
s loops over the elements in the array.

> I also thought of checking "( (s) && (s->name !=NULL) )" ,  but IMHO the 
> 'state' check is cleaner (no dereference).

Yup.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

