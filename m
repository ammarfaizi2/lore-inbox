Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWDKLZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDKLZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWDKLZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:25:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15497 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750748AbWDKLZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:25:57 -0400
Date: Tue, 11 Apr 2006 20:25:22 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:000/005] wait_table and zonelist initializing for memory hotadd
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These are patches for initialization of wait_table and updating of zonelists
for memory hot-add.
These patches can be used when a new node/zone becomes available.
When empty zone becomes not empty by memory hot-add, 
wait_table must be initialized, and zonelists must be updated.

  ex) x86-64 is good example of new zone addition.
      - System boot up with memory under 4G address.
        All of memory will be ZONE_DMA32.
      - Then hot-add over 4G memory. It becomes ZONE_NORMAL. But, 
        wait table of zone normal is not initialized at this time.

This patch is for 2.6.17-rc1-mm2.

Please apply.

----------------------------
Change log from v1 of wait_table init and build_zonelist.
  - update for 2.6.17-rc1-mm2.
  - add comment for wait_table hash entries.
  - change name wait_table_size() -> wait_table_hash_nr_entries()

Change log from v4 of node hot-add.
  - wait_table and build_zonelists updating are picked up.
  - update for 2.6.17-rc1-mm1.
  - change allocation for wait_table from kmalloc() to vmalloc().
    vmalloc() is enough for it.

V4 of post is here.
<description>
http://marc.theaimsgroup.com/?l=linux-mm&w=2&r=1&s=memory+hotplug+node+v.4&q=b
<patches>
http://marc.theaimsgroup.com/?l=linux-mm&w=2&r=1&s=memory+hotplug+node+v.4.&q=b



-- 
Yasunori Goto 


