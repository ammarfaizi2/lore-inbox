Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUEKA36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUEKA36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUEKA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:29:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43981 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261802AbUEKA17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:27:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Mon, 10 May 2004 23:52:24 +0200
User-Agent: KMail/1.5.3
References: <409F4944.4090501@keyaccess.nl> <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl>
In-Reply-To: <409FF068.30902@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405102352.24091.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 of May 2004 23:13, you wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Rene, can you test these (incremental) patches?
> >
> > +       if (drive->usage != 1)
> > +               return 0;
>
> Only this one does not make a change.
>
> > -       if (drive->usage != 1)
> > +       if (drive->usage != 1 || !drive->removable)

Thanks.

Rene, can you send me copies of /proc/ide/hda/identify and
/proc/ide/hdc/identify?  I still would like to know why these
drives don't accept flush cache commands (or it is a driver's bug?).

> With this one, the cache flushing noise is no more, but still a problem
> unfortunately. With or without these patches, 2.6.6 powers down the
> drive during reboot. This is very annoying, seeing as how it immediately
> needs to spin up again for POST.

There is a problem with new 2.6 generic ->shutdown framework,
it doesn't differentiate between reboot / halt and power_off.
We may try to fix it or revert to 2.4 way of doing things if
this is too big change for 2.6.

Thanks,
Bartlomiej

