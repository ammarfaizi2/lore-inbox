Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268179AbTBND7D>; Thu, 13 Feb 2003 22:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268181AbTBND7D>; Thu, 13 Feb 2003 22:59:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46514 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268179AbTBND7C>; Thu, 13 Feb 2003 22:59:02 -0500
Date: Thu, 13 Feb 2003 20:08:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: suparna@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>
cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
Message-ID: <23370000.1045195724@[10.10.2.4]>
In-Reply-To: <20030214085915.A1466@in.ibm.com>
References: <20030213161014.A14361@in.ibm.com>
 <m1heb8w737.fsf@frodo.biederman.org> <20030214085915.A1466@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We still are stopping all cpus on a panic.
> The difference is that we don't need to move to the boot cpu
> and do this from there, since the new kernel can deal with
> starting from any CPU.

The kernel always supported this - cpu IDs are dynamically assigned on
bootup ... and the boot cpu is always given number 0. There's nothing
magical about the boot CPU, it doesn't really matter which it is. The only
problem we had to fix last night was that the OS believes the BIOS mps
tables as to what the boot CPU is. It now just says ... "oh, I'm the boot
cpu  ... because I'm running this code".

This seems infinitely simpler and safer to me than trying to migrate
yourself around (potentially at panic time with a bad kernel). The only
thing that will be different is the *physical* apic id of the CPU, which
nothing uses after we boot anyway.

M.

