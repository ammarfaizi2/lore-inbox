Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbTGOQXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbTGOQXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:23:19 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:14611 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S268737AbTGOQXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:23:15 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Wed, 16 Jul 2003 00:09:07 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <20030715085622.A32119@flint.arm.linux.org.uk> <200307151734.46616.mflt1@micrologica.com.hk>
In-Reply-To: <200307151734.46616.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307160009.08605.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 17:34, Michael Frank wrote:
> I believe it is not here now, we need to look elsewhere, as interrupts
> stay dead also after reloading modules (see logs).
>
> Jul 15 17:06:43 mhfl2 kernel: Socket status: ffffffff

FFFFFFFF!!!!

This returns ffffffff too:
  cb_writel(socket, CB_SOCKET_MASK, 0x0);
  if ((temp = cb_readl(socket, CB_SOCKET_MASK)) != 0)
    printk("Yenta: probe can't write socket mask %x\n",temp);

because the device is somewhat "passive" after a suspend....

Should we save all registers? - it has 128

It sits on the same bus with ide, e100 which work, so it won't
be pci related - OK?.

Another thing, even lspci returns crap after suspend because 
data come from RAM rather than device(s).

I would like to do generic pci_save_state/pci_restore_state 
centraly in the pci driver. It would reduce other driver side 
work too.

What is the possible downside of this approach and your 
opinion in general?


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


