Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbREPEJB>; Wed, 16 May 2001 00:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbREPEIv>; Wed, 16 May 2001 00:08:51 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:18638 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261427AbREPEIm>; Wed, 16 May 2001 00:08:42 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE29F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'jalaja devi'" <jala_74@yahoo.com>,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: RE: kernel2.2.x to kernel2.4.x
Date: Tue, 15 May 2001 21:08:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: jalaja devi [mailto:jala_74@yahoo.com]
> 
> I tried porting a network driver from kernel2.2.x to
> 2.4. When i tried loading the driver, it shows the
> unresolved symbols for
> copy_to_user_ret
> outs
> __bad_udelay
> 
> Could anyone please tell me the corresponding fxns in 2.4.

You need to "unroll" copy_to_user_ret().  There is no
corresponding macro.  Just test the condition and return
-EFAULT (?; not looking at the source code) if it's invalid.

Don't know about "outs".

__bad_udelay means that some module used a too-large-parameter-value
to udelay().  Linker should be telling you which module.

~Randy

