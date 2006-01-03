Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWACS4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWACS4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWACS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:56:41 -0500
Received: from [81.2.110.250] ([81.2.110.250]:19884 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932484AbWACS4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:56:40 -0500
Subject: Re: ATA Write Error and Time-out Notification in User Space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Treubig <jtreubig@hotmail.com>
Cc: raw@dslr.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <BAY101-F1894F0927E1FB790D14772DF2C0@phx.gbl>
References: <BAY101-F1894F0927E1FB790D14772DF2C0@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 18:58:42 +0000
Message-Id: <1136314722.22598.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-03 at 12:29 -0600, John Treubig wrote:
> failure point.  I put a drive on the Secondary IDE bus hanging off the 
> motherboard Nvidia NForce 2 controller, began an access and pulled the plug. 
>   Sure enough the failures occured and were passed back to user level, but 
> the system did not hang.  I've repeated this a number of times.  I moved the 
> same drive to the Promise Controller and the hang occurs.  Thus it seems we 
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

