Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135912AbREDIRX>; Fri, 4 May 2001 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135913AbREDIRO>; Fri, 4 May 2001 04:17:14 -0400
Received: from ns.suse.de ([213.95.15.193]:29966 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135912AbREDIRC>;
	Fri, 4 May 2001 04:17:02 -0400
Date: Fri, 4 May 2001 10:16:51 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
        root@chaos.analogic.com, Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010504101651.A20294@gruyere.muc.suse.de>
In-Reply-To: <20010502163101.A7174@gruyere.muc.suse.de> <200105022217.QAA05053@lynx.turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105022217.QAA05053@lynx.turbolabs.com>; from adilger@turbolinux.com on Wed, May 02, 2001 at 04:17:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 04:17:21PM -0600, Andreas Dilger wrote:
> Andi Kleen writes:
> > On Mon, Apr 30, 2001 at 12:07:44PM -0700, David S. Miller wrote:
> > But something must have been not working with it for mmaps/shlibs 
> > (not executables); at least historically.
> > At least I remember that all hell broke lose when you tried to update
> > libc by cp'ing a new one to /lib/libc.so in the 1.2 days. cp should create a 
> > new inode (it uses O_CREAT) so in theory it should be coherent by the inode 
> > reference; but somehow it didn't use to work and random already running 
> > programs started to segfault. This was long ago. I wonder if old
> > GNU cp used O_TRUNC instead of O_CREAT, or was there some other kernel bug 
> > with mappings (hopefully long since fixed). Anybody remembers? 
> 
> No, "cp" is still not a safe way to update libc, and I doubt it ever will be.
> cp does _not_ create a new inode (unlike mv), so you are writing "garbage"
> into the currently running executables.

Ok, the bug is that executable shlibs mappings do not get EBUSY as when you try
to write into a running executable and it's still not fixed.

> NB: my open(2) says for O_CREAT "If the file does not exist it will be
> created".  This is _not_ the same as O_EXCL, which will only mean that
> open(2) will fail when it tries to create a new file.

I assumed it would just create a new inode; but seems I was wrong.
Thanks for the clarification.


-Andi
