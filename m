Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVL3NXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVL3NXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVL3NXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:23:24 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:16030 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1751257AbVL3NXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:23:23 -0500
Date: Fri, 30 Dec 2005 14:23:19 +0100
Message-Id: <397463649@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: RobertHancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA burst delay
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What kind of PCI transaction is the core using to do the reads? I think 
>that Memory Read can cause bursts to be interrupted quickly on some 
>chipsets. If you can use Memory Read Line or Memory Read Multiple this 
>may increase performance.
>
>You may also need more buffering in the FPGA, otherwise you may be 
>vulnerable to underruns if there is contention on the PCI bus. The 
>device should be able to handle normal arbitration delays.

Yeah, that was it! I asked the programmer of the FPGA and he told me that he was using the normal Memory Read transaction. After changing that to MRM we get a much higher burst length. Now the buffer underruns really seem to be disappeared, that is great! He also told me that the fifo buffer on the FPGA could not be larger, because the size is somehow limited in the core (it's some special block ram I think...), so we are lucky that the burst length seems to fix our problem.

By the way, there is another question coming up to my mind. The pci card is to be designed for a large size copying machine (i.e. it is something like a framegrabber device which has to write out data to a printer simultaneously) which leads to really high bandwidth. For now I allocate the dma buffer in ram (a ringbuffer) using pci_alloc_consistent(), which unfortunately delimits the size to about 4 MB. However, it would be convenient to be able to allocate a larger dma buffer, because then we would be able to perform some image processing algorithms directly inside this buffer via mmapping it to user space. Is there any way to achieve this quite simple without being forced to use scatter/gather dma (our hardware is not able to do this - at least until now)?

Thank you very much for your help!

Kind regards,
Burkhard Schölpen

__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsstarkeren E-Mail-Postfach!		
Mehr Infos unter http://freemail.web.de/home/landingpad/?mc=021131

