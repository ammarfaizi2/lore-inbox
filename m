Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVI2GUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVI2GUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVI2GUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:20:49 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:46601 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751248AbVI2GUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:20:49 -0400
Date: Thu, 29 Sep 2005 08:20:48 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Ronis <David.Ronis@mcgill.ca>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: problem with 2.6.13.[0-2]
Message-Id: <20050929082048.0cca3f58.khali@linux-fr.org>
In-Reply-To: <1127957830.6261.5.camel@montroll.chem.mcgill.ca>
References: <Pine.WNT.4.63.0509272247550.2588@home-comp>
	<1127957830.6261.5.camel@montroll.chem.mcgill.ca>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

[David Ronis]
> In 2.6.12.6:
> 
> /dev/hda:
>  Timing cached reads:   1140 MB in  2.00 seconds = 569.80 MB/sec
>  Timing buffered disk reads:  102 MB in  3.02 seconds =  33.80 MB/sec
> 
> In 2.6.13.2:
> 
> /dev/hda:
>  Timing cached reads:    28 MB in  2.15 seconds =  13.03 MB/sec
>  Timing buffered disk reads:   14 MB in  3.30 seconds =   4.24 MB/sec
> 
> and after hdparm -m 16 /dev/hda (recall this is the default in 2.6.12.6)
> 
> /dev/hda:
>  Timing cached reads:    24 MB in  2.05 seconds =  11.73 MB/sec
>  Timing buffered disk reads:   36 MB in  3.11 seconds =  11.56 MB/sec
> 
> I ran thing a few times in each case and the results were close.  There
> was nothing in dmesg.

Try hdparm -i /dev/hda on both kernels, this will tell you the
controller/drive operation mode:

 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 * signifies the current active mode

I expect you to find that your IDE controller is in UDMA mode on
2.6.12.6 but not on 2.6.13.2. The figures you obtain for the latter
suggest mdma2 (those max throughput is 16 MB/sec IIRC) at best.

If I'm right, then you will have to find out which driver your IDE
controller uses, and why it decided that UDMA was no good for your
controller/driver combination. You may want to try the linux-ide list
for a more assistance, my own knowledge of that matter stops here ;)

-- 
Jean Delvare
