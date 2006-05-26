Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWEZKXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWEZKXR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWEZKXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:23:17 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:5280 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751375AbWEZKXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:23:15 -0400
Date: Fri, 26 May 2006 19:23:07 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] ia64 node hotplug -- cpu - node relationship fix [0/2] intro
Cc: linux-ia64@vger.kernel.org, ashok.raj@intel.com, steiner@sgi.com,
       tony.luck@intel.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060526184011.EEAA.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. empty-node-fix : avoid creating empty node
>    SRAT's enable bit just shows 'you can read this entry'. But the kernel know
>    this and checks each entries are vaild or not later.
>
>    But pxm_bit/node_online_mask is not treated as they should be.
>    The kernel creates empty node, which has no cpu, no memory.

I would like to mention about background of this more.

I thought if enable bit of each SRAT entry is on, then its entry's
object is usable for OS.

However, SRAT specification says only
"If clear, the OSPM ignores the contents of the Processor Local
 APIC/SAPIC (or Memory) Affinity Structure."

So, our firmware team (or Micro $oft) interprets this
"If enable bit is on, then this entry is just readable by OS.
 The object of its entry MIGHT NOT EXIST. This entry can be used for
 reserve resource for memory/cpu which can be hot-add later."
They implemented it.

I really really hate this. :-(
But, indeed, ACPI spec. says just IGNORE if clear. They are correct.

Current linux code checks memory and cpu existence by other ways.
But, PXM remains even if they don't exist. The first patch is to remove it.

Bye.

-- 
Yasunori Goto 


