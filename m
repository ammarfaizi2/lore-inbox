Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271846AbTGSA5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 20:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271818AbTGSA5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 20:57:06 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:41603 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S271823AbTGSA5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 20:57:03 -0400
Message-ID: <3F189955.6040308@colorfullife.com>
Date: Sat, 19 Jul 2003 03:05:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
CC: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:

>>  - qla2x00_intr_handler should use spin_lock, not spin_lock_irqsave
>
>Are you sure about that?  I'll need to refresh my interrupt handling
>know-how...
>  
>
It's an optimization that is used by many drivers:
Interrupt handlers are never reentered - if you are within 
qla2x00_intr_handler handling irq x, then it's guaranteed that the 
function won't be reentered by another occurance of the same interrupt.
If your driver registers only one interrupt handler, then you can skip 
disabling the local interrupts - a deadlock is not possible.

You need _irqsave if the spinlock is shared between multiple instances 
of the hba, with different interrupts (i.e. it's possible that 
qla2x00_intr_handler is called for irq y while handling irq x).

--
    Manfred




