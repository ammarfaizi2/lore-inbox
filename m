Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWBIEjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWBIEjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWBIEjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:39:45 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:59584 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1422794AbWBIEjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:39:45 -0500
Message-ID: <43EAC78E.8000908@cosmosbay.com>
Date: Thu, 09 Feb 2006 05:39:42 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@g5.osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <200602051959.k15JxoHK001630@hera.kernel.org> <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel a écrit :
> On Sun, 5 Feb 2006, Linux Kernel Mailing List wrote:
> 
>> [PATCH] percpu data: only iterate over possible CPUs
> 
> This sched.c bit breaks Xen, and probably also other architectures
> that have CPU hotplug.  I suspect the reason is that during early 
> bootup only the boot CPU is online, so nothing initialises the
> runqueues for CPUs that are brought up afterwards.
> 
> I suspect we can get rid of this problem quite easily by moving
> runqueue initialisation to init_idle()...

Please fix Xen to match include/linux/cpumask.h documentation that says :

/*
  * The following particular system cpumasks and operations manage
  * possible, present and online cpus.  Each of them is a fixed size
  * bitmap of size NR_CPUS.
  *
  *  #ifdef CONFIG_HOTPLUG_CPU
  *     cpu_possible_map - all NR_CPUS bits set
  *     cpu_present_map  - has bit 'cpu' set iff cpu is populated
  *     cpu_online_map   - has bit 'cpu' set iff cpu available to scheduler
  *  #else
  *     cpu_possible_map - has bit 'cpu' set iff cpu is populated
  *     cpu_present_map  - copy of cpu_possible_map
  *     cpu_online_map   - has bit 'cpu' set iff cpu available to scheduler
  *  #endif
  */



Eric
