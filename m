Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUC2Kd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 05:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUC2Kd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 05:33:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58638 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262788AbUC2KdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 05:33:24 -0500
Date: Mon, 29 Mar 2004 11:33:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm5
Message-ID: <20040329113321.A23135@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040329014525.29a09cc6.akpm@osdl.org> <20040329105729.A20272@flint.arm.linux.org.uk> <20040329022556.255c71bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040329022556.255c71bb.akpm@osdl.org>; from akpm@osdl.org on Mon, Mar 29, 2004 at 02:25:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 02:25:56AM -0800, Andrew Morton wrote:
> > and it is completely valid for ->close to be called while
> > another thread is in ->open.  In fact, it's desirable since ->open may
> > be waiting for the DCD line from a modem to activate, while there may
> > be a simultaneous O_NONBLOCK open/ioctl/close from stty.
> 
> ->open is not called under tty_sem.  With this change, ->close is called
> under tty_sem.
> 
> Are ->close implementations likely to block on hardware events?

Historically they have blocked in a well defined manner - eg when
dropping the DTR signal for a specified minimum time period.

They can also block until the data awaiting transmission has been
sent, which by default has a 30 second timeout, or may be configured
to be "until sent".  Of course, if CTS is deasserted, we will wait
until the timeout.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
