Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270823AbTHCMuk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 08:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHCMuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 08:50:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14086 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270823AbTHCMuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 08:50:39 -0400
Date: Sun, 3 Aug 2003 13:50:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stefan Jones <cretin@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
Subject: Re: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad value compared to 2.4
Message-ID: <20030803135033.A15221@flint.arm.linux.org.uk>
Mail-Followup-To: Stefan Jones <cretin@gentoo.org>,
	linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
References: <1059244318.3400.17.camel@localhost> <20030802180837.B1895@flint.arm.linux.org.uk> <1059908861.3424.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1059908861.3424.7.camel@localhost>; from cretin@gentoo.org on Sun, Aug 03, 2003 at 12:07:41PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 12:07:41PM +0100, Stefan Jones wrote:
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> Yenta IRQ list 0038, PCI irq11
> Socket status: 30000417

No card inserted.

> parse_events: socket d080002c thread ce4db3c0 events 00000080
> yenta_get_status: status=30000417
> socket d080002c status 00000041
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x2c8-0x2cf 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> yenta_get_status: status=30000417
> 
> **** INSERT card first time nothing gets printed
> 
> **** REINSERT card and I get this;
> 
> 
> parse_events: socket d080002c thread ce4db3c0 events 00000080
> yenta_get_status: status=30000417
> socket d080002c status 00000041

This is a removal event.

> parse_events: socket d080002c thread ce4db3c0 events 00000080
> yenta_get_status: status=30000411
> socket d080002c status 000000c1

This is an insert event.

Hmm, so it looks like the hardware didn't report an insert event.  Can you
add a couple of printk()'s to yenta_events() to display the values of
cb_event and csc please?

Thanks.
-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

