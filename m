Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVHJNI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVHJNI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVHJNI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:08:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58792 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965095AbVHJNIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:08:25 -0400
Date: Wed, 10 Aug 2005 15:08:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@osdl.org,
       Martin =?utf-8?Q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>,
       Zlatko Calusic <zlatko.calusic@iskon.hr>,
       =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@24x7linux.com>,
       john@illhostit.com, sjordet@gmail.com, fastboot@lists.osdl.org,
       linux-kernel@24x7linux.com, ncunningham@cyclades.com,
       Greg KH <greg@kroah.com>
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
Message-ID: <20050810130803.GA2004@elf.ucw.cz>
References: <42F121CD.5070903@ribosome.natur.cuni.cz> <20050803200514.3ddb8195.akpm@osdl.org> <20050805140837.GA5556@localhost> <42F52AC5.1060109@ribosome.natur.cuni.cz> <m1hde2xy74.fsf@ebiederm.dsl.xmission.com> <m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com> <20050807190222.GF1024@openzaurus.ucw.cz> <m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com> <20050807211104.GE3100@elf.ucw.cz> <m1pssnvx84.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pssnvx84.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Code is not ready now => it can never be fixed? Thats quite a strange
> >> > conclusion to make.
> >> 
> >> It seems there is an fundamental incompatibility with ACPI power off.
> >> As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
> >> works reasonably well in 2.6.x.
> >
> > Powerdown is going to have the same problems as the powerdown at the
> > end of suspend-to-disk. Can you ask people reporting broken shutdown
> > to try suspend-to-disk?
> 
> Everyone I know of who is affected has been copied on this thread.
> However your request is just nonsense.  There is a device_resume in
> the code before we get to the device_shutdown so there should be no
> effect at all.  Are we looking at the same kernel?

Sorry, my fault. kernel/power/disk.c:power_down(): it calls
device_shutdown even in PM_DISK_PLATFORM case. I thought it would do
device_suspend() to enable drivers doing something more clever.

So only missing piece of puzzle seems to be making sure disks are
properly spinned down in device_shutdown... and even that seems to be
there, not sure why it was broken before.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
