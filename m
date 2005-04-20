Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVDTL6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVDTL6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVDTL6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:58:06 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:61584 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261470AbVDTL5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:57:34 -0400
Message-ID: <426644DA.70105@jp.fujitsu.com>
Date: Wed, 20 Apr 2005 21:02:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>, hari@in.ibm.com
Subject: [RFC][PATCH] nameing reserved pages [0/3]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are several types of PG_reserved pages,
(a) Memory Hole
(b) Used by Kernel
(c) Set by drivers
(d) Isorated by MCA
(e) used by perfmon
etc....

I think it's useful to distinguish many types of PG_reserved pages.

For example, Memory Hotplug can ignore (a).

2 patches [1/3][2/3] are for naming PG_reserved pages.
A type of a page is recoreded in page->private.
I'm not sure whether this is safe or not, so only reserved-at-boot pages are named, currently.

patch [3/3] is an interface to show state of memmap, /dev/memstate.

In /dev/memstate, file offset is pfn and a byte represents a state of a page.
In this patch, memory hole and Reserved pages has its value.

below is output of my box.

0xff --- Invalid page
0x00 --- Common page
0x02 --- Reserved at boot page

[root@casares char]#  od  -t x1 -j 0 -N 65535 /dev/memstate
0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
*
0001540 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 02 02
0001560 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02
*
0002400 02 02 02 00 00 00 00 00 00 02 02 02 02 02 02 02
0002420 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02
*
0003400 02 02 02 02 02 02 02 02 02 02 02 00 00 00 00 00
0003420 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0010000 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02
*
0010640 02 02 02 02 02 02 02 02 02 02 02 02 02 02 00 00
0010660 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

This would be useful for Memory-Hotplug and some other stuffs.
I think more detailed types can be supported.

Thanks.
-- Kame <kamezawa.hiroyu@jp.fujitsu.com>

