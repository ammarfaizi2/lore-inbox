Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbUCULcI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbUCULcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:32:08 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:20459 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263634AbUCULcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:32:06 -0500
Message-ID: <405D7D2F.9050507@colorfullife.com>
Date: Sun, 21 Mar 2004 12:31:59 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eli Cohen <mlxk@mellanox.co.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eli,

I think just get_user_pages() should be sufficient: the pages won't be 
swapped out. You don't need to set VM_LOCKED in vma->vm_flags to prevent 
the swap out. In the worst case, the pte is cleared a that will cause a 
soft page fault, but the physical address won't change. Multiple 
get_user_pages() calls on overlapping regions are ok, the page count is 
an atomic_t, at least 24-bit large.

--
    Manfred

