Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSJLGsO>; Sat, 12 Oct 2002 02:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbSJLGsO>; Sat, 12 Oct 2002 02:48:14 -0400
Received: from fastmail.fm ([209.61.183.86]:5305 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S262826AbSJLGsN>;
	Sat, 12 Oct 2002 02:48:13 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034405637
X-Sasl-enc: g0AFF8l6O0Bn/eUf+nH2hA
Message-ID: <0ff701c271bb$f2e8a0b0$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook> <3DA791E0.F0A1B11@digeo.com> <0fe701c271b9$e86ea910$1900a8c0@lifebook> <3DA7C4C2.58BCE2BC@digeo.com>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sat, 12 Oct 2002 16:52:31 +1000
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


> It commits your changes to the journal every five seconds.  But your data
> is then only in the journal.  It still needs to be written into your
files.
> That writeback is controlled by the normal kernel 30-second writeback
> timing.  If that writeback isn't keeping up, kjournald needs to
> force the writeback so it can recycle that data's space in the journal.
>
> While that writeback is happening, everything tends to wait on it.

Doesn't bdflush let you control this? I noted in my first post that we'd
played with changing bdflush params as described here:

http://www-106.ibm.com/developerworks/linux/library/l-fs8.html?dwzone=linux

And set them to this:

[root@server5 hm]# cat /proc/sys/vm/bdflush
39      500     0       0       60      300     60      0       0

Shouldn't this reduce it to writing every 3 seconds? We tried lowering some
of the values even further based on the description here:

http://www.bb-zone.com/zope/bbzone/docs/slgfg/part2/cha04/sec04

So we altered the first one (nfract) to 10(%) to try and keep the dirty
buffer list small, but that didn't help either. I sort of thought that
age_buffer at 3 seconds would be more likely to activate anyway than 40% of
buffers being dirty?

> It is suspected that ext3 gets the flushtime on those buffers
> wrong as well, so the writeback isn't happening right.

So you're saying that ext3 is somehow breaking the standard kernel writeback
code? Is this something they know about, and/or are addressing?

Rob

