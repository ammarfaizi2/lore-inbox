Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135936AbRDTOsp>; Fri, 20 Apr 2001 10:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135938AbRDTOsf>; Fri, 20 Apr 2001 10:48:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51717 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135936AbRDTOsX>; Fri, 20 Apr 2001 10:48:23 -0400
Subject: Re: RFC: pageable kernel-segments
To: venkateshr@softhome.net (Venkatesh Ramamurthy)
Date: Fri, 20 Apr 2001 15:49:30 +0100 (BST)
Cc: sct@redhat.com (Stephen C. Tweedie), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <040201c0c9a5$87d05c60$7253e59b@megatrends.com> from "Venkatesh Ramamurthy" at Apr 20, 2001 10:23:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qcE1-0001Pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> compared to the complexity that gets added to the kernel. We can keep the
> kernel simpler(and faster) without having parts of drivers pageable. But one
> more issue is having the page tables pageable.......

At the moment we can almost go a stage further - when we are short of memory
we can victimise apparently idle page tables by simply deleting them. What
stops us from doing this right now is handling anonymous pages where the
page table really is needed to find the swap entries.

There is a proposal (several it seems) to make 2.5 replace the conventional
unix swap with a filesystem of backing store for anonymous objects. That will
mean each object has its own vm area and inode and thus we can start blowing
away all user mode page tables when we want.

The primary reason for it however is to simplify all the code paths that deal
with swap. All the readahead becomes common code. Swap files become loopback
mounts. We can support multiple swap implementations (just pick your swap fs).
It also lays the groundwork for doing swap using spare disk space.

