Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268242AbTBNIUn>; Fri, 14 Feb 2003 03:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268243AbTBNIUn>; Fri, 14 Feb 2003 03:20:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64040 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268242AbTBNIUm>; Fri, 14 Feb 2003 03:20:42 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: suparna@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
References: <20030213161014.A14361@in.ibm.com>
	<m1heb8w737.fsf@frodo.biederman.org> <20030214085915.A1466@in.ibm.com>
	<23370000.1045195724@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 01:30:35 -0700
In-Reply-To: <23370000.1045195724@[10.10.2.4]>
Message-ID: <m1adgz8dsk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > We still are stopping all cpus on a panic.
> > The difference is that we don't need to move to the boot cpu
> > and do this from there, since the new kernel can deal with
> > starting from any CPU.
> 
> The kernel always supported this - cpu IDs are dynamically assigned on
> bootup ... and the boot cpu is always given number 0. There's nothing
> magical about the boot CPU, it doesn't really matter which it is. The only
> problem we had to fix last night was that the OS believes the BIOS mps
> tables as to what the boot CPU is. It now just says ... "oh, I'm the boot
> cpu  ... because I'm running this code".
> 
> This seems infinitely simpler and safer to me than trying to migrate
> yourself around (potentially at panic time with a bad kernel). The only
> thing that will be different is the *physical* apic id of the CPU, which
> nothing uses after we boot anyway.

At panic time I agree that migration is a bad idea.  And the code looks
good for that case.  However for booting an arbitrary kernel that code needs
to be run on the original boot strap processor if at all possible.  As there
are kernels that cannot cope with booting up on the wrong cpu.

Eric

