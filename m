Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268462AbTGNIwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268552AbTGNIwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:52:45 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:1169 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268462AbTGNIw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:52:29 -0400
Date: Mon, 14 Jul 2003 11:07:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       John Belmonte <jvb@prairienet.org>
Subject: Re: Yenta_socket lsPCI IRQ reads incorrect
Message-ID: <20030714090700.GB221@elf.ucw.cz>
References: <200307141333.03911.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307141333.03911.mflt1@micrologica.com.hk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [mhf@mhfl2 13:40:27 mhf]$ cat /proc/interrupts
>            CPU0
>   0:    1242348          XT-PIC  timer
>   1:       5253          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:         88          XT-PIC  Toshiba America Info ToPIC95 PCI to Cardb, serial
>   8:          0          XT-PIC  rtc
>   9:        162          XT-PIC  acpi
>  10:       1003          XT-PIC  eth0
>  12:      23967          XT-PIC  i8042
>  14:       8698          XT-PIC  ide0
> NMI:          0
> LOC:          0
> ERR:          5
> MIS:          0
> 
> 
> lspci shows that IRQ level: byte 3C is FF, it should be 5
> 
> 00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
> 00: 79 11 17 06 00 00 90 04 32 00 07 06 00 40 82 00
> 10: 00 10 00 10 80 00 80 04 00 01 04 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
> 40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> When this value is used by pci_restore_state, interrupt 
> obviously dies.
> 
> Dunno if this is hardware readback fault or driver issue.

In any case it should be easy to fixup in ToPIC95 driver...

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
