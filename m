Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUJ0DvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUJ0DvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUJ0DvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:51:14 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:61520 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261339AbUJ0Dux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:50:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: ncunningham@linuxmail.org
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
Date: Tue, 26 Oct 2004 22:50:40 -0500
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com> <200410262220.38052.dtor_core@ameritech.net> <1098847066.5661.47.camel@desktop.cunninghams>
In-Reply-To: <1098847066.5661.47.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410262250.40674.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 10:17 pm, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2004-10-27 at 13:20, Dmitry Torokhov wrote:
> > On Tuesday 26 October 2004 09:48 pm, Li, Shaohua wrote:
> > > >One thing I have noticed is that by adding the sysdev suspend/resume
> > > >calls, I've gained a few seconds delay. I'll see if I can track down
> > > the
> > > >cause.
> > > Is the problem MTRR resume must be with IRQ enabled, right? Could we
> > > implement a method sysdev resume with IRQ enabled?
> > 
> > If I understand correctly the point of classifying device as sysdev is
> > that it (device) is essential for the system and must be suspended last
> > and resumed first, presumably with interrupts off. IRQ controller comes
> > to mind...
> 
> Yes, but could we not do something like the process with regular
> devices. ie a call with interrupts disabled and then a similar call with
> interrupts enabled?
> 

Yes, re-reading the parent post it seems that's what required for ACPI.
Doing a pass with IRQ ON for regular devices, then IRQ OFF, then IRQ on
again for sysdevs and then again with IRQ off. Man, that's getting messy...

Well, I understand that ACPI is using semaphore and a GFP_KERNEL, but what
is the problem with MTRR? I understand that they should be set with IRQ
off but I highly doibt that enabling IRQ at the end is a requirement.
I think what is described in the commnet is rather a "normal flow of events".

-- 
Dmitry
