Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265607AbUEZPB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUEZPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUEZPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:01:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59554 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265728AbUEZO7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 10:59:54 -0400
From: Andreas Hess <hess@tkn.tu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: Soft and Hard Interrupts
Date: Wed, 26 May 2004 16:52:23 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405261652.23367.hess@tkn.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have difficulties in understanding the interplay between hard and soft 
interrupts. Perhaps things get clearer with the following example:
1.) a packet is arriving at a NIC and triggers the execution of a hardware 
interrupt
2.) the do_irq() routine is called
3.) the according interrupt service routine (ISR) is executed (which triggers 
a soft interrupt)
4.) the kernel terminates the do_irq() routine and checks if there is a soft 
interrupt waiting to be processed
5.) the soft interrupt is processed

The higher the arrival rate of packets, the higher the amount of interrupts to 
be processed. In order to prevent the system from permanently processing 
interrupts --- in case that a certain threshold value is reached --- the 
ksoftirqd daemon takes over the responsibility for the software interrupt 
handling. Then software interrupts are processed in the event that the 
ksoftirqd is scheduled and running. 
Is this so far correct? If yes, I wonder how the threshold value, the point at 
which the ksoftirqd gets into charge, is defined?
Please 'CC' me as I am not subscribed to the list.

Thanks Andreas


