Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268566AbTGNJZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 05:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268620AbTGNJZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 05:25:00 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:28681 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S268566AbTGNJY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 05:24:59 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Mon, 14 Jul 2003 17:28:24 +0800
User-Agent: KMail/1.5.2
Cc: Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk>
In-Reply-To: <200307141333.03911.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307141725.27304.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 13:41, Michael Frank wrote:
>
> Dunno if this is hardware readback fault or driver issue.
>

Very funny - suspend/resume is not implemented ;)

static int yenta_suspend(struct pcmcia_socket *sock)
{
	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);

	yenta_set_socket(sock, &dead_socket);

	/* Disable interrupts */
	cb_writel(socket, CB_SOCKET_MASK, 0x0);

	/*
	 * This does not work currently. The controller
	 * loses too much information during D3 to come up
	 * cleanly. We should probably fix yenta_init()
	 * to update all the critical registers, notably
	 * the IO and MEM bridging region data.. That is
	 * something that pci_set_power_state() should
	 * probably know about bridges anyway.
	 *
	pci_set_power_state(socket->dev, 3);
	 */

	return 0;
}

Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

