Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbTIEB2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTIEB2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:28:01 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:18833 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262014AbTIEB15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:27:57 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
Date: Fri, 5 Sep 2003 03:31:38 +0200
User-Agent: KMail/1.5.3
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309041748290.13736-100000@home.osdl.org> <1062724028.23305.14.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062724028.23305.14.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309050331.38597.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 03:07, Alan Cox wrote:
> On Gwe, 2003-09-05 at 01:49, Linus Torvalds wrote:
> > What really matters is that mmap() under Linux is 100% coherent, as far
> > as the hardware just allows. We haven't taken the easy way out. We
> > shouldn't start now.
>
> NFS ?

NFS doesn't attempt to implement local Posix semantics, but a DFS should.  
Anyway, Linus has ruled we're being held to the higher standard of "Linux 
semantics".

> The problem with OpenGFS is that it is a network file system so
> implementing "perfect" shared mmap semantics might actually reduce it
> from handy to useless. Right now the worst we have to do is mark pages
> uncached in some weird shared map cases, with pages being bounced across
> firewire its a bit different.

Sistina has been doing it the "perfect" way for some time now, and it's worked 
out OK.  This relies on writes being rare.

Things will definitely slow to a crawl if several nodes keep writing little 
bits into the same mmap, but that's a case of "doctor it hurts" I think.  If 
there's a common application that does this, I'd appreciate knowing about it.

Regards,

Daniel

