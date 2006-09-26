Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWIZVqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWIZVqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWIZVqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:46:11 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:57265 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964845AbWIZVqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:46:09 -0400
Message-ID: <45199F92.106@cs.wisc.edu>
Date: Tue, 26 Sep 2006 16:45:54 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Andrew Morton <akpm@osdl.org>, Martin Peschke <mp3@de.ibm.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [Patch] SCSI I/O statistics
References: <1159286194.2925.5.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060926103930.471b75a5.akpm@osdl.org> <20060926182347.GH5017@parisc-linux.org>
In-Reply-To: <20060926182347.GH5017@parisc-linux.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Tue, Sep 26, 2006 at 10:39:30AM -0700, Andrew Morton wrote:
>> - Should it have been done at the block layer rather than at the scsi layer?
> 
> This was already mentioned when he sent it to linux-scsi a few days ago.
> There are scsi commands which bypass the block layer, such as SG_IO, and


I do not think any command completely bypasses the block layer now.
SG_IO, tape, sd and scanning insertion go through blk_execute_rq_nowait
for insertion. For completion they go through blk_complete_request +
end_that_request_first/last in the normal path and blk_complete_request
+ blk_requeue_request in the retry path.


> block layer stats can make an extremely busy disc look not busy.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

