Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWHBQVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWHBQVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWHBQVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:21:16 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:13843 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932090AbWHBQVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:21:15 -0400
Date: Wed, 2 Aug 2006 17:21:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] at91_serial: Fix break handling
Message-ID: <20060802162109.GB7173@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
References: <11545303083273-git-send-email-hskinnemoen@atmel.com> <11545303082669-git-send-email-hskinnemoen@atmel.com> <11545303083943-git-send-email-hskinnemoen@atmel.com> <20060802151741.GB32102@flint.arm.linux.org.uk> <20060802181403.32169f00@cad-250-152.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802181403.32169f00@cad-250-152.norway.atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:14:03PM +0200, Haavard Skinnemoen wrote:
> On Wed, 2 Aug 2006 16:17:41 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 2. it breaks break handling.  uart_handle_break returns a value for a
> >    reason.  Use it - don't unconditionally ignore the received
> > character.
> 
> Ok, I'll fix it.
> 
> Out of curiosity, why does it return a value? ;)

Because you may or may not need to ignore the received character!

When a break condition occurs which is not ignored by the termios
settings, you need to insert a TTY_BREAK indicator into the tty
received queue, so that the tty layers and userspace can do the
right thing.  There is the requirement for errors to be passed to
userspace if userspace has requested that behaviour.

However, if this is the serial console with sysrq support, then break
is masked by that and needs to be ignored.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
