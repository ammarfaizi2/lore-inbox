Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRECS5T>; Thu, 3 May 2001 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRECS5J>; Thu, 3 May 2001 14:57:09 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:29934 "EHLO
	lynx.turbolabs.com") by vger.kernel.org with ESMTP
	id <S131644AbRECS44>; Thu, 3 May 2001 14:56:56 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105022217.QAA05053@lynx.turbolabs.com>
Subject: Re: 2.4 and 2GB swap partition limit
To: ak@suse.de (Andi Kleen)
Date: Wed, 2 May 2001 16:17:21 -0600 (MDT)
Cc: davem@redhat.com (David S. Miller), root@chaos.analogic.com,
        torrey.hoffman@myrio.com (Torrey Hoffman),
        ken@canit.se ('Kenneth Johansson'),
        jlundell@pobox.com (Jonathan Lundell), linux-kernel@vger.kernel.org
In-Reply-To: <20010502163101.A7174@gruyere.muc.suse.de> from "Andi Kleen" at May 02, 2001 04:31:01 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> On Mon, Apr 30, 2001 at 12:07:44PM -0700, David S. Miller wrote:
> But something must have been not working with it for mmaps/shlibs 
> (not executables); at least historically.
> At least I remember that all hell broke lose when you tried to update
> libc by cp'ing a new one to /lib/libc.so in the 1.2 days. cp should create a 
> new inode (it uses O_CREAT) so in theory it should be coherent by the inode 
> reference; but somehow it didn't use to work and random already running 
> programs started to segfault. This was long ago. I wonder if old
> GNU cp used O_TRUNC instead of O_CREAT, or was there some other kernel bug 
> with mappings (hopefully long since fixed). Anybody remembers? 

No, "cp" is still not a safe way to update libc, and I doubt it ever will be.
cp does _not_ create a new inode (unlike mv), so you are writing "garbage"
into the currently running executables.

NB: my open(2) says for O_CREAT "If the file does not exist it will be
created".  This is _not_ the same as O_EXCL, which will only mean that
open(2) will fail when it tries to create a new file.

Cheers, Andreas
-- 
Andreas Dilger                               Turbolinux filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
