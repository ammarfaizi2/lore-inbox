Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317877AbSGKTUJ>; Thu, 11 Jul 2002 15:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGKTUI>; Thu, 11 Jul 2002 15:20:08 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:21523 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317877AbSGKTUH>;
	Thu, 11 Jul 2002 15:20:07 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207111921.g6BJLtI459123@saturn.cs.uml.edu>
Subject: Re: HZ, preferably as small as possible
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 11 Jul 2002 15:21:55 -0400 (EDT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
       andrew.grover@intel.com (Grover Andrew), cat@zip.com.au ('CaT'),
       bcrl@redhat.com (Benjamin LaHaise), akpm@zip.com.au (Andrew Morton),
       linux-kernel@vger.kernel.org (Linux)
In-Reply-To: <3D2DBB7B.9020600@evision-ventures.com> from "Martin Dalecki" at Jul 11, 2002 07:08:11 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
> U\277ytkownik Jeff Garzik napisa\263:

>> I don't see that making 'HZ' a variable is really an option, because 
>> many drivers and scheduler-related code will be wildly inaccurate as 
>> soon as HZ actually changes values.

Definitely:
my_timeout = foo*HZ;

>> So that leaves us with the option of changing all the code related to 
>> waiting to be based on msecs and usecs.  Which I would love to do, but 
>> that's a lot of work, both code- and audit-wise.
>
> vmstat.c:
>
> hz = sysconf(_SC_CLK_TCK);	/* get ticks/s from system */

Oops! Sorry I missed that one. Not that it matters for
the 2.5.25 kernel and above, but that code really should
be using the Hertz value supplied by libproc.

> And yes I know the libproc is *evil* in this area.

Hell yes. It's going to remain evil until the 2.4 kernel
is a distant memory. Debian uses a 2.2 kernel in the
upcoming release, so it will be a good long time until
everyone is using a 2.6 kernel. When 2.8 comes out,
Debian will finally stop using 2.4 and I can get rid of
my evil hack.

Hey, I asked for a clean way to get HZ. I didn't even
get "send a patch"; I got BS about the 2.5.25 behavior
being standard, as if it had already been implemented.

> The rest should be an implementation detail of sysconf().

That's broken. It can't even correctly report the
number of processors you have.
