Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVAHJxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVAHJxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVAHJvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:51:52 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:65215 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261858AbVAHJse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:48:34 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@linuxmail.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Date: Sat, 8 Jan 2005 10:49:02 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050106002240.00ac4611.akpm@osdl.org> <1105135940.2488.39.camel@desktop.cunninghams> <200501080156.06145.rjw@sisk.pl>
In-Reply-To: <200501080156.06145.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501081049.02862.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 8 of January 2005 01:56, Rafael J. Wysocki wrote:
> On Friday, 7 of January 2005 23:12, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Fri, 2005-01-07 at 23:45, Rafael J. Wysocki wrote:
> > > > ..so... could you go through sysdev_register()s, one by one,
> > > > commenting them to see which one causes the regression? That driver
> > > > then needs to be fixed.
> > > > 
> > > > Go after mtrr and time in first places.
> > > 
> > > OK, but it'll take some time.
> > 
> > There's an MTRR fix in the -overloaded ck patches. Perhaps it is what
> > you're after. (Or perhaps it's already included :>)
> > 
> > http://kem.p.lodz.pl/~peter/cko/fixes/2.6.10-cko1-swsusp_fix.patch
> 
> Thanks for pointing it out.  I have adapted this patch to -mm2, but 
> unfortunately it does not fix the issue.  Still searching. ;-)

The regression is caused by the timer driver.  Obviously, turning 
timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go away.

It looks like a locking problem to me.  I'll try to find a fix, although 
someone who knows more about these things would probably do it faster. :-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
