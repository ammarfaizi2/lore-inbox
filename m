Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267177AbSK2XVd>; Fri, 29 Nov 2002 18:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbSK2XVd>; Fri, 29 Nov 2002 18:21:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13114 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267177AbSK2XVd>; Fri, 29 Nov 2002 18:21:33 -0500
Date: Fri, 29 Nov 2002 18:28:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211292328.gATNSnL27325@devserv.devel.redhat.com>
To: bha@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: ioremap returns NULL
In-Reply-To: <mailman.1038579362.3203.linux-kernel2news@redhat.com>
References: <mailman.1038579362.3203.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> For each card I ioremap() 2 * 16 MB of PCI memory space.
> It succeeds for the 1st card but for the 2nd card I get NULL
> as result. This means I cannot use the 2nd card...

I think you are screwed. The ioremap grabs from vmalloc area,
which is something like 64MB on i386. The best option is
to rewrite the driver to allocate less, and perhaps use
fewer modules.

Running a 2G/2G split might help, I'm not sure. But that
route has userland implications anyway, so don't.

-- Pete
