Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTDVUat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTDVUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:30:49 -0400
Received: from [66.78.41.84] ([66.78.41.84]:36264 "EHLO cell01.cell01.com")
	by vger.kernel.org with ESMTP id S263490AbTDVUar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:30:47 -0400
From: Eric Northup <digitale@digitaleric.net>
Reply-To: digitale@digitaleric.net
To: Manfred Spraul <manfred@colorfullife.com>, mailing-lists@digitaleric.net
Subject: Re: 2.5.68 IDE Oops at boot [working now]
Date: Tue, 22 Apr 2003 16:37:30 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3EA286D5.30706@colorfullife.com> <200304201348.34229.lkml@digitaleric.net> <3EA2E86A.7010606@colorfullife.com>
In-Reply-To: <3EA2E86A.7010606@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304221637.30278.digitale@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cell01.cell01.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 April 2003 02:35 pm, Manfred Spraul wrote:
> Eric Northup wrote:
> >init_irq called for hwif ide0.
> >hdc: MAXTOR 6L080L4, ATA DISK drive
>
> init_irq called, but does nothing.
>
> >init_irq called for hwif ide2.
> >blk_init_queue: c04c99d4 initialized.
>
> This is what's supposed to happen: init_irq initialized the queues.
>
> Two bugs:
> - why doesn't init_irq initialize the queues for the siimage controller?
> I found a difference between 2.5.67 and 68: init_irq always returns 0,
> even on error. It should return 1 on error. (It wasn't difficult to
> find, I introduced it :-(
> - The error handling is bad. Probably drive->present should be forced to
> 0, if the queues could not be initialized.
>
> Could you try the attached patch? It fixes the return code and adds some
> additional printks.
>
> --
>     Manfred

This fixes it, thank you very much!  I am currently running 2.5.68 with your 
IDE patch.  One annoyance is that the order of IDE channels is different 
between 2.4.20 and 2.5.68 - the Silicon Image SATA controller is detected 
first on 2.5 but not on 2.4.  I've just put a simple script to swap 
/etc/fstab at boot based on the running kernel, but the device swap is not 
very user-friendly.  Other than that, I've got no complaints - the system is 
running quite well!

--Eric Northup
