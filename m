Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUFKEZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUFKEZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 00:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUFKEZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 00:25:08 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:50354 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S263750AbUFKEZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 00:25:03 -0400
Date: Fri, 11 Jun 2004 06:31:07 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: linux-usb-devel@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, greg@kroah.com
Cc: rtjohnso@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: [linux-usb-devel] Re: Finding user/kernel pointer bugs [no html]
Message-Id: <20040611063107.0c62e2f8.luca.risolia@studio.unibo.it>
In-Reply-To: <E1BYXuJ-0006vd-RU@sc8-sf-list1.sourceforge.net>
References: <E1BYXuJ-0006vd-RU@sc8-sf-list1.sourceforge.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>                    unsigned int cmd, void* arg)
>  {
>  	struct w9968cf_device* cam;
> +	void __user *user_arg = (void __user *)arg;

The right place to apply this patch is in video_usercopy().

When video_usercopy() is used in the ioctl() method, there is no need
to dereference the arg pointer in ioctl() itself, since one of the purposes
of video_usercopy() is to do this work for us.

Please have a look at definition of the function in videodev.c.

int
video_usercopy(struct inode *inode, struct file *file,
               unsigned int cmd, unsigned long arg,
               int (*func)(struct inode *inode, struct file *file,
                           unsigned int cmd, unsigned void *arg))

What you have patched in your patch is the function pointed
by "func" above, which should already receive the __user pointer to arg.

Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAyTWLmdpdKvzmNaQRAhDuAJ0e8okB48LQUaHnxZsSS0ZFTmuxRQCgnYqZ
WECeSegLUG5WDyUArFcByKU=
=u+vB
-----END PGP SIGNATURE-----
