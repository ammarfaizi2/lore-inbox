Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVEWXVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVEWXVC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEWXRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:17:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:8651 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261165AbVEWXJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:09:06 -0400
Message-ID: <4292628E.4090209@pobox.com>
Date: Mon, 23 May 2005 19:09:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: andystewart@comcast.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree
References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>
In-Reply-To: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
> 
>      Enable reads on Plextor 712-SA on 2.6.11.5
> 
> has been added to the -mm tree.  Its filename is
> 
>      enable-reads-on-plextor-712-sa-on-26115.patch
> 
> Patches currently in -mm which might be from andystewart@comcast.net are
> 
> enable-reads-on-plextor-712-sa-on-26115.patch

Andrew -- The use of the word 'hack' didn't trigger any response??

By hardcoding so much of the inquiry data, this patch -overwrites- valid 
inquiry data provided by the device, with generic data.  This patch 
makes generic the probe data that the SCSI layer -depends on to be 
different-.

Effectively you made one CD-ROM device work, killed all the others, and 
enabled an oops generator.

Good show.

Even if this patch worked, you still need to fix the following:

* Patch INQUIRY data -slightly- to fool the SCSI layer into working 
correctly.  This is what Andy's patch [poorly] attempts to address.
* Handling DRQ interrupts (early patch exists)
* Padding DMA data (50% patch exists)
* Fix error handling (patch exists)
* Fix all FIS-based drivers so that an error doesn't cause an oops
* Implement non-polled REQUEST SENSE error handling for FIS-based drivers

