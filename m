Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752756AbVHGVLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbVHGVLb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbVHGVLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:11:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752756AbVHGVLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:11:30 -0400
Date: Sun, 7 Aug 2005 23:11:04 +0200
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
Message-ID: <20050807211104.GE3100@elf.ucw.cz>
References: <42E8439E.9030103@ribosome.natur.cuni.cz> <20050727193911.2cb4df88.akpm@osdl.org> <42F121CD.5070903@ribosome.natur.cuni.cz> <20050803200514.3ddb8195.akpm@osdl.org> <20050805140837.GA5556@localhost> <42F52AC5.1060109@ribosome.natur.cuni.cz> <m1hde2xy74.fsf@ebiederm.dsl.xmission.com> <m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com> <20050807190222.GF1024@openzaurus.ucw.cz> <m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> There as been a fair amount of consensus that calling
> >> device_suspend(...) in the reboot path was inappropriate now, because
> >> the device suspend code was too immature.   With this latest
> >> piece of evidence it seems to me that introducing device_suspend(...)
> >> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
> >> can never be appropriate.
> >
> > Code is not ready now => it can never be fixed? Thats quite a strange
> > conclusion to make.
> 
> It seems there is an fundamental incompatibility with ACPI power off.
> As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
> works reasonably well in 2.6.x.

Powerdown is going to have the same problems as the powerdown at the
end of suspend-to-disk. Can you ask people reporting broken shutdown
to try suspend-to-disk?

> >From what I can tell there are some fairly fundamental semantic
> differences, on that code path.  The most peculiar problem I tracked
> is someone had a machine that would go into power off state and then
> wake right back up because of the device_suspend(PMSG_SUSPEND)
> change.

So something is wrong with ACPI wakeup GPEs. It would hurt in
suspend-to-disk case, too.

> I won't call it impossible to resolve the problems, but the people

Good.

> So yes without a darn good argument as to why it should work.  I will
> go with the experimental evidence that it fails miserably and
> trivially because of semantic incompatibility and can therefore
> never be fixed.

I do not think any "semantic" issues exist. We need to pass detailed
info down to the drivers that care, and we need to fix all the bugs in
the drivers. That should be pretty much it.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
