Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUC2J5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUC2J5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:57:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26126 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262108AbUC2J5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:57:32 -0500
Date: Mon, 29 Mar 2004 10:57:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm5
Message-ID: <20040329105729.A20272@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040329014525.29a09cc6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040329014525.29a09cc6.akpm@osdl.org>; from akpm@osdl.org on Mon, Mar 29, 2004 at 01:45:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 01:45:25AM -0800, Andrew Morton wrote:
> +remove-down_tty_sem.patch
> +tty-locking-again.patch
> 
>  Really, really fix the tty open/close race.

Erm, note that tty drivers are supposed to handle the open/close stuff
themselves, and it is completely valid for ->close to be called while
another thread is in ->open.  In fact, it's desirable since ->open may
be waiting for the DCD line from a modem to activate, while there may
be a simultaneous O_NONBLOCK open/ioctl/close from stty.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
