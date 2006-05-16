Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWEPDz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWEPDz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 23:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWEPDz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 23:55:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:33143 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751164AbWEPDz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 23:55:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kAjvbnsVlWf+aYQvcXYf0oYZLsPMMrQEgXyWbzD2jXMruTWfsJ+1GZH/YhsgeE8I/hkln510svFfwwHBGfj5Lw+jdrVE1vxEHsafx1+cnOMj+429BaQcyI+S+NjbLUQrUUDKc42G0MMNJmfXZ4/pmOiM4bBkad10fijdXe0cIF8=
Message-ID: <44694D47.4090204@gmail.com>
Date: Tue, 16 May 2006 12:55:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>	 <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
In-Reply-To: <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
[--snip--]
> ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for UDMA/25
> ata1: EH complete
> NETDEV WATCHDOG: eth2: transmit timed out
> ata1.00: limiting speed to UDMA/16
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
> ata1.00: (BMDMA stat 0x1)
> ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for UDMA/16
> ata1: EH complete
> ata1.00: limiting speed to PIO4
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
> ata1.00: (BMDMA stat 0x1)
> ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for PIO4
> ata1: EH complete

Are those timeouts back-to-back?  Can you post dmesg w/ timestamp 
(either turn on kernel message timestamping or simply post relevant part 
from /var/log/kern.log).  The drive thinks the command is complete.  You 
might be losing interrupts (you might want to diddle with acpi/irq 
routing stuff) or it could be some other hardware problem.

Does the drive + controller work okay on Windows?  I know people don't 
like this question so much but it's a great way to isolate hardware 
problems as they use completely different driver stack.

And, as show above, currently implemented speed down is way to 
simplistic.  We need a better speed-down sequence, but I guess that can 
wait for a bit.

> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e000.
>  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
>  Flags; bus-master 1, dirty 18790(6) current 18806(6)
>  Transmit list 37e3c5c0 vs. f7e3c5c0.
>  0: @f7e3c200  length 8000002a status 0000002a
>  1: @f7e3c2a0  length 8000002a status 0000002a
>  2: @f7e3c340  length 8000002a status 0000002a
>  3: @f7e3c3e0  length 8000002a status 0000002a
>  4: @f7e3c480  length 8000002a status 8000002a
>  5: @f7e3c520  length 8000002a status 8000002a
>  6: @f7e3c5c0  length 8000005f status 0000005f
>  7: @f7e3c660  length 8000005f status 0000005f
>  8: @f7e3c700  length 8000002a status 0000002a
>  9: @f7e3c7a0  length 8000002a status 0000002a
>  10: @f7e3c840  length 8000002a status 0000002a
>  11: @f7e3c8e0  length 8000002a status 0000002a
>  12: @f7e3c980  length 8000002a status 0000002a
>  13: @f7e3ca20  length 8000002a status 0000002a
>  14: @f7e3cac0  length 8000002a status 0000002a
>  15: @f7e3cb60  length 8000002a status 0000002a
> eth0: Resetting the Tx ring pointer.
> NETDEV WATCHDOG: eth0: transmit timed out

Increased transmit timeout is probably because the CPU is locked up 
performing PIOs.  I worry about this.  With irq-pio, the system stutters 
much more.  It might be better to perform the actual PIO part from a 
workqueue.  But then there are controllers which can't stand when CPU 
leaves it unattended while PIO is in progress...

-- 
tejun
