Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVBQRPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVBQRPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVBQRPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:15:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33495 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262169AbVBQRPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:15:09 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: pci_map_rom bug?
Date: Thu, 17 Feb 2005 09:14:04 -0800
User-Agent: KMail/1.7.2
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502161600.48252.jbarnes@sgi.com> <9e473391050217082963f6ce50@mail.gmail.com>
In-Reply-To: <9e473391050217082963f6ce50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170914.04305.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 17, 2005 8:29 am, Jon Smirl wrote:
> On Wed, 16 Feb 2005 16:00:47 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> > It looks like it's trying to verify all the ROMs on a given PCI device
> > rather than just the one we just ioremap'd above.  Should this check just
> > be inline and the loop deleted?  In that case, all of the breaks would
> > turn into return NULLs (though the code should probably be refactored to
> > make that a little clearer) along with an iounmap?
>
> The ROM experts on linux-pci supplied that code. It is legal to have
> multiple images in a ROM for different formats, x86, OpenFirmware,
> proprietary. The loop is adding all of the images together. Above we
> IO remapped the entire PCI window which may be 64K and it contained
> two images each at 20K. The extra loop returns the smaller size. This
> lets the copy_rom case allocate 40K of memory instead of 64K.

Ah, ok, but we still have the situation that cause me to post the cleanup 
patch in the first place--pci_map_rom succeeds, but the first two bytes 
aren't 0x55aa but 0x0303...  Any ideas?

Jesse
