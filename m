Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVAIWhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVAIWhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVAIWhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:37:23 -0500
Received: from tim.rpsys.net ([194.106.48.114]:62149 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261896AbVAIWhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:37:16 -0500
Message-ID: <067d01c4f69b$cb9d8b80$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <007e01c4ef30$f23ba3c0$0f01a8c0@max> <1104674725.14712.50.camel@localhost.localdomain>
Subject: Re: Flaw in ide_unregister()
Date: Sun, 9 Jan 2005 22:37:20 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
[Re: ide_unregister and problems with ide-cs.c]
> In 2.6.9-ac and 2.6.10-ac the ide_unregister_hwif calls return an error
> if the drive is in use. At this point the ide-cs code still throws it
> away. The -ac code IDE also adds "removed_hwif_iops" so the bits are
> there for the correct result which is something like
>
> if(ide_unregister_hwif(hwif) < 0 {
> printk("Whine whine...");
> removed_hwif_ops(hwif);
> while(ide_unregister_hwif(hwif) < 0)
> msleep(1000);
> }

I've just tried 2.6.10-ac8 on my target (an arm PDA) and it doesn't help 
ide-cs.c. When I pull out a mounted CF out the socket, the kernel prints 
"Unregister 0 fail 1 0" repeatedly on the console showing the usage count 
permanently stays at 1. This is the same problem as under 2.6.10.

I haven't investigated it yet but I suspect the usage count is held by 
ide-disk as the CF card has a mounted filesystem. As previously mentioned 
and for reference, this patch has the changes I had to make to get standard 
2.6.10 to work:

http://www.rpsys.net/openzaurus/2.6.10/ide_fixes-r1.patch

Richard 



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.300 / Virus Database: 265.6.9 - Release Date: 06/01/2005

