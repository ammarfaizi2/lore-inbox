Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVCCJO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVCCJO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCCJO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:14:27 -0500
Received: from colin2.muc.de ([193.149.48.15]:2821 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261733AbVCCJMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:12:53 -0500
Date: 3 Mar 2005 10:12:51 +0100
Date: Thu, 3 Mar 2005 10:12:51 +0100
From: Andi Kleen <ak@muc.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andreas Schwab <schwab@suse.de>, Bernd Schubert <bernd-schubert@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050303091251.GB5215@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <200503012207.02915.bernd-schubert@web.de> <jewtsruie9.fsf@sykes.suse.de> <200503020019.20256.bernd-schubert@web.de> <jebra3udyo.fsf@sykes.suse.de> <20050302081858.GA7672@muc.de> <1109754818.10407.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109754818.10407.48.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 01:13:38AM -0800, Trond Myklebust wrote:
> on den 02.03.2005 Klokka 09:18 (+0100) skreiv Andi Kleen:
> > On Wed, Mar 02, 2005 at 12:46:23AM +0100, Andreas Schwab wrote:
> > > Bernd Schubert <bernd-schubert@web.de> writes:
> > > 
> > > > Hmm, after compiling with -D_FILE_OFFSET_BITS=64 it works fine. But why does 
> > > > it work without this option on a 32bit kernel, but not on a 64bit kernel?
> > > 
> > > See nfs_fileid_to_ino_t for why the inode number is different between
> > > 32bit and 64bit kernels.
> > 
> > Ok that explains it. Thanks.
> > 
> > Best would be probably to just do the shift unconditionally on 64bit kernels
> > too.
> > 
> > Trond, what do you think?
> 
> Why would this be more appropriate than defining __kernel_ino_t on the
> x86_64 platform to be of the size that you actually want the kernel to
> support?
> I can see no good reason for truncating inode number values on platforms
> that actually do support 64-bit inode numbers, but I can see several

If you include 32bit emulation x86-64 doesn't support them. 
I guess you could make it dependent on CONFIG_COMPAT, but I expect
near all people running an x86-64 to have it set.

> reasons why you might want not to (utilities that need to detect hard
> linked files for instance).

32bit compatibility is a good reason. 32bit compatibility 
is fairly important

Afaik the only "pure" 64bit architecture without 32bit emulation
is Alpha. In theory you could enable it unconditionally there,
but I'm not sure it's worth it.


-Andi
