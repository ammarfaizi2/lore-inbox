Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVLBTeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVLBTeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVLBTeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:34:08 -0500
Received: from javad.com ([216.122.176.236]:52752 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1750976AbVLBTeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:34:07 -0500
From: "Sergei Organov" <osv@javad.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: SATA ICH6M problems on Sharp M4000
References: <200511221013.04798.marekw1977>
In-reply-to: <200511221013.04798.marekw1977>
Date: Fri, 02 Dec 2005 22:33:57 +0300
Message-ID: <87u0dri996.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Josh Litherland wrote:
> > Trying to get this laptop operational; it has SATA for the hard disc and
> > PATA for the optical drive.  The hard drive is wired to the secondary
> > IDE interface, the optical to the primary.  
[...]
> > With ata_piix driving the hard drive, performance is great, but the
> > optical device is never enumerated.

I have exactly the same problem with my IBM ThinkPad T43 and 2.6.14
kernel and still can't find a way to let ata_piix manage the hard drive
and generic_ide to manage the optical one. BIOS doesn't have any
settings for SATA on this notebook.

> 
> Expected behavior, since the default for module option atapi_enabled
> is zero (disabled).
> 
> > When the piix driver tries to load, the following occurs:
> > 
> > ide0: I/O resource 0x1F0-0x1F7 not free.
> > ide0: ports already in use, skipping probe
> > ide1: I/O resource 0x170-0x177 not free.
> > ide1: ports already in use, skipping probe
[...]
> So far everything seems to be expected behavior.

Sorry, but provided ata_piix has ignored the optical drive, couldn't
corresponding I/O resource be left free so that subsequently loaded,
say, generic-ide module is able to get over and support the drive?

BTW, loading the modules in reverse order helped on 2.6.13 kernel (that
I'm currently using) as generic-ide didn't recognize the hard-drive at
all allowing ata_piix to get over it later. With 2.6.14 kernel
generic-ide does recognize both hard-drive and optical drive thus
preventing ata_piix from managing the hard-drive :(

-- 
Sergei.
