Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUHPGPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUHPGPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUHPGPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:15:55 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:65242 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S267452AbUHPGPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:15:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16672.20648.312792.140066@rover.ozlabs.ibm.com>
Date: Mon, 16 Aug 2004 16:14:00 +1000
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: VPD in sysfs
In-Reply-To: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
References: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
From: "Martin Schwenke" <martins@au1.ibm.com>
Reply-To: "Martin Schwenke" <martins@au1.ibm.com>
X-Kernel: Linux 2.6.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'll reply to this quickly even though I'm 1/2 asleep...  travelling
 and not sure when I'll get to email again...]

>>>>> "Willy" == Matthew Wilcox <willy@debian.org> writes:

    Willy> I've been sent a patch that reads some VPD from the Symbios
    Willy> NVRAM and displays it in sysfs.  I'm not sure whether the
    Willy> way the author chose to present it is the best.  They put
    Willy> it in 0000:80:01.0/host0/vpd_name which seems a bit too
    Willy> scsi-specific and insufficiently forward-looking (I bet we
    Willy> want to expose more VPD data than that in the future, so we
    Willy> should probably use a directory).

Does the patch expose the VPD as text?  Either way, what's the format?

    Willy> I actually have a feeling (and please don't kill me for
    Willy> saying this), that we should add a struct vpd * to the
    Willy> struct device.  Then we need something like the
    Willy> drivers/base/power/sysfs.c file (probably
    Willy> drivers/base/vpd.c) that takes care of adding vpd to each
    Willy> device that wants it.

Sounds good to me...  I like the idea of a consistent way of getting
at VPD.  Perhaps then HAL would get at it too.

    Willy> Thoughts?  Since there's at least four and probably more
    Willy> ways of getting at VPD, we either need to fill in some VPD
    Willy> structs at initialisation or have some kind of vpd_ops that
    Willy> a driver can fill in so the core can get at the data.

For PCI 2.0/2.1 VPD in expansion ROMs the recent patch to expose the
ROMs in sysfs is probably enough.  The likely brokenness of ROMs and
the VPD means that trying to special-case around brokenness should
probably be done outside the kernel.

However, I could be wrong: there is something to be said for
consistency...

peace & happiness,
martin

