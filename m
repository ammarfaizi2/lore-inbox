Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRFSKev>; Tue, 19 Jun 2001 06:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264053AbRFSKem>; Tue, 19 Jun 2001 06:34:42 -0400
Received: from cs.huji.ac.il ([132.65.16.10]:33995 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id <S264080AbRFSKe3>;
	Tue, 19 Jun 2001 06:34:29 -0400
Date: Tue, 19 Jun 2001 13:34:25 +0300 (IDT)
From: Yoav Etsion <etsman@cs.huji.ac.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Tsafrir Dan <dants@cs.huji.ac.il>
Subject: [BUG] bug in mmap_kmem
Message-ID: <Pine.LNX.4.20_heb2.08.0106191305060.1005-100000@pomela2.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem is that mmaping a segment <addr,len> from /dev/kmem gives
differnet results than reading the same <addr,len>.

It seems that the bug is that mmap_kmem is a macro for mmap_mem (for
/dev/mem).
mmap_mem maps a _physical_ offset into a vm area vma, while mmap_kmem
should map a _virtual_ offset into a vm area. 

I hacked it to work by copying mmap_mem to mmap_kmem and adding __pa() in
the proper assginment, but I don't know how to check if the offset is
valid in the kernel virtual memory. Maybe someone who knows the mm code
better can fix this?

Thanks,

Yoav Etsion

