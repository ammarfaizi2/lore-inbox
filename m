Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVEINHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVEINHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVEINHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:07:43 -0400
Received: from general.keba.co.at ([193.154.24.243]:3041 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261349AbVEINHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:07:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Real-Time Preemption: Magic Sysrq p doesn't work
Date: Mon, 9 May 2005 15:07:43 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323204@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Real-Time Preemption: Magic Sysrq p doesn't work
Thread-Index: AcVUkIs3p829ZrfUQEmcaVUIUhZ9MwABIjEA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "kus Kusche Klaus" <kus@keba.com>
Cc: <linux-kernel@vger.kernel.org>, <dwalker@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * kus Kusche Klaus <kus@keba.com> wrote:
> 
> > While testing, I noticed that Sysrq p is silently ignored 
> on current 
> > RT kernels with RT preemption: The syslog contains a message that 
> > Sysrq p was pressed, but no registers are printed.
> 
> yes, that's because the keyboard interrupt is 'threaded' - 
> hence there's 
> no 'interrupted stack' to print a backtrace of. You should be able to 
> see all (including currently running) task's backtraces in SysRq-T 
> output.
> 
> are you trying to use it to debug a particular bug?

No, not yet.

I've been asked to analyze the various tools and possibilities available
to debug an RT kernel.

Up to now, what I've found is not too impressive:
* Plain GDB can be used to display the current value of kernel variables
symbolically, but no more: It won't tell anything about the kernel's
current activity.
* kgdb and kdb seem to be deeply incompatible with the RT patches (they
mess with the scheduler, interrupts etc.), applying their patches to an
RT tree fails quite impressively.
* LKCD is too heavy for debugging embedded systems (which do not have
swap partitions or other permanent memory to spare); for netdump, I was
unable to find any recent and working download (I found the server, but
where is the client-side kernel code?); and kdump-via-kexec is "not yet
there". Moreover, most of them are for i386 and won't support ARM (or
PPC).

So Sysrq was one of my hopes to give developers an easy tool to check
quickly where their kernel is, if it still moves or loops, what the
reg's are, ...

Sysrq t works, but produces by far too much output for that purpose -
it's hard to get any information (especially if things are still
changing or already frozen) from Sysrq t "at a quick glance".

Any other hints for debugging?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
