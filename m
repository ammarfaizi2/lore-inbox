Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbUDGQPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbUDGQPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:15:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263719AbUDGQPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:15:00 -0400
Message-ID: <407428F3.90004@pobox.com>
Date: Wed, 07 Apr 2004 12:14:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: alpm@odsl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6.6xxx [1/2]
References: <20040406201030.GB2554@beardog.cca.cpqcorp.net>
In-Reply-To: <20040406201030.GB2554@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
> This patch adds per logical device queues to the HP cciss driver. It currently only implements a single lock but when time permits I will provide that funtionality. Thanks to Jeff Garzik for providing some sample code.
> This patch built against 2.6.5. Please consider this for inclusion.


I appreciate the credit but I don't see that it addressed my original 
objection -- the starvation issue.

Do you cap the number of per-array requests a "1024 / n_arrays", or 
something like that?  You mentioned that the hardware has a maximum of 
1024 outstanding commands, for all devices.  The two typical solutions 
are a round-robin queue (see carmel.c) or limiting each array such that 
if all arrays are full of commands, the total outstanding never exceeds 
1024.

This patch may be OK for -mm, I would rather not see it go upstream -- 
it seems to me you are choosing to decrease stability to obtain a 
performance increase.  I think you can increase performance without 
decreasing stability.

	Jeff



