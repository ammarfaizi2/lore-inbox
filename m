Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263532AbUJ2WnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbUJ2WnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUJ2WWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:22:33 -0400
Received: from web52601.mail.yahoo.com ([206.190.39.139]:53633 "HELO
	web52601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263605AbUJ2WAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:00:53 -0400
Message-ID: <20041029220052.97805.qmail@web52601.mail.yahoo.com>
Date: Fri, 29 Oct 2004 15:00:52 -0700 (PDT)
From: brian franklin <may26baf@yahoo.com>
Subject: free_irq problem in 2.6 kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a network driver which uses PCI Interrupt D. 
Using kernel
2.6.8-1.528.2.10smp, I now have a problem when I call
free_irq().  It
now masks off the interrupt even though it is shared
with another
device.  My initial call to request_irq() succeeds,
and my driver will
correctly receive interrupts.  But once I call
free_irq(), the
interrupt is now masked, and subsequent calls to
request_irq() don't
unmask the interrupt.

The syntax of my calls to these two functions are:
status = request_irq(priv->irq , jnet_isr, SA_SHIRQ,
name1, dev);
and
free_irq(priv->irq, dev);

Can anyone shed some light on what I might be doing
wrong?

As a side note: I noticed that this kernel now
correctly configures
the IOAPIC configuration register with the interrupt
vector.  Previous
kernels did not.  Can anyone tell me how to
distinguish between a
kernel version that does configured the IOAPIC
configuration registers
correctly, and one that doesn't?  (In previous
versions, the
configuration register would have an interrupt vector
of IRQ169 while
the interrupt was really IRQ19.  Now, the interrupt
vector in the
configuration register matches with the IRQ that is
actually
selected.)

Thanks for any assistance.
Brian Franklin




		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
