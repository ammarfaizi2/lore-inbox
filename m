Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284295AbRLBTmL>; Sun, 2 Dec 2001 14:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284283AbRLBTmC>; Sun, 2 Dec 2001 14:42:02 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10943 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284286AbRLBTlq>; Sun, 2 Dec 2001 14:41:46 -0500
Date: Sun, 2 Dec 2001 12:41:48 -0700
Message-Id: <200112021941.fB2Jfmg12171@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: andrew may <acmay@acmay.homeip.net>,
        Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
In-Reply-To: <E16Ac1n-0001Bd-00@mrvdom00.schlund.de>
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de>
	<20011201180940.B21185@ecam.san.rr.com>
	<200112021847.fB2IlmZ11175@vindaloo.ras.ucalgary.ca>
	<E16Ac1n-0001Bd-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@borntraeger.net writes:
> I found the reason for these messages. It has a boot-script source.
> Mandrake stores the attributes of device nodes in /lib/dev-state.
> This directory is copied into /dev directly before devfsd is started.

OK, clean out stuff you don't need in /lib/dev-state. Check your
devfsd configuation to see if /lib/dev-state is being repopulated
automatically. If so, grab devfsd-v1.3.20 and use the new RESTORE
directive. This is the correct way to handle persistence. Remove the
boot-script code which populates from /lib/dev-state.

> If there is a device file in /lib/dev-state it is created in /dev
> even before the driver is loaded.  When the driver is loaded it
> tries again to create the node and the message appears.

OK, I suspected as much. Good. Thanks for tracking this down.
Attempting to create the same entry twice *should* yield EEXIST on the
second try. The new devfs is strict about this, the old one wasn't.

I consider this issue closed. I'd suggest you contact Mandrake and get
them to upgrade to devfsd-v1.3.20, remove the boot script code and use
the RESTORE directive instead. This requires v1.2 of the devfs core
(found in 2.4.17-pre1).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
