Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161462AbWHEFwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462AbWHEFwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 01:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161473AbWHEFwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 01:52:04 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36803 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161462AbWHEFwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 01:52:02 -0400
Date: Sat, 5 Aug 2006 14:51:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, discuss@x86-64.org,
       kmannth@us.ibm.com, ak@suse.de, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/10] hot-add-mem x86_64: acpi motherboard fix
Message-Id: <20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 07:13:51 -0600
Keith Mannthey <kmannth@us.ibm.com> wrote:
> I have worked to integrate the feedback I recived on the last round of patches
> and welcome more ideas/advice. Thanks to everyone who has provied input on
> these patches already. 
> 
Just from review...

If new zone , which was empty at boot, are added into the system.
build_all_zonelists() has to be called. (see online_pages() in memory_hotplug.c)
it looks x86_64's __add_pages() doesn't calles it.

Precisely, look online_pages() (CCONFIG_MEMORY_HOTPLUG_SPARSE) 
==
       setup_per_zone_pages_min();

        if (need_zonelists_rebuild)
                build_all_zonelists();
        vm_total_pages = nr_free_pagecache_pages();
==
These 3 calls are necessary, I think.

-Kame

