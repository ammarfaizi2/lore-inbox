Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264856AbTFLPS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbTFLPS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:18:28 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:64244 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264856AbTFLPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:18:21 -0400
Subject: Re: implicid declaration of function task_suspended -
	Was:	[PATCHSET] 2.4.21-rc6-dis3 released
From: Disconnect <kernel@gotontheinter.net>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Martin List-Petersen <martin@list-petersen.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055418435.17838.8.camel@laptop-linux>
References: <1055410660.3ee849e439b96@support.tuxbox.dk>
	 <1055418435.17838.8.camel@laptop-linux>
Content-Type: text/plain
Message-Id: <1055431855.11780.5.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 11:30:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 07:47, Nigel Cunningham wrote:
> TASK_SUSPENDED is a swsusp macro. What version of swsusp do you have
> included in your kernel? (There were some compile problems fixed a while
> ago - you probably have a version pre then).

It may not be directly related to swsusp - it may be that in wiggling a
patch I missed an #ifdef SWSUSP ...

..

OK I looked there - its can_schedule() thats triggering it.  I'm going
to try a build without software suspend and see if I can reproduce.  In
the meantime, send me the .config file that triggered it. (And make sure
you did 'make mrproper ; make [x/menu/old]config ; make dep ; make
clean' ..)

FWIW its 2.4.21-rc6 with the following suspend-related patches:
  - ACPI 20030523-2.4.21-rc3.diff
  - patch-acpi-acpi20021212-swsusp19.gz
  - patch-agp for swsusp on i810 motherboards

> Regards,
> 
> Nigel
> 
> On Thu, 2003-06-12 at 21:37, Martin List-Petersen wrote:
> > I tried to compile this (both on rc6 and rc7) and the compile fails with:
> > 
> > kernel/kernel.o(.text+0x2d8): In function 'schedule':
> > : undefined reference to 'TASK_SUSPENDED'
> > kernel/kernel.o(.text+0x392): In function 'schedule':
> > : undefined reference to 'TASK_SUSPENDED'
> > 
> > The compile allready stated in the beginning:
> > sched.c: In function 'schedule':
> > sched.c:611: implicit declaration of function 'TASK_SUSPENDED'
> > 
> > Any idea's what i can leave out to avoid these failures ?
> > 
> > Regards,
> > Martin List-Petersen
> > martin at list-petersen dot dk
> > --
> > Q:	What do you get when you cross the Godfather with an attorney?
> > A:	An offer you can't understand.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

