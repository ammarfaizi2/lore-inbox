Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUBJQZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265984AbUBJQZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:25:22 -0500
Received: from aun.it.uu.se ([130.238.12.36]:52649 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265983AbUBJQZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:25:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16425.1494.747797.896644@alkaid.it.uu.se>
Date: Tue, 10 Feb 2004 17:24:54 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: RE: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/messag
	 e/fusion/mptctl.c
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703D1A8BE@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E5703D1A8BE@exa-atlanta.se.lsil.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moore, Eric Dean writes:
 > If we pass NULL as the 2nd parameter for register_ioctl32_conversion(),
 > the mpt_ioctl() entry point is *not* called when running a 32 bit
 > application in x86_64 mode.

Ok, but you still don't need sys_ioctl() since the one-liner

 > > filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg)

(or a hardcoded call to your ioctl() method) suffices.

sys_ioctl() mostly just checks for special case ioctls before
doing the line above, but those special cases can't occur
since the kernel has already matched your particular ioctl.

/Mikael
