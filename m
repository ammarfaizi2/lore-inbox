Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132828AbRDQTWL>; Tue, 17 Apr 2001 15:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132831AbRDQTWB>; Tue, 17 Apr 2001 15:22:01 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16903 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132828AbRDQTVl>; Tue, 17 Apr 2001 15:21:41 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFC: pageable kernel-segments
Date: 17 Apr 2001 12:21:17 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bi53d$5n6$1@cesium.transmeta.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl>
By author:    "Heusden, Folkert van" <f.v.heusden@ftr.nl>
In newsgroup: linux.dev.kernel
>
> Would anyone be intrested (besides me) in a kernel which can page
> out certain parts of itself? The kernel should be in some kind of
> vmlinux-ish (as in: uncompressed) format on disk for on-demand
> re-loading of pages which are discarded.
> Certain parts of drivers could get the __pageable prefix or so
> (like the __init parts of drivers which get removed) for letting
> the paging-code know that it can be discared if memory-pressure
> demands it.
> __pageable -code would then be things like (e.g.!) the code which
> handles the open()/close() of a device. Most of the time a device
> spends more time doing read/write/ioctl then close/open so. Also;
> hopefully there's no interrupt-sensitive code in these routines.
> I would think is usable (for example) for my 8MB ram laptop.
> Anyone any thoughts on this?
> 

VMS does this.  It at least used to have a great tendency to crash
itself, because it swapped out something that was called from a driver
that was called by the swapper -- resulting in deadlock.  You need
iron discipline for this to work right in all circumstances.

Second, it makes it quite hard to know what operations can cause a
task to sleep, since any reference to paged-out memory can require a
page-in and the associated schedule.  You almost need pointer
annotation in order for this to be safe.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
