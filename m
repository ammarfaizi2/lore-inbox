Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbUDSKK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbUDSKK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:10:27 -0400
Received: from tanthi.teneoris.com ([164.164.94.19]:40901 "EHLO
	tanthi.teneoris.com") by vger.kernel.org with ESMTP id S264340AbUDSKKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:10:20 -0400
Subject: alloc_pidmap() query
From: Amol Lad <amol@teneoris.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Teneoris
Message-Id: <1082369420.2308.6.camel@amol.teneoris.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Apr 2004 15:40:20 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 It seems in the alloc_pidmap() code (2.6), that for the first time when
the PIDs are allocated, the alternate entries in pidmap array is used.

Lets take an example,
    offset = pid & BITS_PER_PAGE_MASK;
    map = pidmap_array + pid / BITS_PER_PAGE;

  if pid == BITS_PER_PAGE, then we have
offset = 0;
map = pidmap_array[1];

as this is the first time allocation, so map->page == NULL,

Following code with get executed,

    if (!offset || !atomic_read(&map->nr_free)) {
next_map:
        map = next_free_map(map, &max_steps);
        if (!map)
            goto failure;
        offset = 0;
    }

This code will select pidmap_array[2] for pid selection even though no
pids are yet allocated from pidmap_array[1].

is this ok ?

please cc me
Amol




-- 
Linus's Law - Given enough eyeballs, all bugs are shallow.

