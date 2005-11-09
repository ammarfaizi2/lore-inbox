Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbVKIWht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbVKIWht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbVKIWht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:37:49 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:55818 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751537AbVKIWhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:37:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net>
References: <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com> <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com> <Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net>
X-OriginalArrivalTime: 09 Nov 2005 22:37:43.0458 (UTC) FILETIME=[3305B820:01C5E57E]
Content-class: urn:content-classes:message
Subject: Re: typedefs and structs
Date: Wed, 9 Nov 2005 17:37:43 -0500
Message-ID: <Pine.LNX.4.61.0511091723460.14236@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: typedefs and structs
Thread-Index: AcXlfjMP4LI1LeaTTB2d77leCgZY3w==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Vadim Lobanov" <vlobanov@speakeasy.net>
Cc: "linas" <linas@austin.ibm.com>, "J.A. Magallon" <jamagallon@able.es>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Douglas McNaught" <doug@mcnaught.org>,
       "Steven Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
       <bluesmoke-devel@lists.sourceforge.net>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linuxppc64-dev@ozlabs.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Vadim Lobanov wrote:

> On Wed, 9 Nov 2005, linux-os \(Dick Johnson\) wrote:
>
>>
>> On Wed, 9 Nov 2005, linas wrote:
>>
>>> On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to remark:
>>>> On Wed, 9 Nov 2005, J.A. Magallon wrote:
>>>>
>>>>> void do_some_stuff(T& arg1,T&  arg2)
>>>>
>>>> A diligent C programmer would write this as follows:
>>>> 	void do_some_stuff (struct T * a, struct T * b);
>>>> So I don't see C++ winning at all here.
>>>
>>> I guess the real point that I'd wanted to make, and seems
>>> to have gotten lost, was that by avoiding using pointers,
>>> you end up designing code in a very different way, and you
>>> can find out that often/usually, you don't need structs
>>> filled with a zoo of pointers.
>>>
>>
>> But you can't avoid pointers unless you make your entire
>> program have global scope. That may be great for performance,
>> but a killer if for have any bugs.
>
> Just to extract some useful technical knowledge from the current ongoing
> "flamewar"...
> I'm not entirely sure if the above statement regarding performance is
> correct. Some enlightenment would be appreciated.
>
> Suppose you have the following code:
> 	int myvar;
> 	void foo (void) {
> 		printf("%d\n", myvar);
> 		bar();
> 		printf("%d\n", myvar);
> 	}
> If bar is declared in _another_ file as
> 	void bar (void);
> then I believe the compiler has to reread the global 'myvar' from memory
> for the second printf().
>

Correct because bar() could have modified (it's global).

> However, if the code is as follows:
> 	void foo (void) {
> 		int myvar = 0;
> 		printf("%d\n", myvar);
> 		bar(&myvar);
> 		printf("%d\n", myvar);
> 	}
> If bar is declared in _another_ file as
> 	void bar (const int * var);
> then I think the compiler can validly cache the value of 'myvar' for the
> second printf without re-reading it. Correct/incorrect?
>

Maybe you tried to trick me by showing the variable was not going
to be changed (const *). In that case, the compiler may not re-read
the variable. However, it can re-read the variable.

A "smart" compiler might just do: write(1, "0\n", 2);
... for the first printf() as well. Such compilers make
debugging difficult.

> -Vadim Lobanov
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
