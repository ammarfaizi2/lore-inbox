Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWGZAgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWGZAgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGZAgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:36:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47786 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932507AbWGZAgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:36:09 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44C6B881.7030901@s5r6.in-berlin.de>
Date: Wed, 26 Jul 2006 02:34:09 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, greg@kroah.com,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC PATCH] Multi-threaded device probing
References: <20060725203028.GA1270@kroah.com>
In-Reply-To: <20060725203028.GA1270@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> During the kernel summit, I was reminded by the wish by some people to
> do device probing in parallel, so I created the following patch.  It
> offers up the ability for the driver core to create a new thread for
> every driver<->device probe call.
...

Just FYI:

1.) SCSI:
There is a patch circulating at linux-scsi which adds parallelized bus 
scanning to the SCSI subsystem. I believe this cannot be built upon 
parallelization by driver core. But I am not too familiar with the 
subsystem facilities which this patch expands on. The patch is from 
Matthew Wilcox, titled "Asynchronous target discovery". 
http://marc.theaimsgroup.com/?t=115349750400001

2.) IEEE 1394:
There was brief preliminary discussion of parallelized probing for the 
ieee1394 subsystem at linux1394-devel. Using driver core's 
parallelization would achieve about 1/3rd of what would be desirable. 
Background: After each bus reset, the 1394 core (nodemgr) has to 
download part or all of the configuration ROM of attached devices to 
determine their identity and capabilities. After that, either a protocol 
driver probe (generic device hook), a protocol driver remove or suspend 
routine (generic device hook), or a protocol driver update routine 
(extra 1394 subsystem hook) is executed; depending on whether nodes were 
added, removed, or in-use nodes were rediscovered. --- I.e. we better 
have these subthreads provided by ieee1394/nodemgr itself.
-- 
Stefan Richter
-=====-=-==- -=== ==-=-
http://arcgraph.de/sr/
