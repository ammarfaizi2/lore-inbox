Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSKGPwp>; Thu, 7 Nov 2002 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSKGPwp>; Thu, 7 Nov 2002 10:52:45 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:38576 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261330AbSKGPwo>; Thu, 7 Nov 2002 10:52:44 -0500
Date: Thu, 7 Nov 2002 16:59:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Corey Minyard <cminyard@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework
In-Reply-To: <3DCA99F4.4090703@mvista.com>
Message-ID: <Pine.GSO.3.96.1021107165401.5894D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Corey Minyard wrote:

> >How? The NMI interrupt should be internally masked till IRET. I think your 
> >code is ok, but i don't see how it takes care of concurrent users such as 
> >oprofile and the nmi watchdog, the nmi watchdog already programs its own 
> >interrupt interval if its shared, what is the intended base NMI interval? 
> >How about handlers requiring a different interrupt interval? I have code 
> >which does the following;
> >
> NMIs cannot be masked, they are by definition non-maskable :-).  You can 
> get an NMI while executing an NMI.

 Not on the i386 family.  Once an NMI is accepted by the CPU, it gets
internally masked until an iret instruction gets executed.  If another NMI
happens maenwhile, it's latched by the processor internally and dispatched
as soon as NMIs are unmasked.  Further NMIs received when masked are lost. 

 Check datasheets for details.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

