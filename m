Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFLT0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFLT0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFLTZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:25:52 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:26781 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262266AbVFLRnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:43:08 -0400
Subject: Re: Fwd: Re: Performance figure for sx8 driver
From: Kallol Biswas <kallol@nucleodyne.com>
Reply-To: kallol@nucleodyne.com
To: Mark Lord <liml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <42AC6310.7030809@rtr.ca>
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
	 <42AC6310.7030809@rtr.ca>
Content-Type: text/plain
Organization: NucleoDyne Systems Inc.
Message-Id: <1118598197.25250.20.camel@driver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Jun 2005 10:43:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been investigating what the cause of performance loss could be.

I have noticed several things:

0) Setting to CARM_MAX_Q to 30 hangs. So we have been testing only with
CARM_MAX_Q == 1. The firmware has not been updated yet.

1) If we keep on increasing number of SATA disks, hdparm does not get
multiplied total read performance (hdparm -t ....).

With a Maxtor 60 GB disk with 8MB cache we get 50Mb/sec. If we put
two disks we get 35 on each. Total  70MB/sec. If we put more
then total does not get above 70MB/sec.

It  looks like that a part of the driver serializes the commands.
We have a 32 processor MIPS based system.

2) It looks like that there is while(1) loop under spinlock in isr
stack. If we start queuing many commands then it may take a while for
this loop to break. Though I am not quite familiar with the driver yet.

If we set CARM_MAX_Q to 30 then the request/response queue length should
also be increased right?

3)  Next I will put PCI-X analyzer and figure  out the root cause of
performance loss. May be need to get hold of the technical manual.

Kallol

On Sun, 2005-06-12 at 09:30, Mark Lord wrote:
> kallol@nucleodyne.com wrote:
> > 
> > 
> > Hello Jeff,
> >            How did you verify that performance improved making the
> > changes those
> > you suggested?
> > 
> > hdparm does not show it.
> 
> My hdparm tool performs a single I/O at a time,
> disregarding any kernel read-ahead that may be added on.
> 
> As such, it won't often show the effects of queued commands
> as well as some other test might.
> 
> Cheers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

