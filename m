Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273372AbRJFLRr>; Sat, 6 Oct 2001 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273723AbRJFLRh>; Sat, 6 Oct 2001 07:17:37 -0400
Received: from colorfullife.com ([216.156.138.34]:60683 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273372AbRJFLRd>;
	Sat, 6 Oct 2001 07:17:33 -0400
Message-ID: <002701c14e58$96ca8d70$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Christian Widmer" <cwidmer@iiic.ethz.ch>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: unnecessary retransmit from network stack
Date: Sat, 6 Oct 2001 13:18:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That isn't a duplicate:

>0x186dce1f8b03 | TxMit | 909902972 | 897283492
> 0x186dce220317 | TxIrq | 909902972 | 897283492
> 0x186dce3002e8 | RxIrq | 897283492 | 909902972
> 0x186dce308560 | TxMit | 909902972 | 897283515 <- dublicate
Acknowledge 897283515, send 0 bytes.
(must be send 0, since the next tx has the same sequence no)

> 0x186dce330bab | TxIrq | 909902972 | 897283515
> 0x186dce3c09bf | TxMit | 909902972 | 897283515 <- dublicate
Acknowledge didn't change, send 22 bytes
(must be 22 bytes, 909902994-909902972)

> 0x186dce3e9b6f | TxIrq | 909902972 | 897283515
> 0x186dce424310 | RxIrq | 897283515 | 909902994
> 0x186dce47bc44 | RxIrq | 897283515 | 909902994
> 0x186dcf094683 | TxMit | 909902994 | 897283791

I'd say bad luck: you try to send data 2 milliseconds after the delack
timer expired.

--
    Manfred

