Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281228AbRKMADi>; Mon, 12 Nov 2001 19:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKMAD2>; Mon, 12 Nov 2001 19:03:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:33232 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281228AbRKMADQ>; Mon, 12 Nov 2001 19:03:16 -0500
Message-ID: <3BF06316.46D48002@us.ibm.com>
Date: Mon, 12 Nov 2001 16:02:30 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]Disk IO statistics for all disks
In-Reply-To: <Pine.LNX.4.33.0111121401070.7555-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 12 Nov 2001, Mingming cao wrote:
> >
> > This is a patch to dynamically allocate the data buffers for the disk
> > statistics, and to extend the gathering of disk statistics to include
> > major numbers greater than 15.
> 
> I would suggest instead just moving the statistics into the request queue,
> at which point it should be nicely per-controller already, and quite
> independent of major numbers etc.
> 
> Oh, and it will be faster too, because you only need one lookup.
> 
>                 Linus
I saw your suggestions related to this about a year ago.  I like the
idea of doing statistics per-controller and getting rid of disk_index().
But by moving statistics into the request queue, under the current
implementation, we have to allocate statistics memory for every major,
since for every major there is a request_queue asscoiated with
it(blk_dev[MAX_BLKDEV]).  Do you care about this?  

-- 
Mingming Cao
IBM Linux Technology Center
503-578-5024  IBM T/L: 775-5024
cmm@us.ibm.com
http://www.ibm.com/linux/ltc
