Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVCCVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVCCVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVCCVml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:42:41 -0500
Received: from pat.uio.no ([129.240.130.16]:56800 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262610AbVCCVhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:37:41 -0500
Subject: Re: x86_64: 32bit emulation problems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@muc.de>
Cc: Bernd Schubert <bernd-schubert@web.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303091908.GC5215@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	 <20050302081858.GA7672@muc.de>
	 <1109754818.10407.48.camel@lade.trondhjem.org>
	 <200503021233.57341.bernd-schubert@web.de>
	 <1109782387.9667.11.camel@lade.trondhjem.org>
	 <20050303091908.GC5215@muc.de>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 13:37:26 -0800
Message-Id: <1109885846.10094.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.729, required 12,
	autolearn=disabled, AWL 1.27, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 03.03.2005 Klokka 10:19 (+0100) skreiv Andi Kleen:
> The problem here is that glibc uses stat64() which supports
> 64bit inode numbers. But glibc does the overflow checking itself
> and generates the EOVERFLOW in user space. Nothing we can do
> about that. The 64bit inodes work under 32bit too, so your
> code checking for 64bitness is totally bogus.

As far as the kernel is concerned, asm/posix_types defines
__kernel_ino_t as "unsigned long" on most platforms (except a few which
define is as "unsigned int). We don't care what size type glibc itself
uses.

> The old stat interface doesn't check that case currently either
> (will fix that), but that's not the problem here.
> 
> But in general the emulation layer cannot do truncation because
> it doesn't know if it is ok to do for the low level file system.
> If anything this has to be done in the fs.

Inode numbers are provided for informational reasons only. There are no
POSIX or SUSv3 interfaces that take an inode number as an argument. The
only processing you can do with an inode number is to compare it for
equality to another inode number.

So I don't see how the file system would be able to do a better job of
truncation here. In principle you should *never* truncate inode numbers.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

