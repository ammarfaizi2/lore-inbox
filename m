Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWHGXV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWHGXV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHGXV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:21:26 -0400
Received: from smtp01.gra.de ([62.146.73.187]:27268 "EHLO minne.gra.de")
	by vger.kernel.org with ESMTP id S1751189AbWHGXV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:21:26 -0400
Date: Tue, 8 Aug 2006 01:20:32 +0200
From: Mathias Adam <a2@adamis.de>
To: Theodore Tso <tytso@mit.edu>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060807232032.GA13008@adamis.de>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060802194938.GL5972@redhat.com> <20060802201723.GC7173@flint.arm.linux.org.uk> <20060802225912.GB30457@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802225912.GB30457@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 02.08.06 18:59:13, Theodore Tso wrote:
> On Wed, Aug 02, 2006 at 09:17:23PM +0100, Russell King wrote:
> > As I've said, I'm ignoring all 950 patches because I don't know what
> > works and what doesn't, and it's highly likely that applying one fix
> > for one card breaks already working fixes for other cards because
> > they have different crystals fitted, thereby requiring different
> > register settings.
> 
> Actually, this particular one is probably safe, because it doesn't
> depend on what crystal is installed, but rather works by using a
> documented feature in the Oxford 950 UART to oversample the clock
> signal.  In addition, the patch only activates UART_TCR if the user
> requests the higher baud rates, so the patch only does something if
> the user requests a baud rate that would have been previously rejected
> by the driver.  [...]

exactly, this is what the patch does. I implemented it according to
Oxford's 950 datasheet so it's not specific to the Socket BT card I have
used for testing. Furthermore, code similar to this has already been in
kernel 2.4 but got removed for some reason - perhaps there have been
other problems with 2.4's serial driver?

As far as I remember the current 2.6 serial driver uses a fixed value
for uartclk = 1843200 = 115200*16 while 2.4 was somewhat more general.
Together with 2.6's minimum divisor of 16 this gives the maximum baud
rate of 115200.

Are there any documents on why this was changed from 2.4 to 2.6?

Regards
Mathias

PS: currently I'm not subscribed to lkml so please CC me.
