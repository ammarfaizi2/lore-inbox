Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVCBLfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVCBLfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCBLfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:35:13 -0500
Received: from smtp08.web.de ([217.72.192.226]:10166 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262272AbVCBLer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:34:47 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: x86_64: 32bit emulation problems
Date: Wed, 2 Mar 2005 12:33:56 +0100
User-Agent: KMail/1.7.2
Cc: Andi Kleen <ak@muc.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <20050302081858.GA7672@muc.de> <1109754818.10407.48.camel@lade.trondhjem.org>
In-Reply-To: <1109754818.10407.48.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021233.57341.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 10:13, Trond Myklebust wrote:
> on den 02.03.2005 Klokka 09:18 (+0100) skreiv Andi Kleen:
> > On Wed, Mar 02, 2005 at 12:46:23AM +0100, Andreas Schwab wrote:
> > > Bernd Schubert <bernd-schubert@web.de> writes:
> > > > Hmm, after compiling with -D_FILE_OFFSET_BITS=64 it works fine. But
> > > > why does it work without this option on a 32bit kernel, but not on a
> > > > 64bit kernel?
> > >
> > > See nfs_fileid_to_ino_t for why the inode number is different between
> > > 32bit and 64bit kernels.
> >
> > Ok that explains it. Thanks.

Many thanks also from me!

> >
> > Best would be probably to just do the shift unconditionally on 64bit
> > kernels too.
> >
> > Trond, what do you think?
>
> Why would this be more appropriate than defining __kernel_ino_t on the
> x86_64 platform to be of the size that you actually want the kernel to
> support?
>
> I can see no good reason for truncating inode number values on platforms
> that actually do support 64-bit inode numbers, but I can see several

Well, at least we would have a reason ;)

> reasons why you might want not to (utilities that need to detect hard
> linked files for instance).

Anyway, glibc already seems to have a condition for that, so IMHO glibc also 
could truncate the inode numbers if needed. And finally glibc probably knows 
best if its compiled as 32bit or 64bit. Will take a look into the glibc 
sources.

Many, many thanks to all for their help!

Best wishes,
 Bernd
