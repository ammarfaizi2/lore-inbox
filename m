Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSCRUg1>; Mon, 18 Mar 2002 15:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292840AbSCRUgR>; Mon, 18 Mar 2002 15:36:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31872 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292837AbSCRUgH>; Mon, 18 Mar 2002 15:36:07 -0500
Date: Mon, 18 Mar 2002 15:36:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: PCI drivers - memory mapped vs. I/O ports
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A7715@EXCHANGE>
Message-ID: <Pine.LNX.3.95.1020318152604.29558A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Ed Vance wrote:

> If a PCI device can be programmed equally well via I/O port space or memory
> space, what are the reasons to chose one space over the other when writing
> the driver?
> 

o       There is more 'memory' I/O space. Therefore you are more likely
        to have enough space for your device when other boards are
        installed. IOTW, you may find that there is no I/O space allocated
        because there isn't any available.

o       Memory address space I/O is faster on Intel Machines. You can
        write or read whole buffers of I/O space in memory address space.
        the best you can do in port space is one long-word at a time.

o       PCI posted writes work when accessing memory-address I/O space.
        Port I/O space cannot do this. The FIFO is written immediately
        before any other access is allowed. This improves the access
        speed in certain circumstances.

Basically, if you have a choice, it's hands-down to use memory-mapped
I/O space.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

