Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUDHGRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 02:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUDHGRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 02:17:13 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:28292 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S261631AbUDHGRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 02:17:11 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: libor@topspin.com
Subject: Re: locking user space memory in kernel
Date: Thu, 8 Apr 2004 16:20:11 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404081620.11051.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Michalek wrote: 
 
>----- Forwarded message from Manfred Spraul <manfred@colorfullife.com> ----- 
 > 
 > 
 >>Date: Sun, 21 Mar 2004 12:31:59 +0100 
 >>From: Manfred Spraul <manfred@colorfullife.com> 
 >>To: Eli Cohen <mlxk@mellanox.co.il> 
 >>Cc: linux-kernel@vger.kernel.org 
 >>Subject: Re: locking user space memory in kernel 
 >> 
 >>Hi Eli, 
 >> 
 >>I think just get_user_pages() should be sufficient: the pages won't be 
 >>swapped out. You don't need to set VM_LOCKED in vma->vm_flags to prevent 
 >>the swap out. In the worst case, the pte is cleared a that will cause a 
 >>soft page fault, but the physical address won't change. Multiple 
 >>get_user_pages() calls on overlapping regions are ok, the page count is 
 >>an atomic_t, at least 24-bit large. 
 >> 
 >> 
 > 
 > The soft page fault is a problem if the device is going to write data 
 >into the buffer and then notify the user that the buffer now contains 
 >valid data. If the soft page fault occurs before the device has written 
 >to the page list, once the user is notified of the write and reads the 
 >buffer, it will no longer be the same pages as the ones to which the 
 >device wrote. 
 > 

I know of an open source driver for image acquisition cards iti-fg that does
"PAGEWISE transfer of image frames directly into user space". The
release notes mention the memory locking.

It is available here
http://oss.gom.com/

Regards
Ross.

