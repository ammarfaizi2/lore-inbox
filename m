Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262175AbSIZE1B>; Thu, 26 Sep 2002 00:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSIZE1B>; Thu, 26 Sep 2002 00:27:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:53720 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262175AbSIZE0R>;
	Thu, 26 Sep 2002 00:26:17 -0400
Message-ID: <3D928D9F.7BF85410@digeo.com>
Date: Wed, 25 Sep 2002 21:31:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/4] increase traffic on linux-kernel
References: <3D928864.23666D93@digeo.com> <3D928C8B.5020609@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:31:27.0963 (UTC) FILETIME=[947B6AB0:01C26515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Andrew Morton wrote:
> > --- 2.5.38/include/linux/kernel.h~might_sleep Wed Sep 25 20:15:27 2002
> > +++ 2.5.38-akpm/include/linux/kernel.h        Wed Sep 25 20:15:27 2002
> > @@ -40,6 +40,13 @@
> >
> >  struct completion;
> >
> > +#ifdef CONFIG_DEBUG_KERNEL
> > +void __might_sleep(char *file, int line);
> > +#define might_sleep() __might_sleep(__FILE__, __LINE__)
> > +#else
> > +#define might_sleep() do {} while(0)
> > +#endif
> 
> I disagree with this -- CONFIG_DEBUG_KERNEL should not enable any machinery.

I did this because adding a function call to down() and friends
has significant cost.

> Magic Sysrq should be enable-able without affecting any other parts of
> the kernel.

A separate config option then?
