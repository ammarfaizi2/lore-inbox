Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUDHAqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUDHAqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:46:06 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:37003 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261273AbUDHAqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:46:03 -0400
Date: Wed, 7 Apr 2004 17:45:59 -0700
From: Libor Michalek <libor@topspin.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Roland Dreier <roland@topspin.com>, Eli Cohen <mlxk@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
Message-ID: <20040407174559.E11135@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OriginalArrivalTime: 08 Apr 2004 00:46:01.0189 (UTC) FILETIME=[DD398150:01C41D02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Manfred Spraul <manfred@colorfullife.com> -----
>
> Date:	Sun, 21 Mar 2004 12:31:59 +0100
> From: Manfred Spraul <manfred@colorfullife.com>
> To: Eli Cohen <mlxk@mellanox.co.il>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: locking user space memory in kernel
>
> Hi Eli,
>
> I think just get_user_pages() should be sufficient: the pages won't be 
> swapped out. You don't need to set VM_LOCKED in vma->vm_flags to prevent 
> the swap out. In the worst case, the pte is cleared a that will cause a 
> soft page fault, but the physical address won't change. Multiple 
> get_user_pages() calls on overlapping regions are ok, the page count is 
> an atomic_t, at least 24-bit large.

  The soft page fault is a problem if the device is going to write data 
into the buffer and then notify the user that the buffer now contains 
valid data. If the soft page fault occurs before the device has written
to the page list, once the user is notified of the write and reads the 
buffer, it will no longer be the same pages as the ones to which the 
device wrote. Is setting VM_LOCKED the only way to prevent the soft
page fault and this issue?


-Libor






