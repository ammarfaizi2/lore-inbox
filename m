Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbREHOy3>; Tue, 8 May 2001 10:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbREHOyT>; Tue, 8 May 2001 10:54:19 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:29325 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S132698AbREHOyI>;
	Tue, 8 May 2001 10:54:08 -0400
Date: Tue, 08 May 2001 15:54:05 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mark Hemment <markhe@veritas.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles 
Message-ID: <2523472481.989337245@[192.168.199.16]>
In-Reply-To: <Pine.LNX.4.21.0105081225520.31900-100000@alloc>
In-Reply-To: <Pine.LNX.4.21.0105081225520.31900-100000@alloc>
X-Mailer: Mulberry/2.1.0a5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The real fix is to measure fragmentation and the progress of kswapd, but
> that is too drastic for 2.4.x.

I suspect the real fix might, in general, be
a) to reduce use of kmalloc() etc. which gives
   physically contiguous memory, where virtually
   contiguous memory will do (and is, presumably,
   far easier to come by). (or perhaps add some
   flag to kmalloc to allocate out of virtual
   rather than physical memory).
b) to bias flush or swap out routines to create
   physically contiguous higher order blocks.
   Many heuristics will give you that ability.

Disclaimer: I haven't looked at this for issue for years,
but Linux seems to fail on >4k allocations now, and
fragment memory far more, than it did on much smaller
systems doing lots of nasty (8k, thus 3 pages including
header) NFS stuff back in 94.

--
Alex Bligh
