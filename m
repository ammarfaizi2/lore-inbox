Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUIZTYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUIZTYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUIZTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 15:24:06 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:40131 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261875AbUIZTYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 15:24:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sun, 26 Sep 2004 21:25:38 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <200409251214.28743.rjw@sisk.pl> <200409261906.10635.rjw@sisk.pl> <20040926183449.GA28810@elf.ucw.cz>
In-Reply-To: <20040926183449.GA28810@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409262125.38271.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 20:34, Pavel Machek wrote:
> Hi!
> 
> > [-- snip --]
> > >  swsusp: Image: 11145 Pages
> > >  swsusp: Pagedir: 0 Pages
> > > Writing data to swap (11145 pages)...   0%
> > > 
> > > Here I have to press the red button unless I want to wait for a couple 
of 
> > > hours.  I'll send you more info when there's more.
> > 
> > I figured out that the slowdown occurs in device_resume(), so I put a 
printk() 
> > in dpm_resume(), like this:
> 
> When you hit "writing data to swap", device_resume should be no longer
> happening.

It isn't.  Still, device_resume() is called explicitly by swsusp_write() and 
IMO what happens is that the resume() function of one of the drivers does 
something that causes the system to slow down, which affects the writing 
operation (please note that the clock seems to be unaffected, though).  I'll 
try to narrow it.

> Try to unload all modules etc, see if it goes away.

I guess it will, but I'll check.

> If not, fix sysrq  to work for you, and look at backtrace.

This would be more time-consuming. :-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
