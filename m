Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbTCQTPq>; Mon, 17 Mar 2003 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbTCQTPp>; Mon, 17 Mar 2003 14:15:45 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:15092 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S261862AbTCQTPo>; Mon, 17 Mar 2003 14:15:44 -0500
Message-ID: <3E762024.5010707@mvista.com>
Date: Mon, 17 Mar 2003 12:21:08 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org> <20030308214130.GK2835@ca-server1.us.oracle.com>
In-Reply-To: <20030308214130.GK2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could easily be supported by removing the requirement that 16 
minors are used per disk.  If instead, partition minors were dynamcially 
allocated and created by userspace policies (or devfs), many thousands 
of disks could be used in the current scheme (assuming they don't have a 
bunch of partitions).  I think it is unlikely anyone would actually use 
more then one partition in a big disk setup, but I could be wrong.   If 
only one minor were used per disk, 10k disks could easily be supported 
by the current dev_t.

Of course, the way block devices that represent disks register with the 
system would have to change, but the current waste of minors by devices 
that never exist is rediculous anyway.

Thanks
-steve

Joel Becker wrote:

>On Sat, Mar 08, 2003 at 07:43:31PM +0000, Christoph Hellwig wrote:
>  
>
>>So people should have started working on it sooner.  If people really think
>>they need a 32bit dev_t for their $BIGNUM of disks (and I still don't buy
>>that argument) we should just introduce it and use it only for block devices
>>(which already are fixed up for this) and stay with the old 8+8 split for
>>character devices.  Note that Linux is about doing stuff right, not fast.
>>    
>>
>
>	Wait, so ugly hacks that steal every remaining major is doing it
>'right'?  I've done the math with the current available majors.  I don't
>see 4000 disks there, and that is just life as it exists today, not 2-3
>years from now when 2.8 finally appears.  Like Andrew asked, please
>describe exactly how you'd support it.
>
>Joel
>
>
>  
>

