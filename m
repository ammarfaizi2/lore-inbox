Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUGAMkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUGAMkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUGAMkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:40:08 -0400
Received: from mail.shareable.org ([81.29.64.88]:60333 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264791AbUGAMkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:40:00 -0400
Date: Thu, 1 Jul 2004 13:39:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701123941.GC4187@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org> <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> >Can you confirm in a simple way that mapping a file, or some anonymous
> >memory, without PROT_READ, really isn't writable under MacOS X?  Can
> >you confirm it with a word write, if that would be relevant?
> 
> I hope I didn't make some stupid mistake in my program, but here it
> is, and here are my results.

Thanks for testing, Kyle.

It looks fine, although this is wrong:

>         mem = mmap(0,4096,PROT_WRITE,MAP_ANON|MAP_SHARED,-1,0);
> ...
>         if (mem == 0) return 1;

The error code is -1, aka. MAP_FAILED.

> Starting...
> Mapped memory!
> Address is 4000

That's a surprisingly low address.

> Bus error

Phew, I'm glad I decided to catch SIGBUS in the test program at the
last moment...

That's a historical BSD-ism.  They can't change it now, because
programs do trap and check for SIGBUS on that platform for protection
violations.

> I'll probably go file a bug with Apple now :-D

It might be a generic *BSD bug (for whatever value of * is used by MacOS X).

That would be interesting to know -- anyone here running *BSD on PPC
or any other architecture to test?

Of course it's an Apple bug as well :)

-- Jamie
