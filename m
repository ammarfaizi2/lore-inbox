Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTGQHjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271119AbTGQHjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:39:20 -0400
Received: from mail.jambit.de ([212.18.21.206]:40972 "EHLO mail.jambit.de")
	by vger.kernel.org with ESMTP id S271071AbTGQHjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:39:12 -0400
Message-ID: <008f01c34c38$9be3c120$c100a8c0@wakatipu>
From: "Michael Kerrisk" <mtk-lists@jambit.com>
To: <aebr@win.tue.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug in open() function (?)
Date: Thu, 17 Jul 2003 09:54:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Fri, 11 Jul 2003 22:23:00 PDT, Andrew Morton said:

> >

> > > We've lived with it for this long.

> >

> > Well... you have a point there..

> >

> > > Given that the behaviour is undefined, the behaviour which we should

> > > implement is clearly "whatever 2.4 is doing".  So let's leave it
alone.

> >

> > I suppose I could live with that *IF* somebody fixes 'man 2 open' to

> > reflect reality.

>

> Corrections and additions to manpages are always welcome.

> Mail to aeb@cwi.nl .

>

>

> (Concerning the topic under discussion, the man page says

>

>        O_TRUNC

>               If  the  file  already exists and is a regular file

>               and the open mode allows writing (i.e.,  is  O_RDWR

>               or  O_WRONLY) it will be truncated to length 0.  If

>               the file is a FIFO or  terminal  device  file,  the

>               O_TRUNC  flag  is  ignored. Otherwise the effect of

>               O_TRUNC is unspecified.

>

> which is precisely right. It continues

>

>                                        (On many Linux versions it

>               will  be  ignored; on other versions it will return

>               an error.)

>

> where someone may read this as if this is an exhaustive list of

> possibilities. So adding ", or actually do the truncate" will

> clarify.)

>

>

> Concerning the desired behaviour: if I recall things correctly

> doing the truncate was old SunOS behaviour, not doing it,

> that is, honouring the O_RDONLY, is new Solaris behaviour.

> Maybe someone with access to such machines can check.

>

> Software exists that does O_RDONLY | O_TRUNC.



A late addition to this thread, but all of these systems DO truncate with

O_RDONLY | O_TRUNC:



Solaris 8

Tru64 5.1B

HP-UX 11.22

FreeBSD 4.7



Although this flag combination is left unspecified by SUSv3, I don't

know of an implementation that DOESN'T truncate in these circumstances.



Cheers



Michael

