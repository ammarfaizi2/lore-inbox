Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTCFAdt>; Wed, 5 Mar 2003 19:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTCFAdt>; Wed, 5 Mar 2003 19:33:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267106AbTCFAds>;
	Wed, 5 Mar 2003 19:33:48 -0500
Subject: Re: Kernel Boot Speedup
From: Andy Pfiffer <andyp@osdl.org>
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046911465.29868.46.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 05 Mar 2003 16:44:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 16:19, Ro0tSiEgE LKML wrote:
> What are some things I can change/disable/etc. to cut down the boot time
> of the kernel (i386) ? I would like to get one to boot in a couple
> seconds, tops. Is this possible, and how?

To get to that kind of boot-up speed, the best way is to never shutdown.

On a StrongArm platform I worked on, we managed to put the CPU to sleep
and the DRAM controller into self-refresh mode and a few other
housekeeping chores (like checksumming our saved CPU state to be able to
verify it on resumption), and could spring back to life with the press
of a power button in about the same amount of time it took for the
cold-cathode back-light to warm up enough to see the built-in screen.

On a modern laptop, it may be possible, in theory, to accomplish the
same kind of thing.  The key is to be able to not lose the contents of
memory.  I'm not well versed on current state-of-the-art
power-management on commodity x86 platforms, so your mileage may vary.

If you want cold-start boot on a PC, you'll probably need to completely
skip the BIOS (have a look at LinuxBIOS and/or kexec), skip the probing
of devices on reboot, and drastically shorten (or run later) any
user-mode scripts that are invoked.

On the machines that I have measured (p3-800 and p4-1.7Xeon, a
well-configured kernel, after subtracting out BIOS time and stupid scsi
reprobing, is up and open for business in about 10 seconds after the
LILO handoff.  The *system* however, isn't often available for another
30 or 40 seconds, perhaps longer.

Andy


