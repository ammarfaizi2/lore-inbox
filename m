Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUHNS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUHNS3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUHNS3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:29:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54442 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264419AbUHNS3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:29:36 -0400
Date: Sat, 14 Aug 2004 19:29:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>, martins@au.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: VPD in sysfs
Message-ID: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been sent a patch that reads some VPD from the Symbios NVRAM and
displays it in sysfs.  I'm not sure whether the way the author chose
to present it is the best.  They put it in 0000:80:01.0/host0/vpd_name
which seems a bit too scsi-specific and insufficiently forward-looking
(I bet we want to expose more VPD data than that in the future, so we
should probably use a directory).

I actually have a feeling (and please don't kill me for saying this), that
we should add a struct vpd * to the struct device.  Then we need something
like the drivers/base/power/sysfs.c file (probably drivers/base/vpd.c)
that takes care of adding vpd to each device that wants it.

Thoughts?  Since there's at least four and probably more ways of getting
at VPD, we either need to fill in some VPD structs at initialisation or
have some kind of vpd_ops that a driver can fill in so the core can get
at the data.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
