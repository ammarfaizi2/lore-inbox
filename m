Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSBOQob>; Fri, 15 Feb 2002 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290125AbSBOQoW>; Fri, 15 Feb 2002 11:44:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64493 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290113AbSBOQoJ>; Fri, 15 Feb 2002 11:44:09 -0500
Date: Fri, 15 Feb 2002 08:43:33 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support
Message-ID: <20020215084333.A1527@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Jens Axboe <axboe@suse.de>, Chris Mason <mason@suse.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <axboe@suse.de> <200202151515.g1FFFw801733@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200202151515.g1FFFw801733@localhost.localdomain>; from James.Bottomley@SteelEye.com on Fri, Feb 15, 2002 at 10:15:58AM -0500
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley [James.Bottomley@SteelEye.com] wrote:
> James.Bottomley@steeleye.com said:
> 
> Unfortunately, this is going to involve deep hackery inside the error handler. 
>  The current initial premise is that it can simply retry the failing command 
> by issuing an ABORT to the tag and resending it (which can cause a tag to move 
> past your barrier).  In an error situation, it really wouldn't be wise to try 
> to abort lots of potentially running tags to preserve the barrier ordering 
> (because of the overload placed on a known failing component), so I think the 
> error handler has to abandon the concept of aborting commands and move 
> straight to device reset.  We then carefully resend the commands in FIFO order.
> 
> Additionally, you must handle the case that a device is reset by something 
> else (in error handler terms, the cc_ua [check condition/unit attention]).  
> Here also, the tags would have to be sent back down in FIFO order as soon as 
> the condition is detected.

I agree on the hacker. You also will need to clean the pipe of the unit
attention post the reset or the first command you send down will
be coming right back into the error handler and could get you in to a
error recovery storm.


> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Michael Anderson
andmike@us.ibm.com

