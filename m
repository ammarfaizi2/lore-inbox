Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310311AbSCBEZY>; Fri, 1 Mar 2002 23:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310315AbSCBEZO>; Fri, 1 Mar 2002 23:25:14 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:54170 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310311AbSCBEYz>; Fri, 1 Mar 2002 23:24:55 -0500
Date: Fri, 1 Mar 2002 21:39:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301213908.B13983@vger.timpanogas.org>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <20020301165104.C6778@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020301165104.C6778@beaverton.ibm.com>; from andmike@us.ibm.com on Fri, Mar 01, 2002 at 04:51:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We are going to sleep a lot in __get_request_wait().  This 
means the write queue has no free request blocks.  We are mostly writing 
to the adapter in this test case, and the data we are writing 
is already in order when it's posted.    

We are also posting via submit_bh() so you should trace 
that path.  I am seeing 22,000+ buffer heads posted concurrently
on each 3Ware card of 4K each with this application
on the patch for 2.4.19-pre2.  I will post the actual data
for you.  Stand by. 

These 3Ware cards are incredible. 

Jeff


On Fri, Mar 01, 2002 at 04:51:04PM -0800, Mike Anderson wrote:
> Jeff V. Merkey [jmerkey@vger.timpanogas.org] wrote:
> > 
> > ..snip..
> >
> > What is really needed here is to allow queue_nr_requests to be 
> > configurable on a per adapter/device basis for these high end 
> > raid cards like 3Ware since in a RAID 0 configuration, 8 drives
> > are in essence a terabyte (1.3 terrabytes in our configuration) 
> > and each adapter is showing up as a 1.3 TB device.  64/128
> > requests are simply not enough to get the full spectrum of 
> > performance atainable with these cards.
> > 
> Not having direct experience on this card it appears that increasing the
> queue_nr_requests number will not allow you to have more ios in flight.
> 
> Unless I am reading the driver wrong you will be limited to
> TW_MAX_CMDS_PER_LUN (15). This value is used by scsi_build_commandblocks
> to allocate scsi commands for your scsi_device. This driver does not provide
> a select_queue_depths function which allows for increase to the default
> template value. 
> 
> Could it be that the experimentation of increasing this number has
> allowed for better merging.
> 
> -Mike
> -- 
> Michael Anderson
> andmike@us.ibm.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
