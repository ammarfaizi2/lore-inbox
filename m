Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbRFAHGc>; Fri, 1 Jun 2001 03:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263396AbRFAHGW>; Fri, 1 Jun 2001 03:06:22 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:25352
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S262988AbRFAHGF>; Fri, 1 Jun 2001 03:06:05 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200106010657.f516vmx11933@www.hockin.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real this  time)
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Thu, 31 May 2001 23:57:48 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106010409.f5149rl25342@devserv.devel.redhat.com> from "Pete Zaitcev" at Jun 01, 2001 12:09:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks interesting. Seemingly literate use of spinlocks.

thanks - I gave it lots of thought.

> Off-hand I see old style initialization. Is it right for new driver?

the old-style init is because it is an old driver.  I want to do a full-on
rework, but haven't had the time.

> i2c framework is not used, I wonder why. Someone thought that
> it was too heavy perhaps? If so, I disagree.

i2c is only in our stuff because the i2c core is not in the standard kernel
yet.  As soon as it is, I will make cobalt_i2c* go away.

> if any alignment with lm-sensors is possible, for the sake of

yes - I have communicated with the lm-sensors crew.  It is very high on my
wishlist.

> lcd_read bounces reads with -EINVAL when another read is in
> progress. Gross.

as I said - I didn't write the LCD driver, I just had to port it up :)  I
want to re-do the whole paradigm of it (it has been ported forward since 
2.0.3x)

> 1.:
> 	p = head;
> 	while (p) {
> 		p = p->next;
> 	}
> 
> It is what for(;;) does.

I don't get it - are you saying you do or don't like the while (p)
approach?  I think it is clearer because it is more true ot the heuristic -
"start at the beginning and walk down the list".

> 2. Spaces and tabs are mixed in funny ways, makes to cute effects
> when quoting diffs.

I've tried to eliminate that when I see it - I'll give the diff a close
examination.

thanks for the feedback - it will be nice to not have to constantly port
all our changes to each kernel release.  There are still some patches (of
course) but I didn't submit them because they are VERY specific to cobalt -
for example in the ide probing calling cobalt_ruler_register().  Ifdefs
protect, but the overall appearance would be rejected, I suspect - no?

Tim
