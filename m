Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbTCGBQj>; Thu, 6 Mar 2003 20:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTCGBQi>; Thu, 6 Mar 2003 20:16:38 -0500
Received: from palrel11.hp.com ([156.153.255.246]:20941 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S261326AbTCGBQh>;
	Thu, 6 Mar 2003 20:16:37 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15975.62823.5398.712934@napali.hpl.hp.com>
Date: Thu, 6 Mar 2003 17:27:03 -0800
To: george anzinger <george@mvista.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: POSIX timer syscalls
In-Reply-To: <3E67DF8E.9080005@mvista.com>
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>
	<3E67DF8E.9080005@mvista.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 06 Mar 2003 15:53:50 -0800, george anzinger <george@mvista.com> said:

  George> I think there is a bit of a problem in the idr code
  George> (.../lib/idr.c) which manages the id allocation.  Seems we
  George> are returning "long" from functions declared as int.  If I
  George> remember the code correctly this will work, but it does
  George> eliminate the sequence number that should be in the high 8
  George> bits of the id.

Yes.  We have had some reports of problems with POSIX timers and I
suspect this might be the reason (though I don't know what the exact
code-base was that the person reporting the problem was using).

  George> This assumes that you never allocate more than 2,147,483,647
  George> timers at once :) I will look at this and send in a patch.
  George> I think we should return what ever timer_t is, so we should
  George> run that to ground first.

Yes, that would be better.  According to Uli, a 32-bit timer_t is fine
as far as the standards are concerned.  That's good.

  George> I suspect we should also have a look at all the structures
  George> with a view to alignment issues or is this not a problem?
  George> I.e. is this struct ok:

  George> struct { long a; int b; long c; }

Such code may be OK correctnesswise, but to avoid wasting space, it's
clearly better to list larger members first.

	--david
