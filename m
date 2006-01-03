Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWACT1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWACT1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWACT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:27:30 -0500
Received: from bay101-f32.bay101.hotmail.com ([64.4.56.42]:59760 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932495AbWACT13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:27:29 -0500
Message-ID: <BAY101-F32BC19A49EC86F6FED361BDF2C0@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
In-Reply-To: <1136314722.22598.36.camel@localhost.localdomain>
From: "John Treubig" <jtreubig@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: raw@dslr.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Tue, 03 Jan 2006 13:27:28 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 03 Jan 2006 19:27:28.0972 (UTC) FILETIME=[BC2DA0C0:01C6109B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I receive this as great news, only I don't know where the -mm tree is 
located to see if I can get the patch or fix!  Can you give me a few 
pointers?!



From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Treubig <jtreubig@hotmail.com>
CC: raw@dslr.net, linux-ide@vger.kernel.org,linux-kernel@vger.kernel.org, 
linux-scsi@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Tue, 03 Jan 2006 18:58:42 +0000

On Maw, 2006-01-03 at 12:29 -0600, John Treubig wrote:
 > failure point.  I put a drive on the Secondary IDE bus hanging off the
 > motherboard Nvidia NForce 2 controller, began an access and pulled the 
plug.
 >   Sure enough the failures occured and were passed back to user level, 
but
 > the system did not hang.  I've repeated this a number of times.  I moved 
the
 > same drive to the Promise Controller and the hang occurs.  Thus it seems 
we
 > have proved the Promise sub-system is my problem.


Bingo. Yes I know why this is occuring now.

There is a known old bug with error handling in some cases on promise
chips. The core kernel code tries to clean up any remaining data after
an error (to handle chip prefetch/postwrite FIFOs) if DRQ_STAT is
asserted. Its a nice trick, saves on resets and slow recovery but isn't
compatible with some promise controllers.

The -mm tree has a partial but incomplete fix to this implemented, the
base kernel does not have this fixed.

Its been known for some time so perhaps the ide maintainers have patches
waiting for 2.6.16 now its opened ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


