Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSGWIYI>; Tue, 23 Jul 2002 04:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSGWIYH>; Tue, 23 Jul 2002 04:24:07 -0400
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:21008 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317997AbSGWIYG>; Tue, 23 Jul 2002 04:24:06 -0400
Date: Tue, 23 Jul 2002 09:26:55 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020723082655.GC1393@fib011235813.fsnet.co.uk>
References: <OF493E1C65.D443AFFF-ON85256BFE.005D57E7@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF493E1C65.D443AFFF-ON85256BFE.005D57E7@pok.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:31:11PM -0500, Ben Rafanello wrote:
> I believe you are referring to Device Mapper, which could, in theory,
> handle the AIX metadata layout.  However, AFAIK, there are no tools
> currently available or under development for Device Mapper to make
> this happen.  Currently, EVMS is the only way to read/write to AIX
> volumes under Linux.

This is absolutely correct, LVM2 does not currently support AIX
metadata.  However the LVM2 tools were designed to support multiple
metadata formats, and it really would be very little work to write the
code to do this (after all this is just a little bit of userland code,
rather than kernel code in EVMS).  ATM Sistina are not willing to pay
for this work, so it will have to come from some other part of the
community.

> EVMS can snapshot anything it sees - partitions, LVM volumes, MD devices,
> OS/2 volumes, AIX volumes, etc.  LVM2 does do snapshots of LVM2 volumes,
> but if it isn't an LVM volume, LVM2 can not snapshot it.  Device Mapper,
> however, could snapshot partitions and other non-LVM volumes if only the
> tools were available.

There is a little tool called dmsetup:

http://people.sistina.com/~thornber/dmsetup_8.html

that is essentially a very simple volume manager.  But it does give
you full access to all the facilities of device-mapper.  eg, I just
used it to create writeable snapshots of a CD, very useful for
demonstrating distros.  LVM2 will support physical volumes that it is
not allowed to write metadata to very soon.

>  As for resizing partitions, EVMS has the code to
> manipulate partition tables, including the resizing of partitions.  There
> does not appear to be anything in either LVM2 or Device Mapper for
> manipulating partition tables and resizing partitions.

There will never be partition manipulation code in LVM2, there are
plenty of excellent tools for resizing partitions (eg, parted).  We
have better things to do than reinventing wheels.

Personally I would remove the partition recognition code from the
kernel completely, and setup partitions from userland using
device-mapper.  You need root permissions to read a partition table,
*not* kernel perms.  But somehow I can't see people going along with
this plan :)

- Joe

