Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUBZCpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUBZCpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:45:08 -0500
Received: from lists.us.dell.com ([143.166.224.162]:56294 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261528AbUBZCox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:44:53 -0500
Date: Wed, 25 Feb 2004 20:44:10 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al pha1
Message-ID: <20040225204410.A28880@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com>; from Atulm@lsil.com on Wed, Feb 25, 2004 at 06:05:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 06:05:43PM -0500, Mukker, Atul wrote:
> Thanks a lot for the valuable feedback. The general consensus is against a
> single driver for different class of controllers. This would put a strain on
> our applications, which expect all the controllers to be exported from
> single driver's private ioctl interface.
> 
> With multiple adapters, applications would need to open multiple handles.
> This would somewhat complicate things for them. But keeping in line with
> general expectations, we would fork the drivers for different class of
> controllers now.

It probably isn't difficult to add this to the applications, but since
I haven't seen the source code to them, it's hard to say.  When I
modified efibootmgr to handle either /proc-style or /sys-style
entries, whichever was present, it wasn't difficult, and really made
the code cleaner.  I wouldn't think your tools would be that much more difficult.

As Jeff hinted, if your userspace<->driver ABI is consistent between
your new MPT-based RAID controllers and your existing megaraid driver,
then perhaps you need a single small helper module (lsiioctl or some
better name), loaded by both mptraid and megaraid automatically, which
handles registering the /dev/megaraid node dynamically.  In this case,
both mptraid and megaraid would register with lsiioctl for each
adapter discovered, and lsiioctl would essentially be a switch,
redirecting userspace tool ioctls to the appropriate driver.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
