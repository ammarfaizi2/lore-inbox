Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSJ3D3B>; Tue, 29 Oct 2002 22:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSJ3D3B>; Tue, 29 Oct 2002 22:29:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:55220 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263333AbSJ3D3A>;
	Tue, 29 Oct 2002 22:29:00 -0500
Message-ID: <3DBF5372.901E3CB3@digeo.com>
Date: Tue, 29 Oct 2002 19:35:14 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
References: <Pine.LNX.4.44.0210291643520.1457-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 03:35:16.0159 (UTC) FILETIME=[5CC674F0:01C27FC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> Thanks to Andrew and John suggestions I coded another version of the
> sys_epoll patch ( 0.13 skipped ... superstition :) ). I won't send the
> patch to not waste bandwidth, the patch is available here :
> 
> http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff
> 
> Comments are welcome ...
> 

Looking good to me, Davide.  I think you've nailed everything there
except:

- Do we want to introduce new list macros, or change epoll a little
  to use the existing list manipulators (I think the latter)

- Do we keep the vmalloc, replace it with alloc_pages() or go all the
  way and remove the hash table?

  Seems that you're leaning toward the final option but either way,
  it would be best to get that vmalloc out of there - it's basically
  hit-or-miss for anything larger than a single page - for a really
  robust implementation it is best to avoid its use.
