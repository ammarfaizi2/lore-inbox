Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262216AbSIZHHr>; Thu, 26 Sep 2002 03:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSIZHHr>; Thu, 26 Sep 2002 03:07:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:24795 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262216AbSIZHHb>;
	Thu, 26 Sep 2002 03:07:31 -0400
Message-ID: <3D92B369.7AFD28D4@digeo.com>
Date: Thu, 26 Sep 2002 00:12:41 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 07:12:42.0136 (UTC) FILETIME=[1ABD1180:01C2652C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> I'll test scsi now.
> 

aic7xxx, Fujitsu "MAF3364L SUN36G" (36G SCA-2)


Maximum number of TCQ tags=253

	fifo_batch		time cat kernel/*.c (seconds)
	    64				58
	    32				54
	    16				20
	     8				58
	     4				1:15
	     2				53

Maximum number of TCQ tags=4

	fifo_batch		time cat kernel/*.c (seconds)
	    64				53
	    32				39
	    16				33
	     8				21
	     4				22
	     2				36
	     1				22


Maximum number of TCQ tags = 0:

	fifo_batch		time cat kernel/*.c (seconds)
	    64				22
	    32				10.3
	    16				10.5
	     8				5.5
	     4				3.2
	     2				1.9

I selected fifo_batch=16 and altered writes_starved and read_expires
again.  They made no appreciable difference.

>From this I can only conclude that my poor little read was stuck
in the disk for ages while TCQ busily allowed new incoming writes
to bypass already-sent reads.

A dreadful misdesign.  Unless we can control this with barriers,
and if Fujutsu is typical, TCQ is just uncontrollable.  I, for
one, would not turn it on in a pink fit.
