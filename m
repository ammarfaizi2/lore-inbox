Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTHYNar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTHYNar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:30:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54024 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261764AbTHYNak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:30:40 -0400
Date: Mon, 25 Aug 2003 14:30:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mario Mikocevic <mario.mikocevic@htnet.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825143034.D30952@flint.arm.linux.org.uk>
Mail-Followup-To: Mario Mikocevic <mario.mikocevic@htnet.hr>,
	linux-kernel@vger.kernel.org
References: <20030825091846.GA15017@danielle.hinet.hr> <20030825104035.B30952@flint.arm.linux.org.uk> <20030825102504.GC14801@danielle.hinet.hr> <20030825115538.C30952@flint.arm.linux.org.uk> <20030825124536.GG14801@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825124536.GG14801@danielle.hinet.hr>; from mario.mikocevic@htnet.hr on Mon, Aug 25, 2003 at 02:45:36PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 02:45:36PM +0200, Mario Mikocevic wrote:
> OK, first some additional testing info, at first I thought it was
> repeatable in the _very_ _same_ manner but not _quite_.
> I have two possible scenarios ->
> 
>  - after some time (never more than a minute or two) of plugging DWL-650+
>    into slot thinkpad-r40 just shuts itself down, no oops, _no_ nothing
> 
>  - loading modules shortens time to shutdown to few seconds and _sometimes_
>    produces oops, so I have to do several plug_in/*plonk*/turn_on/fsck/reboot
>    iterations to get oops
> 
> Here's latest oops, this time provocated with loading modules snd-intel8x0 and
> acx100_pci (yesterdays 0.1h version from http://acx100.sourceforge.net/) ->

Well, acx100_pci seems to be buggy.

> Aug 25 13:42:09 mozz-r40 kernel: pci_dev: 0000:00:1f.5 driver: d0916580 name: Intel ICH table: d0915be0 probe: d0911f9e
> Aug 25 13:42:10 mozz-r40 kernel: intel8x0: clocking to 48000

> Aug 25 13:42:26 mozz-r40 kernel: pci_dev: 0000:03:00.0 driver: d090c400 name: acx100_pci table: d090c3a0 probe: d0823000
> Aug 25 13:42:26 mozz-r40 kernel: Unable to handle kernel paging request at virtual address d0823000

It's probe function is at address 0xd0823000 which is where your OOPS
is happening.  I suspect you'll find the acx100 pci probe function is
marked with __init.  That's a bug - it must not be.

Similarly, the PCI ID table must not be marked with __devinitdata nor
__initdata.

(I can't reach acx100.sourceforge.net currently.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

