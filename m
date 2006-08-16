Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWHPXzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWHPXzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWHPXzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:55:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26383 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932136AbWHPXzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:55:00 -0400
Date: Thu, 17 Aug 2006 01:54:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060816235459.GM7813@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816223633.GA3421@hera.kernel.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 10:36:33PM +0000, Willy Tarreau wrote:

> Hi !

Hi Willy!

>...
> I've been reluctant at first for the usual reasons : "who has a 2.4
> distro with gcc4 ?", and after recalling all the trouble Marcelo
> had to deal with during the gcc3 update. But after discussion with
> some people, I realized that the problem is not here, it's for the
> kernels those people have to maintain for other systems (eg: servers,
> firewalls, etc...) and which they suddenly cannot build anymore after
> they have updated the distro on their desktop PC.
>...
> Since most of them were sleeping bugs waiting for someone to wake
> them up, I considered it was worth merging them provided that we
> observe no regression. So I have created a separate tree for it
> that I will merge into mainline in a few pre-releases if we don't
> encounter any problem.
>...

My points against allowing to compile kernel 2.4 with gcc 4 are:

- There isn't much testing coverage - and will never be much testing
  coverage - of using a kernel 2.4 compiled with gcc 4.
  We've already seen several cases where only some compiler versions
  caused miscompilations or exposed a runtime bug in the kernel.
  Since there shouldn't be any reason for still using a 2.4 kernel
  except for "never change a running system", I don't see a good
  reason for allowing such an untested gcc/kernel combination.

- Even if your distribution does no longer ship any gcc 3, it's
  easy building and using your own gcc 3.4.6:
    wget ftp://ftp.gnu.org/gnu/gcc/gcc-3.4.6/gcc-3.4.6.tar.bz2
    tar xjf gcc-3.4.6.tar.bz2
    mkdir build-gcc
    cd build-gcc
    ../gcc-3.4.6/configure --enable-languages=c --prefix=/usr/local/gcc-3.4.6
    make bootstrap
    make install
    # change HOSTCC and CC in the toplevel Makefile of the kernel:
    # HOSTCC = /usr/local/gcc-3.4.6/bin/gcc
    # CC = /usr/local/gcc-3.4.6/bin/gcc

> Regards,
> Willy
>...

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

