Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTK1Tin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTK1Th7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:37:59 -0500
Received: from smtp804.mail.ukl.yahoo.com ([217.12.12.141]:44374 "HELO
	smtp804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262015AbTK1ThM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:37:12 -0500
Message-ID: <3FC7A3D9.3070500@sbcglobal.net>
Date: Fri, 28 Nov 2003 13:36:57 -0600
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Goerzen <jgoerzen@complete.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise IDE controller crashes 2.4.22
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org>
In-Reply-To: <slrnbsche8.2ir.jgoerzen@christoph.complete.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd suspect some sort of PCI problem, especially since you're running a 
K6.  What chipset is your motherboard based on?

I'm running a K6-2 400 on an FIC PA2013 with two PDC20269 controllers 
and my primary drive is a 6Y060L0.  I've had no problem with writes in 
DMA mode locking the system in 2.4.22 or any of the test kernels.  I 
have a 92048D8 that doesn't like UDMA-2 writes, but that won't hang the 
system; it just causes Linux to continually reset the interface until 
the kernel finally disables DMA on the drive.  Oddly, UDMA-1 works fine 
but this is a drive to controller hardware issue and not the drivers 
fault. 

Anyway, since the kernel seems to handle a DMA write gone bad, that 
leads me to believe that this issue is caused by the increased data 
flowing over the PCI bus when using DMA vs using PIO.  I'm not an expert 
though, maybe someone else has an opinion on this?

You might try putting the card in another slot too.  My cards are 
installed in slots 1 & 2 with 2 other PCI cards and an ISA device.  This 
particular motherboard seems to handle a full complement of expansion 
cards without problem, but I remember hearing nightmares about such a 
configuration back when these things were new.

-Wes-

John Goerzen wrote:

>Hi,
>
>I have a Promise 20269-based UDMA 133 IDE controller.  If I have DMA
>enabled on this controller, then when it is seeing heavy write activity,
>the system freezes.  No messages on the console, ctrl-alt-del does
>nothing, magic sysrq does nothing.
>
>Reads do not appear to cause this problem, and the problem also
>disappears if I disable DMA on the drive connected to the controller by
>using hdparm.
>
>System information:
>Linux pi 2.4.22 #3 Sat Oct 25 15:45:50 CDT 2003 i586 GNU/Linux
>AMD K6 400MHz processor
>
>lspci:
>00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20269
>(rev 02)
>
>Drive: Maxtor 6Y160P0 150GB UDMA 133
>
>I have, in my .config:
>
>CONFIG_BLK_DEV_PDC202XX_NEW=y
>CONFIG_BLK_DEV_PDC202XX=y
>
>Thanks for any insight.
>
>-- John Goerzen
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

