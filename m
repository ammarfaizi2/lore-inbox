Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262595AbTCKAeM>; Mon, 10 Mar 2003 19:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbTCKAeM>; Mon, 10 Mar 2003 19:34:12 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:63900 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262595AbTCKAeD>; Mon, 10 Mar 2003 19:34:03 -0500
Date: Mon, 10 Mar 2003 17:44:03 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: dougg@torque.net, linux-kernel@vger.kernel.org
Subject: Re: Adaptec driver build noise in 2.5.64
Message-ID: <682920000.1047343443@aslan.btc.adaptec.com>
In-Reply-To: <679190000.1047343047@aslan.btc.adaptec.com>
References: <3E6AE794.5060909@torque.net> <679190000.1047343047@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Moved to linux-kernel as this is not a SCSI specific issue ]
[ Subject changed to avoid x x x spam filter at kernel.org <sigh> ]
 
> In 2.5.64 (+ .63 + .64bk3) at the end of a 'make bzImage'
> I see:
> 
> ....
> make -rR -f scripts/Makefile.modpost
>    scripts/modpost vmlinux drivers/scsi/advansys.o ...
> ... fs/vfat/vfat.o lib/zlib_deflate/zlib_deflate.o
> *** Warning: Can't handle class_mask in
>   	   drivers/scsi/aic7xxx/aic79xx:FFFF00
> *** Warning: Can't handle class_mask in
>             drivers/scsi/aic7xxx/aic7xxx:FFFF00
> *** Warning: Can't handle class_mask in
>             drivers/scsi/aic7xxx/aic7xxx:FFFF00

The mask is correct.  The tool not groking it is broken.
In otherwords, the class is only 16bits and it is offset by
8 bits into the class variable in the pci device.  I could
switch to using ~0 and things will probably just work, but
why have a mask at all if it must be "all bits set" in order
for the tools to not complain?

--
Justin




