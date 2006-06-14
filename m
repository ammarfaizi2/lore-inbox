Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWFNMsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWFNMsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFNMsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:48:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:35645 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964900AbWFNMsT (ORCPT
	<rfc822;linux-Kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:48:19 -0400
Date: Wed, 14 Jun 2006 14:48:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: sena seneviratne <auntvini@cel.usyd.edu.au>
Cc: linux-Kernel@vger.kernel.org
Subject: Re: Introduce a New Metrics to measure Load average.
Message-ID: <20060614124816.GD11542@harddisk-recovery.com>
References: <5.1.1.5.2.20060614150410.0465ceb0@brain.sedal.usyd.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.1.5.2.20060614150410.0465ceb0@brain.sedal.usyd.edu.au>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 03:12:29PM +1000, sena seneviratne wrote:
> The  problem with the load metric of current Linux/Unix is that it measures 
> CPU load and Disk load without indicating the true nature of the load, 
> thereby creating some confusion among the readers. For example, if a CPU 
> bound task switches on to read a large chunk of disk data, then the load 
> average value would still continue to indicate this activity as a load, yet 
> the true CPU load during this period would have been zero.

Right, we've seen such things with busy servers.

> This situation 
> triggered us to make necessary additions to the kernel so that CPU load and 
> Disk load could be reported separately. Further the specialisation of load 
> helped our model to perform predictions when there is interference between 
> CPU and Disk IO loads.

OK.

> In the user mode, a new proc file called /proc/loadavgus would collect the 
> new data according to a new format which would look like the following,
> 
>                 CPU    Disk
> Root            0.7     0
> User1   0.9     1
> User2   0.9     0
> User3   1.03    1
> User4   0.93    0
> User5   1.0     0

The kernel doesn't know about user names, only uids. So the layout
should be something like:

		CPU	Disk
0		0.7	0
500		0.9	1
501		0.9	0

> What do you think about this change?

Why do you want to tell the load per user? Just the CPU and disk load
should be sufficient.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
