Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUEAPBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUEAPBj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 11:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEAPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 11:01:39 -0400
Received: from colin2.muc.de ([193.149.48.15]:59409 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262060AbUEAPBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:01:37 -0400
Date: 1 May 2004 17:01:36 +0200
Date: Sat, 1 May 2004 17:01:36 +0200
From: Andi Kleen <ak@muc.de>
To: Michael Brown <mebrown@michaels-house.net>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
Message-ID: <20040501150136.GA23636@colin2.muc.de>
References: <1QvX0-A4-29@gated-at.bofh.it> <m3r7u59sok.fsf@averell.firstfloor.org> <1083382204.1203.2971.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083382204.1203.2971.camel@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -- This information is, in the very near future, _not_ going to be
> static anymore. There will be systems that update the information in
> dynamically during SMIs.

That's fine - /dev/mem can handle that too. An user will have to
poll for changes anyways, so having it it /proc does not have
any advantages.

I would see the sense if there was an interrupt to notify the
the system of changes, but there isn't ;-)

> 
> -- SMBIOS consists of two things, the table entry point and the table
> itself. The table entry point is always in 0xF0000 - 0xFFFFF.
> Traditionally, the actual table has been here as well. BIOS is running
> out of space here and future systems are moving this information to high
> memory. /dev/mem will not allow access to memory above top of system
> RAM.

mmap /dev/mem of high memory should work. Did you try it?
For read/write it would be fairly easy to add, just needs a kmap.

> -- Red Hat has a /dev/mem patch in their tree that restricts access to
> RAM above 1MB. 

That's their breakage.

Clearly it is a useless change anyways because you can easily circumvent
it by just accessing any bus master hardware in the system.

> This procfs/sysfs driver allows access to smbios information by
> non-root, non CAP_SYS_RAWIO users. I've had several occasions where I
> have been bitten by having to be root to read smbios when I did not need
> root for anything else.

That is what suid root was invented for. It is a fairly nifty mechanism,
did you ever try it?  I know that some sysadmins try to get away from
it, but that is clearly misguided because it is not any more dangerous than
adding more kernel code.

-Andi
