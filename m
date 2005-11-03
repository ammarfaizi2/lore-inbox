Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbVKCX1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbVKCX1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVKCX1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:27:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:1475 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030530AbVKCX1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:27:24 -0500
Date: Thu, 3 Nov 2005 15:26:35 -0800
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
Message-ID: <20051103232635.GA31121@kroah.com>
References: <20051103.093328.74747521.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103.093328.74747521.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 09:33:28AM -0800, David S. Miller wrote:
> 
> This change:
> 
> diff-tree 478a3bab8c87a9ba4a4ba338314e32bb0c378e62 (from 46f116eab81b21c6ae8c4f169498c632b1f94bf1)
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Oct 19 12:52:02 2005 -0400
> 
>     [PATCH] USB: Always do usb-handoff
>     
>     This revised patch (as586b) makes usb-handoff permanently true and no
>     longer a kernel boot parameter.  It also removes the piix3_usb quirk code;
>     that was nothing more than an early version of the USB handoff code
>     (written at a time when Intel's PIIX3 was about the only motherboard with
>     USB support).  And it adds identifiers for the three PCI USB controller
>     classes to pci_ids.h.
>     
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> breaks sparc64 bootup badly on machines with USB host controllers.

Does Linus's current tree fix this?  I ask, because I thought that:

Author: Linus Torvalds <torvalds@g5.osdl.org>  2005-10-31 21:12:40
Committer: Linus Torvalds <torvalds@g5.osdl.org>  2005-10-31 21:12:40
Parent: 1e4c85f97fe26fbd70da12148b3992c0e00361fd (Revert "i386: move apic init in init_IRQs")
Child:  df70b17f88a4d1d8545d3569a1f6d28c6004f9e4 (Merge git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6)

    Don't touch USB controller IO registers when they are disabled
    
    The USB "handoff" code is an early PCI quirk to make sure we own the USB
    controller (as opposed to the BIOS/SMM).  But if the controller isn't
    even enabled yet, don't try to access it.
    
    Acked-by: Paul Mackerras <paulus@samba.org> (who had an alternate patch)
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


Should have fixed this.  If not, please let me know.

thanks,

greg k-h
