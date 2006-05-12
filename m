Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWELVjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWELVjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWELVjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:39:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17887 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750842AbWELVjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:39:24 -0400
Date: Fri, 12 May 2006 22:39:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512213916.GO27946@ftp.linux.org.uk>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk> <20060512205215.GA26501@kroah.com> <20060512210300.GE17120@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512210300.GE17120@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 10:03:01PM +0100, Russell King wrote:
> The block layer holds on to a reference to a struct device which
> isn't refcounted (until I added it with my patch.)  Hence struct
> gendisk structures have a completely independent lifetime and are
> only destroyed when all references to them are removed.

Yes, they are and that's intentional.

Can you explain WTF do you drop that reference so late and not in the
del_gendisk() time?
