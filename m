Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUIZLnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUIZLnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 07:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269516AbUIZLnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 07:43:40 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:36798 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267571AbUIZLng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 07:43:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sun, 26 Sep 2004 13:45:10 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
References: <200409251214.28743.rjw@sisk.pl> <4155E40D.2020709@suse.de> <200409261202.34138.rjw@sisk.pl>
In-Reply-To: <200409261202.34138.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409261345.10565.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 12:02, Rafael J. Wysocki wrote:
> On Saturday 25 of September 2004 23:33, Stefan Seyfried wrote:
> > Rafael J. Wysocki wrote:
> > > Pavel,
> > > 
> > > I've just tried to suspend my box and I must admit I've given up after 
30 
> > > minutes (sic!) of waiting when there were only 12% of pages written to 
> disk.  
> > > Apparently, swsusp slows down to an unacceptable level after saying "PM: 
> > > Writing image to disk".
> > 
> > is this reproducible?
> 
> Yes, it is.  100% of the time, AFAICT, though I've tried it for only a 
couple 
> of times.

I can confirm that it's 100% reproducible.

> > can you get sysrq-t / sysrq-p while it is slow 
> > writing to disk?
> 
> Well, I'll try, but sysrq didn't work for me at all on 2.6.9-rc2-mm1, so I'm 
> not sure if I really can.

As I suspected, the damn sysrq doesn't work (/proc/sysrq-trigger does, so it 
_is_ compiled in, sigh).

I'm only able to get swsusp output from the serial console:

Stopping tasks: ==============================|
Freeing memory... done (18812 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 0x588]......................................swsusp: Need to 
copy 11017 pages
suspend: (pages needed: 11017 + 512 free: 119862)
..<7>[nosave pfn 0x588]......................................swsusp: critical 
section/: done (11145 pages copied)
PM: writing image.

and it slows down _here_:

PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:02.1 to 64
PCI: Setting latency timer of device 0000:00:02.2 to 64
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
 swsusp: Version: 132617
 swsusp: Num Pages: 130880
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: albercik
 swsusp: UTS Release: 2.6.9-rc2-mm3
 swsusp: UTS Version: #1 Fri Sep 24 11:52:15 CEST 2004
 swsusp: UTS Machine: x86_64
 swsusp: UTS Domain:
 swsusp: CPUs: 1
 swsusp: Image: 11145 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (11145 pages)...   0%

Here I have to press the red button unless I want to wait for a couple of 
hours.  I'll send you more info when there's more.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
