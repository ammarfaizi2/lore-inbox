Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbTGHXtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267970AbTGHXtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:49:18 -0400
Received: from vopmail.neto.com ([209.223.15.78]:54288 "EHLO vopmail.neto.com")
	by vger.kernel.org with ESMTP id S267967AbTGHXtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:49:16 -0400
Message-ID: <3F0B5C6E.2070303@neto.com>
Date: Tue, 08 Jul 2003 19:06:06 -0500
From: John T Copeland <johnc@neto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030315
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxkernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre H <andre@linux-ide.org>
Subject: 2.4.21 & 2.5.74 -- SATA/UDMA not set at boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both kernels 2.4.21 and 2.5.74 leave the SATA drive in PIO mode after 
boot.  My system is Abit NF7-S with 2 IBM 100MHz parallel drives on 
IDE0, and 1 Western Digital 150 serial on IDE2.

NOTE: My boot drive in this case is the serial drive, and the parallel 
drives are auxiliaries.

The 2 parallel drives come up dma on, udma5 marked(hdparm /dev/hde and 
hdparm -i /dev/hde).  The serial drive of course is dma off, nothing 
marked.  There is no way to turn on DMA in the BIOS.

2.5.74 allows me to execute "hdparm -d1 -Xudma6 /dev/hde" while booting 
from a bootmisc.sh script.  If I try the same thing with 2.4.21 I get 
all kinds of errors, timeouts, other stuff and the EXT3 journal finally 
aborts and shutdown gives I/O errors.  I found out by trial and error 
that if I execute with 2.4.21:
1)hdparm -Xudma6 /dev/hde      This AOK, udma6 is on(marked)
2)hdparm -d1 /dev/hde               Some errors show up, dma is set, but 
udma6 is turned off(no mark)
3)hdparm -Xudma6 /dev/hde       udma6 back on(marked)
A hdparm -t /dev/hde verifies udma6 on and working.

Another point.  When my boot drive is /dev/hda, a parallel drive and the 
serial drive, /dev/hde is the auxiliary 2.4.21 allows me to "hdparm -d1 
-Xudma6 /dev/hde" while booting from a bootmisc.sh script.

