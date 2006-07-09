Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWGIOyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWGIOyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWGIOyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:54:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:28069 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932479AbWGIOyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:54:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44B11861.3070703@s5r6.in-berlin.de>
Date: Sun, 09 Jul 2006 16:53:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: memory barriers and dma_sync_single_for_*
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.014) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a memory area which is written by the CPU and concurrently read 
by a DMA capable device, multiple times.

Among else there are two fields in the memory area, both are 32 bits 
wide. Whenever the CPU updates the fields, I have to make sure that the 
device does not get to see a new value in field B before I updated field 
A. Conversely, it is safe to update field A anytime before field B. The 
driver has no way to know when the device is going to read any of the 
fields.

My question: Do I need wmb() within the following code?

	dma_sync_single_for_cpu(..., DMA_TO_DEVICE);
	area->a = new_val_a;
	wmb();  /* necessary? */
	area->b = new_val_b;
	dma_sync_single_for_device(..., DMA_TO_DEVICE);

Or are all changes to the area hidden from the device between 
dma_sync_single_for_cpu and _for_device, thereby making the write order 
a non-issue? Thanks,
-- 
Stefan Richter
-=====-=-==- -=== -=--=
http://arcgraph.de/sr/
