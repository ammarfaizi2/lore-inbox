Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbSJ3OLF>; Wed, 30 Oct 2002 09:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSJ3OLF>; Wed, 30 Oct 2002 09:11:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35847 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264689AbSJ3OK6>;
	Wed, 30 Oct 2002 09:10:58 -0500
Date: Wed, 30 Oct 2002 14:17:20 +0000
From: Matthew Wilcox <willy@debian.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
Message-ID: <20021030141720.V27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> > A r/w compressed filesystem would be darned useful too :)
> 
> mmap(2) is, err, hard. Not impossible, it means the file system has to
> support both compressed and uncompressed files, but it's interesting.

Easier than you think, perhaps.  Depends how much compression you're
after, of course, but here's how Acorn did it in RISCiX (a 4.3BSD
derivative):

Pages were 32k (an interesting feature of the MMU...), and the underlying
filesystem was a fairly vanilla BSD FFS (probably 4k blocks with 1k
fragments; discs were around 50MB).  Each page was written at a 32k
boundary, but compressed.  So there were holes in the file where other
files could store their data.  Naturally you waste on average 512 bytes
per 32k page, but I think they managed to get 80MB of unix distro onto
a 50MB disc this way, so it's nothing to be sneezed at.

-- 
Revolutions do not require corporate support.
