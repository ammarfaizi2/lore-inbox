Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQKNLYu>; Tue, 14 Nov 2000 06:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQKNLYl>; Tue, 14 Nov 2000 06:24:41 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:8716 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129429AbQKNLYa>; Tue, 14 Nov 2000 06:24:30 -0500
Date: Tue, 14 Nov 2000 05:54:10 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Cc: Keith Owens <kaos@ocs.com.au>, Peter Samuelson <peter@cadcamlab.org>,
        Torsten.Duwe@caldera.de, Chris Evans <chris@scary.beasts.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
Message-ID: <20001114055409.K1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20001113230210.F18203@wire.cadcamlab.org> <3864.974181019@kao2.melbourne.sgi.com> <20001114104240.A30388@sable.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001114104240.A30388@sable.ox.ac.uk>; from mbeattie@sable.ox.ac.uk on Tue, Nov 14, 2000 at 10:42:41AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 10:42:41AM +0000, Malcolm Beattie wrote:
> Keith Owens writes:
> > All these patches against request_module are attacking the problem at
> > the wrong point.  The kernel can request any module name it likes,
> > using any string it likes, as long as the kernel generates the name.
> > The real problem is when the kernel blindly accepts some user input and
> > passes it straight to modprobe, then the kernel is acting like a setuid
> > wrapper for a program that was never designed to run setuid.
> 
> Rather than add sanity checking to modprobe, it would be a lot easier
> and safer from a security audit point of view to have the kernel call
> /sbin/kmodprobe instead of /sbin/modprobe. Then kmodprobe can sanitise
> all the data and exec the real modprobe. That way the only thing that
> needs auditing is a string munging/sanitising program.

Well, no matter what kernel needs auditing as well, the fact that dev_load
will without any check load any module the user wants is already problematic
and no munging helps with it at all, especially loading old ISA drivers
might not be a good idea.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
