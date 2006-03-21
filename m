Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWCUUdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWCUUdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWCUUdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:33:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42389 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751750AbWCUUdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:33:47 -0500
Date: Tue, 21 Mar 2006 20:33:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Phillip Lougher <phillip@lougher.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321203340.GI27946@ftp.linux.org.uk>
References: <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk> <20060321201541.GF3929@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321201541.GF3929@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 09:15:41PM +0100, Pavel Machek wrote:
> Hi!
> 
> > >Can you try to benchmark it? I believe it is going to be lost in
> > >noise, slow cpus or not.
> > 
> > Good idea, I'll try to benchmark it (on a slow CPU if I can find one :-) 
> > ).  It will probably make no difference.
> > 
> > I don't want the lack of a fixed endianness on disk to become a problem. 
> >   I personally don't think the use of, or lack of a fixed endianness to 
> > be that important, but I'd prefer not to change the current situation 
> > and adopt a fixed format.  I use big endian systems almost exclusively, 
> > and I don't like the way fixed formats always tend to be little-endian.
> 
> Fix it to big-endian, then. Network protocols are big-endian, anyway,
> and PCs tend to be so fast that byteswap will be lost in cache misses,
> anyway.

Note that "sometimes we swap" approach tends to create tons of bugs.
It's much easier to keep track of "this variable is host-endian, this
one is big-endian" and have appropriate conversions where needed.  Trying
to keep track of how many times we need to swap on this, this and that
codepath, OTOH, almost always ends up buggy.
