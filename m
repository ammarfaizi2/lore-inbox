Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWADIrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWADIrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWADIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:47:09 -0500
Received: from llsa378-a01.servidoresdns.net ([82.223.190.20]:27294 "EHLO
	llsa378-a01.servidoresdns.net") by vger.kernel.org with ESMTP
	id S1751223AbWADIrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:47:08 -0500
Message-ID: <43BB8C0D.1030302@yahoo.com>
Date: Wed, 04 Jan 2006 09:49:17 +0100
From: Pedro Monjo Florit <pmonjo2000@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error in ohci_hcd with bluetooth dongles
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I am using kernel 2.6.12 patched with Marcel Holtmann patches 
(2.6.12-mh3) and a custom Linux distribution based on Linux From Scratch 
6.1. I attach up to three CSR-based Bluetooth dongles, through USB.

I have a problem with the ohci_hcd module. For some (still unknown) 
reason, at a random time, I start to get error messages in syslog, at a 
rate of about 150 lines per second, until they fill up the entire hard 
disk. This does not happen always, only from time to time. Here is a 
sample of the messages:

Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 1.3 ep1in 5f160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110
Dec 22 21:30:21 Host last message repeated 3 times
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 1.3 ep1in 5f160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110
Dec 22 21:30:21 Host last message repeated 3 times
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 1.3 ep1in 5f160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110
Dec 22 21:30:21 Host last message repeated 3 times
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 1.3 ep1in 5f160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110
Dec 22 21:30:21 Host last message repeated 2 times
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e1110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 1.3 ep1in 5f160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110
Dec 22 21:30:21 Host last message repeated 3 times
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 1.3 ep1in 5f160000 cc 5 --> status -110
Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f974 path 1.3 ep2in 5e160000 cc 5 --> status -110


I have found where the error is generated in the kernel souces (file 
ohci-q.c), but I am not an expert in USB protocol, so I do not know 
exactly when is this triggered. Searching in the archives, I have seen 
that this problem was once reported back in June 2004 and Marcel 
answered that in 2.6.7-rc2 it was already solved.

I must add that the problem may be well due to a hardware error, but I 
want to make sure that the problem is not in the software.

What does exactly this error mean? When is it generated? Is there any 
known reason that could make the kernel enter an infinite loop that 
would generate this error continously, even in the absence of the 
original condition?

Cheers,

Pedro Monjo
