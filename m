Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWBCJNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBCJNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBCJNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:13:15 -0500
Received: from bataysk.donpac.ru ([80.254.111.21]:29113 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S932120AbWBCJNO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:13:14 -0500
Date: Fri, 3 Feb 2006 12:13:08 +0300
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060203091308.GA19805@pazke>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060202201734.GA17329@flint.arm.linux.org.uk>
X-Uname: Linux 2.6.16-rc1-pazke i686
User-Agent: Mutt/1.5.11
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 033, 02 02, 2006 at 08:17:35 +0000, Russell King wrote:
> On Thu, Feb 02, 2006 at 04:27:26PM +0300, Andrey Panin wrote:
> > Pong :) Please see below. Does it look better now ?
> 
> Thanks, applied.
> 
> > BTW I have a question for you. I'm trying to add support for Advantech serial
> > cards into 8250_pci.c. These cards are based on Oxford Semiconductor 16C950
> > UARTs and some of then can work in RS485 mode. They use DTR to automatically
> > control direction of the RS485 transiever buffer and so need to set bits
> > 3 and 4 in the ACR register. Unfortunately there is currently no way to set
> > different ACR value. Is it okay to use unused[] array in the struct uart_port
> > to pass ACR value from 8250_pci.c to 8250.c ?
> 
> As I've said many a time, we need a generic way to set different hand-
> shaking modes.  I've suggested using some spare bits in termios in the
> past, but nothing ever came of that - folk lose interest at that point.

IMHO there is no need to userspace visible changes to support RS485 on these cards,
because some of them are RS485 only and some have jumpers for individual ports. 
There is nothing that userspace can configure. We only need to set two bits in ACR
according to card type and jumper settings and UART will drive RS485 transiever
transparently.

Actually any program which want to talk with RS485 network should implement some
form of line discipline itself to prevent network collisions and kernel cannot
help with it much.

> So as far as I'm concerned, until folk start wanting to seriously
> discuss how to portably support different flow control methods, there's
> no real support for them.

For RS232 cace I agree, but for RS485 this is not needed IMHO.

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
