Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTHYOHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTHYOHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:07:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32009 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261863AbTHYOGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:06:11 -0400
Date: Mon, 25 Aug 2003 15:06:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mario Mikocevic <mario.mikocevic@htnet.hr>, linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825150608.A15816@flint.arm.linux.org.uk>
Mail-Followup-To: Mario Mikocevic <mario.mikocevic@htnet.hr>,
	linux-kernel@vger.kernel.org
References: <20030825091846.GA15017@danielle.hinet.hr> <20030825104035.B30952@flint.arm.linux.org.uk> <20030825102504.GC14801@danielle.hinet.hr> <20030825115538.C30952@flint.arm.linux.org.uk> <20030825124536.GG14801@danielle.hinet.hr> <20030825143034.D30952@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825143034.D30952@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Aug 25, 2003 at 02:30:34PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 02:30:34PM +0100, Russell King wrote:
> > Aug 25 13:42:26 mozz-r40 kernel: pci_dev: 0000:03:00.0 driver: d090c400 name: acx100_pci table: d090c3a0 probe: d0823000
> > Aug 25 13:42:26 mozz-r40 kernel: Unable to handle kernel paging request at virtual address d0823000
> 
> It's probe function is at address 0xd0823000 which is where your OOPS
> is happening.  I suspect you'll find the acx100 pci probe function is
> marked with __init.  That's a bug - it must not be.

Well, here it is:

static int __init
acx100_probe_pci(struct pci_dev *pdev, const struct pci_device_id *id)

Please report this to the ACX people as a bug - the probe function must
/not/ be marked as __init.  If they want them to be discarded if hotplug
is disabled, they must be marked as __devinit.  However, in 2.6 kernels,
they must not be marked as __init nor __devinit in any case.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

