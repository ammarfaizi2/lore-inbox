Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268103AbUHFR70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268103AbUHFR70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUHFR7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:59:00 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1152 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266073AbUHFR6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:58:15 -0400
Date: Fri, 6 Aug 2004 19:59:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806175937.GA296@ucw.cz>
References: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 12:18:39PM +0200, Joerg Schilling wrote:

> >> -	ioctl(f, SCSI_IOCTL_GET_IDLUN, &sg_id)) and ioctl(f, SCSI_IOCTL_GET_BUS_NUMBER, &Bus)
> >> 	do not return instance numbers if applied to a fd from /dev/hd*
> >> 
> >> 	This bug has been reported 2 years ago.
> >> 
> >> 	Time to fix: 10 minutes
> 
> >It has been argued several times that we will not doctor bus/id/lun on
> >atapi devices, because it does not make sense. So I'm regarding this as
> >invalid.
> 
> Sorry, I have more than 20 years of experiences in Kernel and Application 
> hacking. I am able to decide myself what is a bug and what is something that
> needs to be called at least "non-orthogonal behavior". This is devinitely 
>  a bug or missing orthogonality. See above to understand (These are 
> primarily SCSI devices and therefore they need to have instance numbers within 
> the set of devices in the SCSI device tree).
> 
> If you do not fix this, you just verify that Linux does not like it's users.
> Linux users like to call cdrecord -scanbus and they like to see _all_ SCSI 
> devices from a single call to cdrecord. The fact that the Linux kernel does not
> return instance numbers for /dev/hd* SCSI devices makes it impossible to
> implement a unique address space :-(
 
I'm a long time Linux and cdrecord user, and I must say I always hated
the -scanbus thingy. It's so much easier to just pass the /dev/hdc
device node, where I _know_ my CD burner lives than to have to figure
out what fake SCSI address cdrecord has made up and requires me to pass
to it, even when I have just a single CD burner in my system.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
