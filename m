Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbQKNM3U>; Tue, 14 Nov 2000 07:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130458AbQKNM3K>; Tue, 14 Nov 2000 07:29:10 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:12295 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129921AbQKNM2y>; Tue, 14 Nov 2000 07:28:54 -0500
Date: Tue, 14 Nov 2000 11:58:52 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: Malcolm Beattie <mbeattie@sable.ox.ac.uk>, Keith Owens <kaos@ocs.com.au>,
        Peter Samuelson <peter@cadcamlab.org>,
        Chris Evans <chris@scary.beasts.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Modprobe local root exploit
In-Reply-To: <20001114055409.K1514@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0011141157520.10863-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2000, Jakub Jelinek wrote:

> > Rather than add sanity checking to modprobe, it would be a lot easier
> > and safer from a security audit point of view to have the kernel call
> > /sbin/kmodprobe instead of /sbin/modprobe. Then kmodprobe can sanitise
> > all the data and exec the real modprobe. That way the only thing that
> > needs auditing is a string munging/sanitising program.
>
> Well, no matter what kernel needs auditing as well, the fact that dev_load
> will without any check load any module the user wants is already problematic
> and no munging helps with it at all, especially loading old ISA drivers
> might not be a good idea.

FWIW: A quick look at the kernel source, and dev_load() seems to be the
only place that does this. Other places apply prefixes to user supplied
names.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
