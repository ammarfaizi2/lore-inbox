Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTI3NL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbTI3NL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:11:57 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:43759 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261667AbTI3MzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:55:03 -0400
Date: Tue, 30 Sep 2003 14:52:15 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200309301252.h8UCqF0P004385@burner.fokus.fraunhofer.de>
To: axboe@suse.de, linux-kernel@vger.kernel.org, root@chaos.analogic.com
Cc: schilling@fokus.fraunhofer.de
Subject: Re: Kernel includefile bug not fixed after a year :-(
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From root@chaos.analogic.com  Tue Sep 30 14:21:07 2003

>Reply is not on the list.

I added the list because this is another problem that need fixiong inside the 
kernel.

>Also Joerg, now that I have your attention: There is a bug
>somewhere so that if I set the kernel HZ to 400, recompile
>everything including `cdrecord`, I can no longer record a CD.
>I think that somewhere, somebody is using a raw jiffie-count
>instead of multiplying by HZ in the time-out code. I've check
>through all the SCSI stuff, and I use SCSI disks exclusively.
>I think something in your code needs fixing. This is for kernel
>version 2.4.22


Cdrecord and pther programs too includes <sys/param.h>

If you change HZ in the kernel include files and recompile your problems
suffer from the same sort of inconsistencies that have been the reason for
my initial mail.

If Linux likes to support changes to HZ, then it needs to support POSIX
interfaces. On Solaris, sys/param.h looks this way:

#define        HZ              ((clock_t)_sysconf(_SC_CLK_TCK))

You may even change HZ on a running Solaris system.... the only programs that
are affected may be the ones that have timeouts while the change has been done.

The problem is that the timeouts in the SCSI interface are based on HZ rather
than being abstract from kernel internals.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
