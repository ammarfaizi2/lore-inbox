Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbTABTJu>; Thu, 2 Jan 2003 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTABTJu>; Thu, 2 Jan 2003 14:09:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:4304 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266377AbTABTJt>;
	Thu, 2 Jan 2003 14:09:49 -0500
Message-ID: <3E14906E.7F6D3226@digeo.com>
Date: Thu, 02 Jan 2003 11:18:06 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux-kernel@vger.kernel.org
Subject: Re: getblk spins endlessly in 2.4.19 SMP
References: <200301021747.h02Hlio19517@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 19:18:06.0979 (UTC) FILETIME=[AE0C8D30:01C2B293]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> get_blk() loops forever internally for in a sort piece of driver code of
> mine.

probably it found some buffers with the wrong ->b_size, tried to
get rid of them via try_to_free_buffers(), failed, and then fell
into the "oh, we're out of memory" loop.

You need to work out why grow_dev_page() is seeing buffers with
the wrong size against the page.  Be looking for incorrect or
missing calls to set_blocksize().
