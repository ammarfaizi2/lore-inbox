Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRALMSm>; Fri, 12 Jan 2001 07:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRALMSc>; Fri, 12 Jan 2001 07:18:32 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:52241 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131141AbRALMSX>;
	Fri, 12 Jan 2001 07:18:23 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Fri, 12 Jan 2001 13:01:12 BST."
             <3A5EF208.4013B5F7@innominate.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jan 2001 23:18:12 +1100
Message-ID: <31714.979301892@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001 13:01:12 +0100, 
Daniel Phillips <phillips@innominate.de> wrote:
>Keith Owens wrote:
>> I want to completely remove this multi layered method for setting
>> initialisation order and go back to basics.  I want the programmer to
>> say "initialise E and F after G, H and I".  The kernel build system
>> works out the directed graph of initialisation order then controls the
>> execution of startup code to satisfy this graph.
>
>I don't doubt you will come up with a workable solution at build time. 
>However, working out a valid graph at execution time is trivial and
>efficient, given a list of precedence relations of the kind you're
>suggesting.  In fact you don't even have to work out the graph before
>starting the initialization, it's also trivial to keep a count of
>unsatisfied initialization conditions at the beginning of each
>initialization sequence and block until the count goes to zero.  (In
>essence, evaluate a priority sort on the fly.)

It is safer to evaluate the graph at link time in case somebody
mistakenly codes a dependency loop, that is an abort case.  Finding
that you have a loop at load time and aborting the kernel is a little
too drastic for my tastes.

In any case it is academic.  Linus insists on link order being
explicitly and completely specified by the programmer and he likes the
link order being implied by Makefile order.  So there is no point in
working on a better system.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
