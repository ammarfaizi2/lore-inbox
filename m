Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSFRUlA>; Tue, 18 Jun 2002 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317609AbSFRUk7>; Tue, 18 Jun 2002 16:40:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317607AbSFRUk5>; Tue, 18 Jun 2002 16:40:57 -0400
Date: Tue, 18 Jun 2002 13:41:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KPdj-0004EP-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206181334500.981-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Rusty Russell wrote:
>
> So any program that doesn't use the following is broken:

That wasn't so hard, was it?

Besides, we've had this interface for about 15 years, and it's called
"select()".  It scales fine to thousands of descriptors, and we're talking
about something that is a hell of a lot less timing-critical than select
ever was.

"Earth to Rusty, come in Rusty.."

How do we handle the bitmaps in select()? Right. We assume some size that
is plenty good enough. Come back to me when something simple like

	#define MAX_CPUNR 1024

	unsigned long cpumask[MAX_CPUNR / BITS_PER_LONG];

doesn't work.

The existing interface is _fine_, and when somebody actually has a machine
with more than 1024 CPU's (yeah, right, I'm really worried), the existing
interface will cause graceful errors instead of doing something
unexpected.

And if you're telling me that people who care about CPU affinity cannot
fathom a simple bitmap of longs, you're just out to lunch.

			Linus

