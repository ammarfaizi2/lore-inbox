Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTJGWOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTJGWOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:14:24 -0400
Received: from bcsii.com ([67.114.178.171]:18336 "EHLO mail.bcsii.com")
	by vger.kernel.org with ESMTP id S262894AbTJGWOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:14:21 -0400
Message-ID: <3F833B9A.3080800@bcsii.net>
Date: Tue, 07 Oct 2003 15:18:02 -0700
From: Andriy Rysin <arysin@bcsii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, sct@redhat.com,
       Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ext3 crash with 2.4.22: Assertion failure in journal_forget_R10d91946()
References: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>Andriy, 
>
>On Thu, 2 Oct 2003, Andriy Rysin wrote:
>
>  
>
>>I am having crashes on ext3 with 2.4.22 kernel. System was up for 8 
>>days. I am not sure I can reproduce it real quick but we've seen it 
>>occasionly on 2.4.20 for about several months and after we updated to 
>>2.4.22 it's here again.
>>
>>please CC me if you answer or need more information.
>>
>>
>>the log looks like this:
>>
>>Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
>>ext3_free_blocks: Freeing blocks not in datazone - bloc
>>k = 2907885836, count = 1
>>Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
>>ext3_free_blocks: Freeing blocks not in datazone - bloc
>>k = 1660415916, count = 1
>>Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
>>ext3_free_blocks: Freeing blocks not in datazone - bloc
>>k = 1438298218, count = 1
>>Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
>>ext3_free_blocks: Freeing blocks not in datazone - bloc
>>k = 4209573569, count = 1
>>Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
>>ext3_free_blocks: Freeing blocks not in datazone - bloc
>>k = 2918065562, count = 1
>>......
>>Sep 29 21:05:18 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
>>ext3_free_blocks: bit already cleared for block 5970190
>>......
>>Oct  2 00:43:53 dunne-demo kernel: hda: dma_timer_expiry: dma status == 0x20
>>Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
>>Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
>>Oct  2 00:43:53 dunne-demo kernel: hda: (__ide_dma_test_irq) called 
>>    
>>
>
>You are getting DMA timeouts and such. Try turning off the DMA.
>
>But anyway the ext3 fs errors shouldnt happen I guess. Andrew, Stephen?
>  
>
If I turn DMA off the system won't be able handle the load we need. This 
problem happens under heavy load on different machines. It seems like 
IBM and WDC drives give DMA errors while Maxtor don't. But DMA problems 
are not quite related to the filesystem problems. On several systems we 
had the same ext3 problem while not observing any DMA errors 
(particularly Maxtor case). I doubt all those drives are faulty.

I may add that nature of our application is writing media data files in 
cycle manner. When filsystem gets close to full the script deletes 
oldest files. Usual filesystem size is about 80G, file sizes range from 
several kilos to 1.5G with average about several megs. The system can 
simultaniously write up to 32 files and deletion happens in parallel. 
Usual high load for the systems is about 4-5MB/s on writing reported by 
sar -b (not much for reading ~ 300KB/s).
Also what interesting is that DMA errors happen mostly at pretty low 
load on disk ~400KB/s.

A week ago I replaced ext3 with jfs on 3 systems and till now don't get 
any DMA or filesystem errors. I even was loading those systems with 
scripts constantly copying directory with ~4G of files and removing it 
for about 4-5 hours (avg loag by sar was 13MB/s for reading and 15MB/s 
for writing) and still did not get any problems.
So it seems like it's not the fault of the drives. I am still curious if 
jfs somehow puts less load on the drive not causing any DMAs but I'd 
like to spend couple of more weeks testing before claiming that.


Andriy





