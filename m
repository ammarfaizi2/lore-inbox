Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311575AbSCTFxI>; Wed, 20 Mar 2002 00:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311579AbSCTFw7>; Wed, 20 Mar 2002 00:52:59 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:14135 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S311582AbSCTFwp>; Wed, 20 Mar 2002 00:52:45 -0500
Message-ID: <010101c1cfd3$8a87cfd0$1a02a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "chiranjeevi vaka" <cvaka_kernel@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.l19uvvv.1hjmo8t@ifi.uio.no>
Subject: Re: using kmalloc
Date: Wed, 20 Mar 2002 00:53:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am getting some problems with kmalloc. If I tried to
> allocate more than certain memory then the system is
> hanging while booting with the changed kernel. Can you
> suggest me how to come out this situation. Can't I
> allocate as much I want when I want to allocate in the
> kernel.

kmalloc() allocates physically-contiguous pages of memory. Due to
fragmentation, more than 64KB-128KB of contiguous pages might not be
available, and hence kmalloc() will fail.

To allocate more memory, use vmalloc(), which allocates and maps physically
disjoint pages into a virtually-contiguous region. Be careful when doing DMA
to a vmalloc() area, since it is not physically contiguous and exists only
in the kernel's virtual memory map... Also I believe vmalloc()ed memory is
only accessible from (the context of) the process in which it was allocated
(?).

Regards,
Dan

