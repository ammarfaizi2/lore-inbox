Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVAHPK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVAHPK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVAHPK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:10:28 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:27589 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261186AbVAHPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:10:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Date: Sat, 8 Jan 2005 16:10:57 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
References: <20050106002240.00ac4611.akpm@osdl.org> <200501081049.02862.rjw@sisk.pl> <20050108131909.GA7363@elf.ucw.cz>
In-Reply-To: <20050108131909.GA7363@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501081610.57625.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 8 of January 2005 14:19, Pavel Machek wrote:
> Hi!
> 
> > > Thanks for pointing it out.  I have adapted this patch to -mm2, but 
> > > unfortunately it does not fix the issue.  Still searching. ;-)
> > 
> > The regression is caused by the timer driver.  Obviously, turning 
> > timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go away.
> > 
> > It looks like a locking problem to me.  I'll try to find a fix, although 
> > someone who knows more about these things would probably do it faster. :-)
> 
> (I do not have time right now, but...)
> 
> ..you might want to look at i386 time code, they have common
> ancestor, and i386 one seems to work.

Well, I need the help of The Wise. :-)

If I comment out only the modification of jiffies in timer_resume() in 
arch/x86_64/kernel/time.c (ie line 986), everything seems to work, but I get 
"APIC error on CPU0: 00(00)" after device_power_up(), which seems strange to 
me, because I boot with "noapic".  On the other hand, if it's not commented 
out (ie jiffies _is_ modified in timer_resume()), the machine hangs solid 
after executing device_power_up() in swsusp_suspend().

Right now I have no idea of what happens there, and it seems strange because 
in 2.6.10-mm1 the code in time.c is the same.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
