Return-Path: <linux-kernel-owner+w=401wt.eu-S932108AbXARJNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXARJNg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXARJNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:13:35 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2533 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbXARJNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:13:34 -0500
Date: Thu, 18 Jan 2007 09:13:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brian Beattie <brianb@apcon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A question about break and sysrq on a serial console (2.6.19.1)
Message-ID: <20070118091326.GB32068@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Beattie <brianb@apcon.com>,
	linux-kernel@vger.kernel.org
References: <1169078214.16802.17.camel@brianb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169078214.16802.17.camel@brianb>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 03:56:54PM -0800, Brian Beattie wrote:
> I'm trying to do a SYSRQ over a serial console.  As I understand it a
> break will do that, but I'm not seeing the SYSRQ.  In looking at
> uart_handle_break() in drivers/serial/8250.c it looks like the code will
> toggle port->sysrq, rather than just setting it when the port is a
> console.  I think the correct code would be to move the "port->sysrq =
> 0;" to follow the closing brace on the next line, or am I missing
> something.

Thereby preventing the action of <break> (which may be to cause a SAK
event, which would be rather important on a console to ensure that
you're really logging in rather than typing your password into another
users program which just looks like a login program.)

Note that the sequence for sysrq is:

(non-break characters or nothing) <break> <sysrq-char>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
