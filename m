Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132396AbRDDU0b>; Wed, 4 Apr 2001 16:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDDU0V>; Wed, 4 Apr 2001 16:26:21 -0400
Received: from inet.connecttech.com ([206.130.75.2]:22748 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S132396AbRDDU0L>; Wed, 4 Apr 2001 16:26:11 -0400
Message-ID: <04c101c0bd45$f8182960$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: =?ISO-8859-1?Q? <Sarda=F1ons@connecttech.com>,
        ?= "Eliel" <Eliel.Sardanons@philips.edu.ar>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA028416D@MAINSERVER>
Subject: Re: kernel/sched.c questions
Date: Wed, 4 Apr 2001 16:29:37 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had similar questions recently when I was doing some
hacking; these are my guesses:

From: <Sardañons>; "Eliel" <Eliel.Sardanons@philips.edu.ar>
> Hello, I would like to know why you put this two functions:
> void scheduling_functions_start_here(void) { }
> ...
> void scheduling_functions_end_here(void) { }

Just as markers for easy location in System.map.
The compiler should optimise those away.

> why you put 'case TASK_RUNNING'
>
> switch (prev->state) {
>                 case TASK_INTERRUPTIBLE:
>                         if (signal_pending(prev)) {
>                                 prev->state = TASK_RUNNING;
>                                 break;
>                         }
>                 default:
>                         del_from_runqueue(prev);
>                 case TASK_RUNNING:
> }

Prevent compiler warnings about unhandled conditions?
Not sure about that one.

> in the function schedule() you always use this syntax:
>
> -----
> if (a_condition)
>     goto bebe;
> bebe_back
>
>
> bebe:
>     do_bebe();
>     goto bebe_back;
> ------
> why not just doing:
>
>    if (a_condition)
>          do_bebe();

Probably because the compiler puts out

setup function parameter one
setup function parameter two
setup function parameter three
check condition
call function
setup function parameter one
setup function parameter two
setup function parameter three
check condition
call function

for your case and the above convolutions
puts out

check condition
jump to call if needed
check condition
jump to call if needed

instead.

Or even if the compiler puts out

check condition
If condition
  setup function parameter one
  setup function parameter two
  setup function parameter three
  call function
check condition
if condition
  setup function parameter one
  setup function parameter two
  setup function parameter three
  call function

I'm betting the smaller code above is better
for cache hits, right?

But these are my guesses. Anyone want to
clarify?

..Stu


