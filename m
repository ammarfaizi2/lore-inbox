Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbREBOcI>; Wed, 2 May 2001 10:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135331AbREBOb6>; Wed, 2 May 2001 10:31:58 -0400
Received: from ns.suse.de ([213.95.15.193]:11018 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135344AbREBObk>;
	Wed, 2 May 2001 10:31:40 -0400
Date: Wed, 2 May 2001 16:31:01 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: root@chaos.analogic.com, Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010502163101.A7174@gruyere.muc.suse.de>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B9F@mail0.myrio.com> <Pine.LNX.3.95.1010430145555.15714A-100000@chaos.analogic.com> <15085.47104.75880.572242@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15085.47104.75880.572242@pizda.ninka.net>; from davem@redhat.com on Mon, Apr 30, 2001 at 12:07:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 12:07:44PM -0700, David S. Miller wrote:
> Even more effective is:
> 
> mv /wherever/exeimage /usr/bin/exeimage
> 
> The kernel keeps around the contents of the old file while
> the executing process still runs.
> 
> This is also basically how things like libc get installed.
> A single mv is not only preserves currently referenced contents,
> it is atomic.

But something must have been not working with it for mmaps/shlibs 
(not executables); at least historically.
At least I remember that all hell broke lose when you tried to update
libc by cp'ing a new one to /lib/libc.so in the 1.2 days. cp should create a 
new inode (it uses O_CREAT) so in theory it should be coherent by the inode 
reference; but somehow it didn't use to work and random already running 
programs started to segfault. This was long ago. I wonder if old
GNU cp used O_TRUNC instead of O_CREAT, or was there some other kernel bug 
with mappings (hopefully long since fixed). Anybody remembers? 

-Andi
