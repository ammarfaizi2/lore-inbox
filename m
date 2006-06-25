Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWFYIvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWFYIvd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 04:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFYIvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 04:51:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35753 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751194AbWFYIvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 04:51:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
Date: Sun, 25 Jun 2006 10:51:55 +0200
User-Agent: KMail/1.9.3
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Chandra Seetharaman <sekharan@us.ibm.com>
References: <20060624061914.202fbfb5.akpm@osdl.org> <20060624172014.GB26273@redhat.com> <20060624143440.0931b4f1.akpm@osdl.org>
In-Reply-To: <20060624143440.0931b4f1.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200606251051.55355.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 June 2006 23:34, Andrew Morton wrote:
> On Sat, 24 Jun 2006 13:20:14 -0400
> Dave Jones <davej@redhat.com> wrote:
> 
> > On Sat, Jun 24, 2006 at 05:53:44PM +0200, Rafael J. Wysocki wrote:
> >  > On Saturday 24 June 2006 15:19, Andrew Morton wrote:
> >  > > 
> >  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/
> >  > 
> >  > The box seems to work, although I have some "interesting" stuff in dmesg:
> >  > 
> >  > int3: 0000 [1] PREEMPT
> >  > last sysfs file: /devices/pci0000:00/0000:00:0a.0/0000:02:00.0/subsystem_device
> >  > CPU 0
> >  > Modules linked in: acpi_cpufreq usbserial asus_acpi thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_seq snd_seqd
> >  > Pid: 4839, comm: modprobe Not tainted 2.6.17-mm2 #4
> >  > RIP: 0010:[<ffffffff806b0401>] <ffffffff806b0401>{cpufreq_register_driver+1}
> >  > RSP: 0018:ffff810052c59e40  EFLAGS: 00000292
> >  > RAX: 00000000ffffffea RBX: ffffffff8832a340 RCX: 00000000ffffffff
> >  > RDX: ffff8100567e3810 RSI: ffffffff883092cf RDI: ffffffff8832a2a0
> >  > RBP: ffff810052c59e48 R08: 0000000000000000 R09: 0000000000000001
> >  > R10: 0000000000000001 R11: 0000000000000001 R12: ffff8100545f4de0
> >  > R13: ffffffff8832a340 R14: ffffc20000af49b0 R15: ffff8100545f53a0
> >  > FS:  00002ae4d623db00(0000) GS:ffffffff80689000(0000) knlGS:0000000000000000
> >  > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> >  > CR2: 000000000051a680 CR3: 0000000054243000 CR4: 00000000000006e0
> >  > Process modprobe (pid: 4839, threadinfo ffff810052c58000, task ffff8100567e3810)
> >  > Stack: ffffffff880c808f ffff810052c59f78 ffffffff8024f14a ffffffff8832a390
> >  >        ffffffff8832a358 ffffffff8830e340 ffffc20000af4970 ffffc20000af43b0
> >  >        ffffc20000af4930 ffff8100531a5490
> >  > Call Trace: [<ffff810052c59f78>]
> >  > 
> >  > Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> >  > RIP <ffffffff806b0401>{cpufreq_register_driver+1} RSP <ffff810052c59e40>
> > 
> > 'something' filled this function with breakpoints.
> > Andrew mentioned he dropped the kgdb patches. Any chance something was missed?
> > 
> 
> My guess would be that cpufreq_register_driver() is being called after it
> has been unloaded from the kernel.
> 
> Do you have CONFIG_CPU_FREQ=y?

Yes.

> Does removal of the __cpuinit from cpufreq_register_driver() fix it (or
> move the crash elsewhere)?

Yes (makes it go away).

> Do you get any section mismatch warnings at build-time?

Only this one:
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0x1164) and 'acpi_processor_power_exit'

Greetings,
Rafael
