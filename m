Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTEHUeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTEHUeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:34:25 -0400
Received: from fmr04.intel.com ([143.183.121.6]:27895 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262118AbTEHUeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:34:21 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCAFD78@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Ming Lei'" <lei.ming@attbi.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: can linux RT thread corrupt  global variable?
Date: Thu, 8 May 2003 13:46:27 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Ming Lei [mailto:lei.ming@attbi.com]
>
> ...
>
> There is a global variable I define as 'int cpl'. All the threads and main
> process may alter cpl at any time. cpl may have one of these values {0,
> 0xf000006e, 0xf0000068, 0xe0000000, 0xe0000060}.
> 
> <Problem=> at some point of execution which cpl should be a value say
> e0000060, but the actual value retained at cpl is another say e0000000;
that
> is, the value is changed without the program actually done anything on it.
> The retained value I observed is kind of historic value(one of these value
> in the above set), not the arbituary value. The problem had occured just
> after context switch, also occured during a thread execution.

Probably GCC is keeping the value of the variable around in
some register. Did you declare the global variable as 'volatile'?
[as in "it can be modified by entities external to the flow of 
the code"]. Try that.

On the other hand - being an integer, access should be atomic,
most of the time, but I would not really trust that, at least
portability wise. Protecting access to it with a mutex would
be a good idea ...

> Is linux kernel 2.4.10 considered strictly preemptive such as VxWorks or
> other RTOS? 

Nope

> I guess 2.4.10 may simulate preemptive with running scheduler on
> every syscall or interrupt returns. Am I right?

You need the preemption patches or 2.5

I hope you are not trying to do serious real-time w/ Linux ... are you?

> Is printf() real-time priority thread safe?

Dunno - you'd have to check the internal implementation in
glibc. Last time I heard anything about it, it had some
mutex dangling around, but I could be wrong.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
