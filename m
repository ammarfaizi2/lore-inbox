Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSKFCP0>; Tue, 5 Nov 2002 21:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbSKFCP0>; Tue, 5 Nov 2002 21:15:26 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:5627 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265484AbSKFCPZ>; Tue, 5 Nov 2002 21:15:25 -0500
Message-ID: <3DC88B21.3030202@wanadoo.fr>
Date: Wed, 06 Nov 2002 03:23:13 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
References: <Pine.LNX.4.44.0211050927350.27141-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 5 Nov 2002, Russell King wrote:
> 
> 
>>static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
>>{
>>        offset <<= up->port.regshift;
>>
>>        switch (up->port.iotype) {
>>
>>which also dereferences "up".  So something may have corrupted %ebx
>>between executing that switch statement and executing the inb().
>>
>>Could the NMI handler be corrupting %ebx ?

ok but

 > [<c023d9d8>] serial8250_console_write+0x68/0x1f0
 > [<c0121459>] __call_console_drivers+0x49/0x50
 > [<c0121541>] call_console_drivers+0x71/0x100
 > [<c012196d>] release_console_sem+0xbd/0x170
 > [<c01217cc>] printk+0x18c/0x220
 > [<c01170d5>] nmi_add_task+0xc5/0xe0
 > [<c01177e0>] nmi_watchdog_tick+0x0/0x120

the oops occur during a NMI so I wonder how a NMI
can occur and clobber ebx

-- 
Philippe Elie

