Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131850AbQKZCi3>; Sat, 25 Nov 2000 21:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131986AbQKZCiU>; Sat, 25 Nov 2000 21:38:20 -0500
Received: from hera.cwi.nl ([192.16.191.1]:56960 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131850AbQKZCiF>;
        Sat, 25 Nov 2000 21:38:05 -0500
Date: Sun, 26 Nov 2000 03:08:02 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126030802.C7049@veritas.com>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com> <3A20451B.2A69BB75@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A20451B.2A69BB75@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Nov 25, 2000 at 06:02:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 06:02:51PM -0500, Jeff Garzik wrote:
> Andries Brouwer wrote:
> > In a program source there is information for the compiler
> > and information for the future me. Removing the " = 0"
> > is like removing comments. For the compiler the information
> > remains the same. For the programmer something is lost.
> 
> This is pretty much personal opinion :)
> 
> The C language is full of implicit as well as explicit features.  You
> are arguing that using an implicit feature robs the programmer of
> information.  For you maybe...  For others, no information is lost AND
> the code is more clean AND the kernel is smaller.  It's just a matter of
> knowing and internalizing "the rules" in your head.

Oh Jeff,

All these really good people, unable to capture a simple idea.
Let me try one more time.
There is information. The information is:
	"this variable needs initialization"
Now you tell me to know simple rules. OK, I know them.
But what do they tell me about my variables a and b, where
a requires initialization and b does not require it?

One can write a comment, like

int a;	/* this variable needs initialization, fortunately
	   it is already initialized at startup */
int b;	/* no initialization required */

But that is overdoing it, it uglifies the code.
One can leave the comment out, like

int a, b;

But then next month, when you decide to move this into
some function

int foo() {
	int a, b;
...

there is no indication that you need an additional

	a = 0;

You see?
There is real information here. Useful as a reminder.
Not necessary. The perfect programmer would see
immediately that the assignment is required, also
without the reminder. But not everybody is perfect
all of the time, and sometimes the code involved is
quite complicated. The tiny convention
"write an explicit initialization when initialization is needed"
is helpful. It is a form of program documentation.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
