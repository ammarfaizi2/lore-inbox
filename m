Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272633AbRHaI10>; Fri, 31 Aug 2001 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272634AbRHaI1Q>; Fri, 31 Aug 2001 04:27:16 -0400
Received: from t2.redhat.com ([199.183.24.243]:25851 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272633AbRHaI06>; Fri, 31 Aug 2001 04:26:58 -0400
Message-ID: <3B8F4A64.8B9DEDE4@redhat.com>
Date: Fri, 31 Aug 2001 09:27:16 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2.9smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Abbey <linux@cabbey.net>, linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net> <Pine.LNX.4.33.0108302353380.4964-100000@tweedle.cabbey.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Abbey wrote:
> 
> Today, Dan Hollis wrote:
> > but where would the finger start pointing then?
> 
> hmm... *compiler optimizations* for a specific family cause
> problems on that family, but *compiler optimizations* for
> a lesser family don't... I'll admit my kernel h4x0|^ 5k1!!s
> aren't on par with most on this list, but has anyone thought
> to take a look at the *compiler optimizations* that are
> generated? 

It's not the compiler options. (or at least not alone).
I have proof for this, let me explain:

For the upcomming Red Hat Linux release an athlon kernel
will be included, and due to the people who have this
problem, I added a kernel commandline option to disable
the optimized page_copy() and clear_page() functions.
The use of this option makes the machines, of the people
who had this problem, happy again.

Now I also wrote the 2 functions in question, and I am
very convinced that they are correct. They also work on
the vast majority of motherboards, and most of the failure
cases are cheaper motherboards (or cheap PSU's).

The net effect of using the optimized functions is that
the memory bandwidth the CPU uses effecively doubles during
COW and page_clear() operations. This puts additional load
on the motherboard it seems.... I don't know if it's the
voltage regulators or borderline ram chips that give up, 
but there are people who bought 25 identical machines (for
a classroom) and only 1 failed, reproducable.

Oh and btw, having these functions is the main reason for
enabling the "Athlon" CPU type; that's basically the real 
difference between a PII and Athlon compiled kernel.

Greetings,
    Arjan van de Ven
