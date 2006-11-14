Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966461AbWKNX25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966461AbWKNX25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966465AbWKNX25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:28:57 -0500
Received: from elvis.mu.org ([192.203.228.196]:26110 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S966461AbWKNX25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:28:57 -0500
Message-ID: <455A512F.6030907@FreeBSD.org>
Date: Tue, 14 Nov 2006 15:28:47 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
Subject: [PATCH 0/1] Try 2: Make the TSC safe to be use by gettimeofday().
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the fixes from the previous version:
- Don't use hard_smp_processor_id().
- Use the PDA to store a pointer to the current CPU's vxtime data.
- Use vgetcpu() to get the CPU number from vgettimeofday()
  (Due to a bug in vgetcpu(), this only works with CONFIG_HOTPLUG_CPU=y)
- No externs in .c files
- Use idle notifiers instead of doing the HPET read in switch_to
- Fix race in vgettimeofday() by checking the RIP of the process we're switching away from
  in switch_to, and touching the vxtime seqlock if it happens to be in the VSYSCALL page.
  (I hope this is not considered too much work for switch_to)
- Remove usage of preempt_disable/enable() in do_gettimeoday(), since the above fix make it
  unnecessary.

-- Suleiman

