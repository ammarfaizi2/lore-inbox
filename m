Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRCWGwf>; Fri, 23 Mar 2001 01:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRCWGwZ>; Fri, 23 Mar 2001 01:52:25 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:1807 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129719AbRCWGwL>;
	Fri, 23 Mar 2001 01:52:11 -0500
Date: Fri, 23 Mar 2001 07:51:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Amit D Chaudhary <amit@muppetlabs.com>
Cc: lermen@fgan.de, linux-kernel@vger.kernel.org
Subject: Re: /linuxrc query
Message-ID: <20010323075107.Q3932@almesberger.net>
In-Reply-To: <3ABAEED2.6020708@muppetlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ABAEED2.6020708@muppetlabs.com>; from amit@muppetlabs.com on Thu, Mar 22, 2001 at 10:36:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit D Chaudhary wrote:
> what does redirecting stdin\stdout\stderr to dev/console achieve? I thought 
> since the root is now the "new" root, dev/console will be used automatically?

No, you would continue using the file descriptors which are already
open, i.e. on /dev/console on the old root.

> Also, why chroot, why not call init directly?

To make sure the root of the current process is indeed changed.
pivot_root currently forces a chroot on all processes (except the
ones that have explicitly moved out of /) in order to move all the
kernel threads too, but this is not a nice solution. Once a better
solution is implemented for the kernel threads, we might drop the
forced chroot, and then the explicit chroot here becomes important.

> Since the above never returns, what follows in not freed.

You can run them later, e.g. /etc/rc.d/rc.local
Or, if you needs the space immediately,  make "what-follows" a
script than first frees them, and then exec's init.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
