Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTAWJrl>; Thu, 23 Jan 2003 04:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbTAWJrl>; Thu, 23 Jan 2003 04:47:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:5276 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265065AbTAWJrk>;
	Thu, 23 Jan 2003 04:47:40 -0500
Date: Thu, 23 Jan 2003 01:56:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: ch@murgatroid.com, fbecker@intrinsyc.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.55-rmk1: user space lossage
Message-Id: <20030123015659.422e8179.akpm@digeo.com>
In-Reply-To: <15943.1043315303@passion.cambridge.redhat.com>
References: <000001c2c287$ffa8eef0$800b040f@bergamot>
	<15943.1043315303@passion.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2003 09:56:42.0573 (UTC) FILETIME=[BB40D7D0:01C2C2C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> /me blames akpm. :)

Linus did it!

diff -puN mm/filemap.c~generic_file_readonly_mmap-fix mm/filemap.c
--- 25/mm/filemap.c~generic_file_readonly_mmap-fix	2003-01-23 01:55:41.000000000 -0800
+++ 25-akpm/mm/filemap.c	2003-01-23 01:55:45.000000000 -0800
@@ -1312,7 +1312,6 @@ int generic_file_readonly_mmap(struct fi
 {
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
 		return -EINVAL;
-	vma->vm_flags &= ~VM_MAYWRITE;
 	return generic_file_mmap(file, vma);
 }
 #else

_

