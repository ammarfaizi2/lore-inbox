Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268841AbTBZRHw>; Wed, 26 Feb 2003 12:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268843AbTBZRHv>; Wed, 26 Feb 2003 12:07:51 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51687 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268841AbTBZRG5>; Wed, 26 Feb 2003 12:06:57 -0500
Date: Wed, 26 Feb 2003 09:18:57 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
Message-ID: <20030226171857.GA1134@beaverton.ibm.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20030224120304.A29472@beaverton.ibm.com> <20030224135323.28bb2018.akpm@digeo.com> <20030224174731.A31454@beaverton.ibm.com> <20030224204321.5016ded6.akpm@digeo.com> <20030225112458.A5618@beaverton.ibm.com> <20030226004454.2bfd8deb.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226004454.2bfd8deb.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton [akpm@digeo.com] wrote:
> 
> > It would be nice if a larger queue depth did not kill performance.
> 
> Does the other qlogic driver exhibit the same thing?

Well the qlogic provided driver should exhibit slightly different
behavior as its per device queue depth is 16 and the request ring count
is 128.

The feral driver is currently running a per device queue of 63 and a
request ring size of 64. (if I am reading the driver correctly?). When
the request count is exceeded I believe it should return a 1 to the call
of queuecommand. Can you tell if scsi_queue_insert is being called.

> > The larger queue depths can be nice for disk arrays with lots of cache and
> > (more) random IO patterns.
> 
> So says the scsi lore ;)  Have you observed this yourself?  Have you
> any numbers handy?

I do not have current numbers but you need to get the command on the
wire to get any benefit.

-andmike
--
Michael Anderson
andmike@us.ibm.com

