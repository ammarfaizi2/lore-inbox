Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVCAMJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVCAMJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 07:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVCAMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 07:09:19 -0500
Received: from gprs215-195.eurotel.cz ([160.218.215.195]:46746 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261883AbVCAMI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 07:08:59 -0500
Date: Tue, 1 Mar 2005 13:08:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       barryn@pobox.com, marado@student.dei.uc.pt,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301120843.GN1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301015231.091b5329.akpm@osdl.org> <m1u0nvr5cn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u0nvr5cn.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In `subj` kernel, machine no longer powers down at the end of
> > >  swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
> > 
> > Binary searching indicates that this is due to
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/acpi_power_off-bug-fix.patch.
> > 
> > 
> > I'll drop it.  That patch is pretty ugly-looking anyway (ACPI code in
> > drivers/base/power/?).
> > 
> > Perhaps someone who is hitting the problem which that patch addresses could
> > raise a bugzilla entry.
> > 
> > Oh.  It has one.  http://bugme.osdl.org/show_bug.cgi?id=4041
> > 
> > Anyway.  It needs more work.
> 
> Agreed.
> 
> I threw it together to test a specific code path, and the fact it
> fails in software suspend is actually almost confirmation that I am on
> the right track.  This actually fixed the case I was testing.
> 
> In this case the failure is simply because system_state is
> not set to SYSTEM_POWER_OFF before
> kernel/power/disk.c:power_down() calls device_shutdown().
> The appropriate reboot notifier is also not called..

Can you suggest patch to do it right? Or perhaps there should be
just_plain_power_machine_down() that does all neccessary
trickery?
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
