Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318897AbSHMBSW>; Mon, 12 Aug 2002 21:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318898AbSHMBSV>; Mon, 12 Aug 2002 21:18:21 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:16543 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S318897AbSHMBSV>; Mon, 12 Aug 2002 21:18:21 -0400
Message-Id: <200208130131.g7D1VLIp000191@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 12 Aug 2002 21:31:20 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <3D57F5D6.C54F5A2A@zip.com.au> <Pine.LNX.4.33.0208121330310.1289-100000@penguin.transmeta.com> <3D5845FF.C6668B15@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5845FF.C6668B15@zip.com.au>; from akpm@zip.com.au on Mon, Aug 12, 2002 at 04:34:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> (Untested, uncompiled code)

More information.  With your patch I hit the BUG in kmem_cache_create
at slab.c line 673:

[inside kmem_cache_create]

	/*
	 * Sanity checks... these are all serious usage bugs.
	 */
	if ((!name) ||
		in_interrupt() ||
		(size < BYTES_PER_WORD) ||
		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
		(dtor && !ctor) ||
		(offset < 0 || offset > size))
			BUG();
-- 
Skip
