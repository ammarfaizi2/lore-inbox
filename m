Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267275AbUGVU71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267275AbUGVU71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUGVU70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:59:26 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:3497 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267275AbUGVU7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:59:08 -0400
Message-ID: <41002ADB.6000408@colorfullife.com>
Date: Thu, 22 Jul 2004 23:00:11 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bucy <bucy@gloop.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: nvidia and rmap (again)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

>I don't quite know how to divine the right info out of slabinfo;
>I've attached it below.
>
If you search for a leak then you'd have to check the first number in 
each row: the number of active objects. Just look at the first row: it 
documents the fields in the following rows.
If a number is huge and constantly increasing, then there is would be a 
leak. Typically the inode, dentry and buffer_head caches are large, the 
rest are small.
But: slab manages only small objects. I assume that nvidia allocates 
pages with alloc_pages() and then plays with the page flags. This is the 
layer below slab, you must look at /proc/meminfo to detect leaks.

--
    Manfred

