Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbSJLBUU>; Fri, 11 Oct 2002 21:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbSJLBUT>; Fri, 11 Oct 2002 21:20:19 -0400
Received: from packet.digeo.com ([12.110.80.53]:51689 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262590AbSJLBUT>;
	Fri, 11 Oct 2002 21:20:19 -0400
Message-ID: <3DA77A20.2D28DBE7@digeo.com>
Date: Fri, 11 Oct 2002 18:25:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Mueller <robm@fastmail.fm>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2002 01:25:56.0853 (UTC) FILETIME=[506ED250:01C2718E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Mueller wrote:
> 
> Filesystem is ext3 with one big / partition (that's a mistake
> we won't repeat, but too late now). This should be mounted
> with data=journal given the kernel command line above, though
> it's a bit hard to tell from the dmesg log:
> 

It's possible tht the journal keeps on filling.  When that happens,
everything has to wait for writeback into the main filesystem.
Completion of that writeback frees up journal space and then everything
can unblock.

Suggest you try data=ordered.
