Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVBQQ36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVBQQ36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVBQQ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:29:58 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:51906 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262274AbVBQQ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:29:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mJJaCf/jwBTN6Nb0rozEQ/GhZpCz7HkUSaVvGG5TmUqUNvZSBH5CYMJMpfAr5kwoVfsIFu1T2IKb2C74/H3n9F+s0C6LYeQz84k+3Eb+ROTd1J1pqCWS6SyH0eYceAfECqSVhc0rEKu4+r+9OCzBb/LJxoHNuEZ8P9LbF7Wsb/E=
Message-ID: <9e473391050217082963f6ce50@mail.gmail.com>
Date: Thu, 17 Feb 2005 11:29:45 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: pci_map_rom bug?
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502161600.48252.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502161600.48252.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005 16:00:47 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> It looks like it's trying to verify all the ROMs on a given PCI device rather
> than just the one we just ioremap'd above.  Should this check just be inline
> and the loop deleted?  In that case, all of the breaks would turn into return
> NULLs (though the code should probably be refactored to make that a little
> clearer) along with an iounmap?

The ROM experts on linux-pci supplied that code. It is legal to have
multiple images in a ROM for different formats, x86, OpenFirmware,
proprietary. The loop is adding all of the images together. Above we
IO remapped the entire PCI window which may be 64K and it contained
two images each at 20K. The extra loop returns the smaller size. This
lets the copy_rom case allocate 40K of memory instead of 64K.

-- 
Jon Smirl
jonsmirl@gmail.com
