Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270420AbTGaWJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270530AbTGaWJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:09:25 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:55533 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270420AbTGaWI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:08:29 -0400
Date: Fri, 1 Aug 2003 00:08:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731220807.GC487@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094904.GC464@elf.ucw.cz> <1059686717.2418.156.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059686717.2418.156.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  - APM uses the pm_*() calls for a vetoable check,
> > >    never issues SAVE_STATE, then goes POWER_DOWN.
> > 
> > I remember the reason... SAVE_STATE expects user processes to be
> > stopped, which is not the case in APM. Perhaps that is easy to fix
> > these days...
> 
> No ! You may feel better stopping user processes (and actuallty you
> may require that for swsusp, I don't know) but the whole PM scheme is
> designed to make that unnecessary. I do NOT stop user processes on
> suspend-to-RAM on PowerMacs, I don't think neither APM nor ACPI need
> that (I may be wrong here, but if that is the case, then some drivers
> need fixing).

When all drivers are safe, stopping user processes on ACPI S3 will no
longer be needed.

But they are not safe for now, and I believe that stopping processes
makes some hw drivers safe where they were not safe before. At least
if process is sleeping within some driver, stopping user processes
will wait till it exits the driver. That should help for simple
devices.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
