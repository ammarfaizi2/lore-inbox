Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbTDILeG (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTDILeG (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:34:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23707
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263010AbTDILeF (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:34:05 -0400
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049879881.2774.40.camel@fortknox>
References: <1049879881.2774.40.camel@fortknox>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049885242.9897.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 11:47:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 10:18, Soeren Sonnenburg wrote:
> hdi: 4 bytes in FIFO
> hdi: timeout waiting for DMA
> hdi: (__ide_dma_test_irq) called while not waiting
> hdi: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdk: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

This looks like a shared IRQ occurred while a command was being
sent. The IDE layer apparently tested for the IRQ before it 
was ready to do so as part of finding out what is going on. The
-ac tree (and pre7) may possibly have fixed it with the command
delay stuff that Ross Biro figured out

