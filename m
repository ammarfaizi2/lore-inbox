Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUBJQMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBJQMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:12:17 -0500
Received: from mail0.lsil.com ([147.145.40.20]:29921 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S265969AbUBJQMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:12:15 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703D1A8BE@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: RE: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/messag
	 e/fusion/mptctl.c
Date: Tue, 10 Feb 2004 11:10:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we pass NULL as the 2nd parameter for register_ioctl32_conversion(),
the mpt_ioctl() entry point is *not* called when running a 32 bit
application in x86_64 mode.

The problem comes down to a couple IOCTL structures in mptctl.h are having
pointers and longs, and are incompatible between 32bit and 64 bit mode.
The register conversion function copy the data to proper packing, and
doesn't require people in the field to have to recompile their applications.

EXPORT_SYMBOL(sys_ioctl) is already there in s390x, ppc64, and sparc64 for
generic kernels, and in Redhat/SuSE kernels they have
EXPORT_SYMBOL(sys_ioctl)
under x86_64.


Eric Moore


On Tuesday, February 10, 2004 2:47 AM, Mikael Pettersson wrote:
> Can't you just use register_ioctl32_conversion()'s convention that
> a NULL handler defaults to sys_ioctl? Alternatively you could just
> write the one-liner 
> 
> filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg)
> 
> in your handler.
> 
