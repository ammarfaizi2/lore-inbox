Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTBGCWQ>; Thu, 6 Feb 2003 21:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbTBGCWQ>; Thu, 6 Feb 2003 21:22:16 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:56653 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S267387AbTBGCWQ>;
	Thu, 6 Feb 2003 21:22:16 -0500
Date: Thu, 6 Feb 2003 18:25:02 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <20030206182502.A16364@beaverton.ibm.com>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com> <293060000.1044583265@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <293060000.1044583265@[10.10.2.4]>; from mbligh@aracnet.com on Thu, Feb 06, 2003 at 06:01:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 06:01:06PM -0800, Martin J. Bligh wrote:
> 
> Curious. I've no idea why the changes brought this out then ... I've done
> hundreds and hundreds of reboots on 2.5 on all sorts of different kernels,
> and never, ever seen this. Yet in 2.5.59-bk I see it every single time.
> Very odd.
> 
> M.

Okay:

There were some bk scsi changes that ignored the queue depth (qlogicisp
sets them all to one). 

Current bk (I just pulled and checked) has a fix, the cleaner shinier 
better scsi_lib.c scsi_request_fn now has this code:

	if (sdev->device_busy >= sdev->queue_depth)
		break;

So the oops has to do with the isp handling multiple requests in a row or
in quick succession.

Hopefully going to the latest bk will fix your oops.

-- Patrick Mansfield
