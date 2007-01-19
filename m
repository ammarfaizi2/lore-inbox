Return-Path: <linux-kernel-owner+w=401wt.eu-S965024AbXASJf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbXASJf1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 04:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbXASJf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 04:35:27 -0500
Received: from gateway1.seskion.de ([62.8.128.82]:21446 "EHLO
	gateway1.seskion.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965003AbXASJf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 04:35:26 -0500
Message-ID: <45B090D9.7020602@seskion.de>
Date: Fri, 19 Jan 2007 10:35:21 +0100
From: Juergen Pfeiffer <j.pfeiffer@seskion.de>
Organization: SesKion Softwareentwicklung und System Konzeption GmbH
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: long disable of Softirqs in br_forward_delay_timer_expired()
References: <45AF79AE.1060102@seskion.de>
In-Reply-To: <45AF79AE.1060102@seskion.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Pfeiffer schrieb:
>
> I had problems in my implementation of Profibus-protocol, because my 
> FDL-State machine is implemented in tasklets and
> sometimes there were situations, where Soft-Irqs were disabled for 
> 20-40mS (Coldfire 5485 / 96MHz).
> After inserting some testpoints in kernels source, doing dump_stack(), 
> when the jiffie-time get longer then 20mS,
> i detected the place of the long Soft-Irq disable in function
>
> static void br_forward_delay_timer_expired(..)
> inside file "net/bridge/br_stp_timer.c"
>
> It does a
> spin_lock_bh(..);
> ... some functionality;
> spin_unlock_bh(..);


Hi

I found the reason for the long disabling of Soft-Irqs:

In-between the spin_lock_bh() and spin_unlock_bh() was a printk() going 
to serial console with 19200baud.
So it took easily 30mS for console-output.

No i start klogd an the log Messages go to a file in tmpfs in a short time.



Juergen Pfeiffer,
Seskion GmbH
Karlsruher Str. 11/1
70771 Leinfelden-Echterdingen
Germany

j.pfeiffer@seskion.de

www.seskion.de
------------------------------------------------------------------------
