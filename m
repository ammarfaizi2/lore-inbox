Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273132AbRI0Oro>; Thu, 27 Sep 2001 10:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273131AbRI0Ore>; Thu, 27 Sep 2001 10:47:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40557 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273115AbRI0Or1>; Thu, 27 Sep 2001 10:47:27 -0400
To: Bernd Harries <mlbha@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <356.1001580994@www46.gmx.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Sep 2001 08:38:37 -0600
In-Reply-To: <356.1001580994@www46.gmx.net>
Message-ID: <m1adzg66mq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Harries <mlbha@gmx.de> writes:

> Hi all,

> In a driver I'm writing, in the open() method, I use multiple 
> __get_free_pages() to allocate a 4 MB kernel (image)buffer for DMA purposes.
> The buffer I get is contiguous (I try until it is) and is freed in
> close(). Order count is 9.

Ouch.  This is where I give you the standard recommendation.  If you
do this scatter gatter (so you don't need megs of continuous memory)
you should be much better off, and your driver should be more
reliable.  All of the other techniques you have used like mmap should
still apply.

Also if you are exporting this data to user space, before your DMA
complets you want to zero the pages you have allocated, so you don't
have an information leak.

Eric

