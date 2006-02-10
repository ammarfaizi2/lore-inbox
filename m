Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWBJNrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWBJNrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWBJNrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:47:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27879 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751259AbWBJNrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:47:03 -0500
Date: Fri, 10 Feb 2006 14:46:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210134638.GA5109@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de> <20060210121913.GA4974@elf.ucw.cz> <20060210123259.GB18577@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210123259.GB18577@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 10-02-06 13:32:59, Stefan Seyfried wrote:
> On Fri, Feb 10, 2006 at 01:19:13PM +0100, Pavel Machek wrote:
> > On Pá 10-02-06 09:06:43, Stefan Seyfried wrote:
> 
> > > Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
> > > Can't we handles this easily in userspace?
> > 
> > Some kernel parts need to now: for example powernow-k8: some
> 
> we can tell them from userspace.

No, because battery will explode if you do not slow cpu down fast
enough. And it would be extremely ugly.

Right now, interfaces we have are:

/proc/apm -- to get AC/DC info on APM

/proc/acpi/ac_adapter/*/state -- to get in on ACPI

...then we have...

in-kernel interface to get AC/DC info on APM, and in-kernel interface
to get AC/DC info on ACPI (powernow-k8 needs it). Brightness needs to
use those interfaces, too.

With your proposed solution, we'd have to add
/proc/powernow_k8/you_are_on_ac and /proc/backlight/you_are_on_ac and
..., or something, along with daemon to poll /proc/apm and
/proc/acpi/*/*/state (and whatever else embedded machines do), and
feed it back to kernel.

That's clearly wrong thing to do. So Matthew patch is actually
cleanup. It should allow us to kill special interfaces and have
something like /sys/power/ac ... and not having to introduce special
interfaces for pn-k8, backlight and more.

(More responses in separate thread.)

> > frequencies are not allowed when you are running off battery. [Just
> > now it is solved by not allowing those frequencies at all unless ACPI
> > is available; quite an ugly solution.]
> 
> And this is a reason to include it in the kernel?
> Pavel? Is it you? What have they done to you? ;-)

Frequency scaling is currently done in kernel, and this is "battery
blows up" issue.

> I mean - we are moving suspend and everything to userspace, so i wonder
> why this has to be in kernel.

Unless you want LZF, encryption, and graphical progress bar, suspend
goes to userspace. But AC/DC knowledge is actually neccessary for
kernel. You can live without it on most PCs (except powernow-k8
machines and notebooks that have braindamaged), but embedded platforms
definitely need it.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
