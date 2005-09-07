Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVIGEUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVIGEUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 00:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVIGEUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 00:20:32 -0400
Received: from main.gmane.org ([80.91.229.2]:53915 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751036AbVIGEUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 00:20:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Aric Cyr <Aric.Cyr@gmail.com>
Subject: Re: 2.6.13 (was 2.6.11.11) and rsync oops (SATA or NFS related?)
Date: Wed, 7 Sep 2005 04:00:16 +0000 (UTC)
Message-ID: <loom.20050907T055454-169@post.gmane.org>
References: <dfg2sa$peu$2@sea.gmane.org> <dfguoq$eng$1@sea.gmane.org> <dfhjp3$fd4$1@sea.gmane.org> <dfjjp9$f7k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.179.48.72 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Firefox/1.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV <kalin <at> thinrope.net> writes:

> 
> A closer examination of the drive:
> 	(Model=ST3300831AS, FwRev=3.03, SerialNo=3NF07KA1 )
> and why is it so slow revealed that it was running not in UDMA.
>
> Got one total oops, even no logs were written to disk.
> Seems that rsync-ing huge amounts of data (200 GB in *many* small files)
streses the system too much.

It seems that you are using the IDE-SATA driver... perhaps you should try the
SCSI-SATA (i.e. libata)?  The IDE one is deprecated and should no longer be
used.  Disable SATA from in the IDE menu and enable the SCSI libata driver for
your chipset (in the scsi kernel menu).


Also the reason you don't get higher UDMA modes is because your drive is a
blacklisted seagate.  There are known problems with some of those drives, and so
they are downgraded to slower modes (this was mentioned in your kernel log if
you look closely).  If you upgrade the BIOS on your harddrive, you _might_ be
able to remove the drive from the blacklist in the kernel to improve
performance... this may be dangerous however, so don't complain if you lose your
data.

