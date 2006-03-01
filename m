Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWCAQzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWCAQzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWCAQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:55:22 -0500
Received: from bay104-f30.bay104.hotmail.com ([65.54.175.40]:3816 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751616AbWCAQzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:55:22 -0500
Message-ID: <BAY104-F30D83DE1A3392B1A69554DC0F40@phx.gbl>
X-Originating-IP: [137.207.140.83]
X-Originating-Email: [kamrankarimi@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0603011601360.11678@goblin.wat.veritas.com>
From: "Kamran Karimi" <kamrankarimi@hotmail.com>
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: why VM_SHM has been removed from mm.h?
Date: Wed, 01 Mar 2006 10:55:21 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Mar 2006 16:55:21.0876 (UTC) FILETIME=[ED8D0D40:01C63D50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's not obvious to me why the kernel would hang with an invalid pointer
>error message there: ipc_lock appears to have good safety against being
>passed a random id.  Perhaps the invalid pointer message comes from
>other code you've not shown (for example, I hope you shm_unlock(shp)
>and return 1 when shm_lock succeeds), or perhaps I'm misreading.

I have put printk() statements all over the place. The hang (which is during 
boot time) occurs within the block of code that I sent you. There is a 
shm_unlock() statement after the code, but it is never reached.

>Since you're already patching base kernel source (you mention
>arch/xyz/mm/fault.c), why don't you just patch your own VM_SYSVSHM
>into include/linux/mm.h, and set it on the vma in ipc/shm.c?

Yes this looks like a good solution. I have changed VM_SHM in mm.h to be 
0x0800000 and am looking for a good place to include it in the 
vma->vm_flags. shmat() looks like a good place. How can I find the vma of a 
SysV shm in that routine?

-Kamran


