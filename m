Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVCBJNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVCBJNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVCBJNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:13:52 -0500
Received: from pat.uio.no ([129.240.130.16]:57762 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262234AbVCBJNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:13:50 -0500
Subject: Re: x86_64: 32bit emulation problems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@muc.de>
Cc: Andreas Schwab <schwab@suse.de>, Bernd Schubert <bernd-schubert@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050302081858.GA7672@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	 <200503012207.02915.bernd-schubert@web.de> <jewtsruie9.fsf@sykes.suse.de>
	 <200503020019.20256.bernd-schubert@web.de> <jebra3udyo.fsf@sykes.suse.de>
	 <20050302081858.GA7672@muc.de>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 01:13:38 -0800
Message-Id: <1109754818.10407.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.349, required 12,
	autolearn=disabled, AWL 0.65, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 02.03.2005 Klokka 09:18 (+0100) skreiv Andi Kleen:
> On Wed, Mar 02, 2005 at 12:46:23AM +0100, Andreas Schwab wrote:
> > Bernd Schubert <bernd-schubert@web.de> writes:
> > 
> > > Hmm, after compiling with -D_FILE_OFFSET_BITS=64 it works fine. But why does 
> > > it work without this option on a 32bit kernel, but not on a 64bit kernel?
> > 
> > See nfs_fileid_to_ino_t for why the inode number is different between
> > 32bit and 64bit kernels.
> 
> Ok that explains it. Thanks.
> 
> Best would be probably to just do the shift unconditionally on 64bit kernels
> too.
> 
> Trond, what do you think?

Why would this be more appropriate than defining __kernel_ino_t on the
x86_64 platform to be of the size that you actually want the kernel to
support?

I can see no good reason for truncating inode number values on platforms
that actually do support 64-bit inode numbers, but I can see several
reasons why you might want not to (utilities that need to detect hard
linked files for instance).

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

