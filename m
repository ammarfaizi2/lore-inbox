Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWDEK6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWDEK6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 06:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDEK6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 06:58:24 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37287 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751212AbWDEK6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 06:58:23 -0400
Date: Wed, 05 Apr 2006 19:57:08 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:000/004] wait_table and zonelist initializing for memory hotadd
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060405192737.3C3F.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These are parts of patches for new nodes addition v4.
I picked them up because v4 might be a bit too many patches.
These patches can be used even when a new zone becomes available.
When empty zone becomes not empty, wait_table must be initialized,
and zonelists must be updated.
So, They are a good group for once post.

  ex) x86-64 is good example of new zone addition.
      - System boot up with memory under 4G address.
        All of memory will be ZONE_DMA32.
      - Then hot-add over 4G memory. It becomes ZONE_NORMAL. But, 
        wait table of zone normal is not initialized at this time.

This patch is for 2.6.17-rc1-mm1.

Please apply.

----------------------------
Change log from v4 of hot-add.
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


