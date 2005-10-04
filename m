Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVJDGOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVJDGOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVJDGOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:14:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:14475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932363AbVJDGOQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:14:16 -0400
X-Authenticated: #9962044
From: Marc <marvin24@gmx.de>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: clock skew on B/W G3
Date: Tue, 4 Oct 2005 08:14:06 +0200
User-Agent: KMail/1.8.2
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510040814.07188.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

given that this option causes problems on non i386 systems, may I propose to 
mark CONFIG_HZ as broken on these architectures and/or use a default value of 
1000 ? I guess this issue can't be fixed in a sane way until 2.6.14 is out.

Marc

Le Montag 03 Oktober 2005 16:18, Rune Torgersen a écrit :
> > -----Original Message-----
> > From:  Marc
> > Sent: Sunday, October 02, 2005 11:46
> >
> > Some additions to the previous mail: I was able to isolate
> > the problem to the
> > introduction of a user specificable value of HZ (in
> > include/asm-ppc/parm.h).
> > I used a value of 250 while the former default was 1000.
> > Setting it back to
> > 1000 makes the clock tick right again.
> >
> > Is the CONFIG_HZ known to be broken on PPC ?
>
> CONFIG_HZ is not broken, but the whole clock configuration is.
> (I poseded something about it for 8260 earlier this summer)
>
> Basic problem is that CLOCK_TICK_RATE which is used for setting up the
> variables used for advancing the clock, is hardcoded to a value that
> only makes sence for an i386. (it is default set at 1193180Hz which
> happens to be the timer clock for timer1 on an i386 machine)
>
> Another problem here is that that value apparently hve to be #define'd
> which means you cannot insert the decrementer frequency from the
> boot-loader either.
