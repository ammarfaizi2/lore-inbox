Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRCNO0F>; Wed, 14 Mar 2001 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRCNOZ4>; Wed, 14 Mar 2001 09:25:56 -0500
Received: from ns.caldera.de ([212.34.180.1]:13842 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131371AbRCNOZp>;
	Wed, 14 Mar 2001 09:25:45 -0500
Date: Wed, 14 Mar 2001 15:24:43 +0100
Message-Id: <200103141424.PAA12648@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: mshiju@in.ibm.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ISAPNP :driver not recognized when compiled in kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <CA256A0F.004A726A.00@d73mta05.au.ibm.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <CA256A0F.004A726A.00@d73mta05.au.ibm.com> you wrote:
> Hello,
>            I have a basic question. Can we build a PnP ISA driver in kernel
> with ISAPNP kernel option enabled so that kernel PnP does the job of
> allocating the resources for the driver.

Yes you can.  Look at drivers/sound/ad1816.c or drivers/sound/sb_card.c for
examples.

> The problem being that the
> /etc/isapnp.conf should be executed before the device driver. I tried this
> and was unsuccessful but worked fine when the driver was compiled as a
> module. 

The Linux 2.4 isapnp code does _not_ use isapnp.conf.
Did you write your driver using the isapnp_ kernel APIs (Documented in
Documentation/isapnp.txt)?  Or is it a plain isa driver that needs help
from the isapnp tools to work?

> I read somewhere that ISAPNP drivers with ISAPNP enabled in kernel
> should only be build as modules so that we can keep the order of execution
> . Is this true.? Have any one of you tried this .

This was true for Linux 2.2 and earlier as those did not actually support
isapnp and needed the help of the uselevel isapnp tools.  Because they can
only be used after the system is up isapnp drivers for theses kernel have to
be modules.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
