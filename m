Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbTAWJkl>; Thu, 23 Jan 2003 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTAWJkl>; Thu, 23 Jan 2003 04:40:41 -0500
Received: from [213.86.99.237] ([213.86.99.237]:32498 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264702AbTAWJkk>; Thu, 23 Jan 2003 04:40:40 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <000001c2c287$ffa8eef0$800b040f@bergamot> 
References: <000001c2c287$ffa8eef0$800b040f@bergamot> 
To: "Christopher Hoover" <ch@murgatroid.com>
Cc: "'Frank Becker'" <fbecker@intrinsyc.com>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       "'linux-mtd'" <linux-mtd@lists.infradead.org>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.55-rmk1: user space lossage 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Jan 2003 09:48:23 +0000
Message-ID: <15943.1043315303@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 < Snip long thread about init segfaulting immediately at boot on 2.5.55 >

ch@murgatroid.com said:
> I just dropped jffs2 from 2.5.52 into 2.5.55 and it works, too.

ch@murgatroid.com said:
> Aha!  This is the problem: 
> -       .mmap =         generic_file_mmap,
> +       .mmap =         generic_file_readonly_mmap,
> If you reverese this change, 2.5.55-rmk1 behaves.

Er, yes. generic_file_readonly_mmap() silently removed the VM_MAYWRITE bit 
from vma->vm_flags when init made a _PRIVATE_ writable mapping, apparently 
on the basis that we have no writepage().

Then we return success anyway.

Then init segfaults when it touches something in that mapping.

/me blames akpm. :)

--
dwmw2


