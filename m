Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbTHZIrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTHZIrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:47:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263563AbTHZIrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:47:20 -0400
Date: Tue, 26 Aug 2003 09:47:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading accurate size of recepts from serial port
Message-ID: <20030826094717.A13415@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>,
	linux-kernel@vger.kernel.org
References: <200308261032.13576.laurent.huge@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308261032.13576.laurent.huge@wanadoo.fr>; from laurent.huge@wanadoo.fr on Tue, Aug 26, 2003 at 10:32:13AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 10:32:13AM +0200, Laurent Hugé wrote:
> I feel sorry to annoy you again with my problem, but I can't imagine there is 
> no way to know the accurate size of a recept on the serial port.

The serial driver can not and does not know in advance how many characters
the other is going to send.  As far as the serial driver is concerned, it's
just a meaningless stream of characters.

To give an example, if your device sends the following character stream:

  first                                               last
    v                                                   v
    .....................................................

your line discipline may receive this as four separate blocks:

    ................                                       block 1
                    ................                       block 2
                                    .................      block 3
                                                     ....  block 4

It may not receive it like the above - it may be several blocks of 8
characters or whatever, depending on the UARTs FIFO, interrupt load,
etc.

There is just no way for the serial driver itself to batch them back
up.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

