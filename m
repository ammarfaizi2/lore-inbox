Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310281AbSCBCpY>; Fri, 1 Mar 2002 21:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310283AbSCBCpP>; Fri, 1 Mar 2002 21:45:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:676 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310281AbSCBCoz>;
	Fri, 1 Mar 2002 21:44:55 -0500
Date: Fri, 1 Mar 2002 16:51:04 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301165104.C6778@beaverton.ibm.com>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Mar 01, 2002 at 01:22:54PM -0700
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey [jmerkey@vger.timpanogas.org] wrote:
> 
> ..snip..
>
> What is really needed here is to allow queue_nr_requests to be 
> configurable on a per adapter/device basis for these high end 
> raid cards like 3Ware since in a RAID 0 configuration, 8 drives
> are in essence a terabyte (1.3 terrabytes in our configuration) 
> and each adapter is showing up as a 1.3 TB device.  64/128
> requests are simply not enough to get the full spectrum of 
> performance atainable with these cards.
> 
Not having direct experience on this card it appears that increasing the
queue_nr_requests number will not allow you to have more ios in flight.

Unless I am reading the driver wrong you will be limited to
TW_MAX_CMDS_PER_LUN (15). This value is used by scsi_build_commandblocks
to allocate scsi commands for your scsi_device. This driver does not provide
a select_queue_depths function which allows for increase to the default
template value. 

Could it be that the experimentation of increasing this number has
allowed for better merging.

-Mike
-- 
Michael Anderson
andmike@us.ibm.com

