Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVKJOSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVKJOSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVKJOSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:18:30 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:54538 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750832AbVKJOS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:18:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <17267.19126.260133.903822@gargle.gargle.HOWL>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
References: <20051107204136.GG19593@austin.ibm.com><1131412273.14381.142.camel@localhost.localdomain><20051108232327.GA19593@austin.ibm.com><B68D1F72-F433-4E94-B755-98808482809D@mac.com><20051109003048.GK19593@austin.ibm.com><m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local><20051109004808.GM19593@austin.ibm.com><19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com><20051109111640.757f399a@werewolf.auna.net><Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net><20051109192028.GP19593@austin.ibm.com><Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com><Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net><20051110091517.2e9db750@werewolf.auna.net> <17267.19126.260133.903822@gargle.gargle.HOWL>
X-OriginalArrivalTime: 10 Nov 2005 14:18:27.0111 (UTC) FILETIME=[9E0FAB70:01C5E601]
Content-class: urn:content-classes:message
Subject: Re: typedefs and structs
Date: Thu, 10 Nov 2005 09:18:21 -0500
Message-ID: <Pine.LNX.4.61.0511100904230.18912@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: typedefs and structs
Thread-Index: AcXmAZ4WQhid28mRRFGQ2l333qkmmg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Nov 2005, Nikita Danilov wrote:

> J.A. Magallon writes:
>
> [...]
>
> > >
> > > However, if the code is as follows:
> > > 	void foo (void) {
> > > 		int myvar = 0;
> > > 		printf("%d\n", myvar);
> > > 		bar(&myvar);
> > > 		printf("%d\n", myvar);
> > > 	}
> > > If bar is declared in _another_ file as
> > > 	void bar (const int * var);
> > > then I think the compiler can validly cache the value of 'myvar' for the
> > > second printf without re-reading it. Correct/incorrect?
> > >
> >
> > Nope. You can't trust bar() not doing something like
> >
> > bar(const int* local_var)
> > {
> >    ... use local_var as ro...
> >    extern int myvar;
> >    myvar = 7;
> > }
> >
> > For the compiler to do that, you must tag bar() with attribute(pure).
>
> extern declaration in your version of bar() cannot refer to the
> automatic variable myvar in foo().

Also, just because some called function may use casts to write
to a variable behind a void pointer doesn't mean that the function's
code must respect the potential of such buggy code.

The compiler must properly assume that the local variable, 'myvar'
will never be modified through the void pointer, even though some
jerk's buggy code may actually do that. Infortunately most protection
is page-based so there isn't any way for an OS to seg-fault somebody
who writes through void pointers.

The only hint that somebody did the wrong thing is that the wrong
value got printed. Because 'C' allows the use of casts, which
allows anything to be cast to anything else (may have to cheat by
first casting to void), the 'C' language not only allows you to
shoot yourself in the foot, but also hands you all the tools
necessary to do that, including loading and cocking the trigger.

Code inspection is sometimes necessary to avoid such problems.
In particular one must be on the lookout for 'excessive' casts.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
