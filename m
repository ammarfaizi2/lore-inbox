Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRIJPSk>; Mon, 10 Sep 2001 11:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271214AbRIJPSU>; Mon, 10 Sep 2001 11:18:20 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26898 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271165AbRIJPSP>; Mon, 10 Sep 2001 11:18:15 -0400
Date: Mon, 10 Sep 2001 17:18:36 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010910171836.C26229@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> <20010910122603.80CA4BC06C@spike.porcupine.org> <20010910145325.X26627@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910145325.X26627@khan.acc.umu.se>; from tao@acc.umu.se on Mon, Sep 10, 2001 at 14:53:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, David Weinehall wrote:

> "[snip] old and the new stuff, please name precisely the objections
> against portability and compatibility with FreeBSD 4.x aliasing."
>                                            ^^^^^^^^^^^^^^^^^^^^
> This is what lead me to my conclusion. Care to clarify? If you simply
> meant SIOCGIFNETMASK, why not write that instead instead of involving
> FreeBSD 4.x?!

Dave, I came up with that because the same piece of code I looked at
choked on Linux 2.4, but not on FreeBSD 4.4-RC. I tracked this down,
fixed it and sent the patch.  This can all be read from my posts to the
thread.

The issue here is:

1/ Linux returns ALL addresses to SIOCGIFCONF, no matter if these are visible
to SIOCGIFNETMASK or not. Invisible addresses are the second and
subsequent addresses added with ip addr add without using a distinct
label. This means the innocent application that just feeds the
SIOCGIFCONF results into SIOCGIFNETMASK will get the netmask for the
first address. Of course, you can "filter" the addresses through
SIOCGIFADDR and drop the duplicates after that, but why not fix it for
the better?

2/ FreeBSD also uses IP aliases without "logical" interface names such
as eth0:0

3/ FreeBSD returns the netmask for the requested address, Linux returns
the netmask for the first address of the interface.

4/ I sent a patch to enhance the compatibility with "nameless" IP
aliases.

If you talk about NOT fixing the SIOCG* ioctl API, then fix SIOCGIFCONF
to just return one address per interface regardless how many IPs it
listens to.

But this has all been through. Reread my mails, please.
