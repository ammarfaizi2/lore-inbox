Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbTDIHEz (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTDIHEz (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:04:55 -0400
Received: from grunt5.ihug.co.nz ([203.109.254.45]:55482 "EHLO
	grunt5.ihug.co.nz") by vger.kernel.org with ESMTP id S262866AbTDIHEy (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:04:54 -0400
Message-ID: <002e01c2ff18$2f043ca0$0b721cac@stacy>
From: "dave" <davekern@ihug.co.nz>
To: <linux-kernel@vger.kernel.org>
Subject: help DMA FIFO buffer
Date: Wed, 9 Apr 2003 21:18:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I am writing a device driver LNVRM is uses DMA for commands and data
i need a function that will wait until their is enough room in the FIFO for
the new
data this function works but their must be a better way I need a formula
that dose
not have if's in it

Like this

#define NV04_DMA_WAIT_FREE(free)                 while((dma->size -
(dma->put - dma->control->get)) < free)

thank you .

also it thear is no way can this be made inline ?

void lnvrm_dmaNv04WaitFree(struct _nvxf_dmaChannel dma , unsigned long)
{
  unsigned long get , put = dma->put , size = dma->mask + 1 , free , f = 0 ;

 loop1:
  get = dma->control->Get ;

  if(put < get)
    free = size - (size - get + put) ;
  else
    free = size - (put - get) ;

  if(count <= free) return ; /* Get out as quick as possible */

  if(f) { ErrorF("lnvrm_dmaNv04WaitFree: FIFO FULL free = %8.8lX needed =
%8.8lX\n",free,count) ; f++ }
  goto loop1 ;
}

