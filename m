Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJYEZz>; Fri, 25 Oct 2002 00:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSJYEZz>; Fri, 25 Oct 2002 00:25:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:37537 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261277AbSJYEZz>;
	Fri, 25 Oct 2002 00:25:55 -0400
Message-ID: <3DB8C941.DEF1C069@digeo.com>
Date: Thu, 24 Oct 2002 21:32:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamesclv@us.ibm.com
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Kswapd madness in 2.4 kernels
References: <200210242026.13071.jamesclv@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2002 04:32:01.0894 (UTC) FILETIME=[76AFA060:01C27BDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cleverdon wrote:
> 
>    Andrea_Archangeli-inode_highmem_imbalance.patch    Type: text/x-diff

That's in -aa kernels, is correct and is needed.

>    Andrew_Morton-2.4_VM_sucks._Again.patch    Type: text/x-diff

hmm.  Someone seems to have renamed my nuke-buffers patch ;)

My main concern is that this was a real quickie; it does a very
aggressive takedown of buffer_heads.  Andrea's kernels contain a
patch which takes a very different approach.  See
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2/05_vm_16_active_free_zone_bhs-1

I don't think anyone has tried that patch in isolation though...

If nuke-buffers passes testing and doesn't impact performance then
fine.  A more cautious approach would be to use the active_free_zone_bhs
patch.  If that proves inadequate then add in the "read" part of nuke-buffers.
That means dropping the fs/buffer.c part.
