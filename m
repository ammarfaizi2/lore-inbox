Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266872AbUAXGCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 01:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266873AbUAXGCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 01:02:40 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:19108 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266872AbUAXGC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 01:02:27 -0500
Subject: =?ISO-8859-1?Q?Re=B2?= : Alsa create high problems...
From: Eddahbi Karim <installation_fault_association@yahoo.fr>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0401230957131.1875@pnote.perex-int.cz>
References: <1074382859.29525.20.camel@gamux>
	 <1074839589.8684.1.camel@gamux>
	 <Pine.LNX.4.58.0401230936130.1875@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0401230957131.1875@pnote.perex-int.cz>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Installation Fault
Message-Id: <1074924064.3799.17.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jan 2004 07:01:04 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 23/01/2004 à 09:57, Jaroslav Kysela a écrit :
> On Fri, 23 Jan 2004, Jaroslav Kysela wrote:

> > Ok, let's go. Can you try which files exactly affects the playback?
> > If you find one file, can you remove code step-by-step from routines in 
> > linux/sound/core/pcm.c snd*read() functions (locate function by strings
> > in the proc file).
> > 
> > I suspect that snd_pcm_stream_lock_irq() and snd_pcm_stream_unlock_irq() 
> > will affect this (note that you must remove these calls together).
> 
> Also enabling CONFIG_DEBUG_SPINLOCK in your kernel setup might help us.
> 

Ok,

So... I've located the file which unlocks the problem while 1 second.
It's /proc/asound/card0/pcm0p/sub0/status.

The function in pcm.c is :
snd_pcm_substream_proc_status_read

I remove it from the routines, it doesn't settle the problem but it
removes /proc/asound/card0/pcm0p/sub0/status which let me without any
way to solve the sound problem anymore (unless kill :P).

I'll try to remove both lock/unlock irq functions and I'll tell you the
problem.

Btw I can't do any report from my kernel 2.6.2-rc1 because the ACPI
seems broken again and my modem don't work so I need to reboot on my
2.6.0 for reporting ;)

-- 
Eddahbi Karim <installation_fault_association@yahoo.fr>
Installation Fault

