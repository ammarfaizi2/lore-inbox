Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272342AbRH3RMN>; Thu, 30 Aug 2001 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272344AbRH3RMD>; Thu, 30 Aug 2001 13:12:03 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:52897 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272342AbRH3RLu>; Thu, 30 Aug 2001 13:11:50 -0400
Date: Thu, 30 Aug 2001 13:12:07 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Michael E Brown <michael_e_brown@dell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <Pine.LNX.4.33.0108301150460.1213-100000@blap.linuxdev.us.dell.com>
Message-ID: <Pine.LNX.4.33.0108301306300.12593-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Michael E Brown wrote:

> And your response to the rest of the points I raised would be?

fs/block_dev.c is not a hot spot in the kernel.  It's been patched maybe 3
or 4 times over the last year, so I don't buy the argument that it would
have been difficult to maintain.  (Think if (offset >=
last_block_start(dev) return read_last_block(offset, buf, len);)

> I'm sorry about e2fsprogs. If I had known a bit better (this was my first
> kernel patch), I would have added a magic number to the struct you pass
> in, and that would have prevented this little bit of braindamage.

No, that's not what's got me miffed.  What is a problem here is that an
obvious next to use ioctl number in a *CORE* kernel api was used without
reserving it.  AND PEOPLE SHIPPED IT!  I for one don't go about shipping
new ABIs without reserving at least a placeholder for it in the main
kernel (or stating that the code is not bearing a fixed ABI).  If the
ioctl # was in the main kernel, this mess would never have happened even
with the accidental shipping of the patch in e2fsprogs.  I just hope
people will remember this in the future.  ABI compatibility is not that
hard if it's thought about.

		-ben

