Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUFCAME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUFCAME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 20:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUFCAME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 20:12:04 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:4992 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265399AbUFCALp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 20:11:45 -0400
Message-ID: <40BE6CA9.9030403@zytor.com>
Date: Wed, 02 Jun 2004 17:11:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <98460000.1086215543@dyn318071bld.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> This patch adds class support to arch/i386/kernel/cpuid.c. This enables udev
> support. I have tested on a 2-way SMP system and on a 2-way built as UP.
> Here are the results for the SMP:

I think it would be better if udev could handle /dev/cpu as an iterator 
instead of needing O(N) kernel memory for all per-CPU devices; I made the same 
comments about devfs.

As it is, it also mishandles the hotswap CPU scenario.

> [hlinder@w-hlinder2 hlinder]$ tree /sys/class/cpuid
> /sys/class/cpuid
> |-- cpu0
> |   `-- dev
> `-- cpu1
>     `-- dev
> 
> 2 directories, 2 files
> [hlinder@w-hlinder2 hlinder]$ more /sys/class/cpuid/cpu0/dev
> 203:0
> [hlinder@w-hlinder2 hlinder]$ more /sys/class/cpuid/cpu1/dev
> 203:1
> [hlinder@w-hlinder2 hlinder]$

	-hpa
