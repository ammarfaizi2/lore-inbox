Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRDLUnH>; Thu, 12 Apr 2001 16:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135322AbRDLUm5>; Thu, 12 Apr 2001 16:42:57 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:27831 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135321AbRDLUmu>; Thu, 12 Apr 2001 16:42:50 -0400
Message-ID: <3AD61258.4E8567D8@uow.edu.au>
Date: Thu, 12 Apr 2001 13:38:48 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rod Stewart <stewart@dystopia.lab43.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD5F9FE.9A49374D@uow.edu.au> <Pine.LNX.4.33.0104121530470.31525-100000@dystopia.lab43.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rod Stewart wrote:
> 
> On Thu, 12 Apr 2001, Andrew Morton wrote:
> > Rod Stewart wrote:
> > >
> > > Hello,
> > >
> > > Using the 8139too driver, 0.9.15c, we have noticed that we get a defunct
> > > thread for each device we have; if the driver is built into the kernel.
> > > If the driver is built as a module, no defunct threads appear.
> >
> > What is the parent PID for the defunct tasks?  zero?
> 
> According to ps, 1

Ah.  Of course.  All (or most) kernel initialisation is
done by PID 1.  Search for "kernel_thread" in init/main.c

So it seems that in your setup, process 1 is not reaping
children, which is why this hasn't been reported before.
Is there something unusual about your setup?
