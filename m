Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272046AbTHDSbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272153AbTHDS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:29:40 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:3567 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S272142AbTHDS3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:29:15 -0400
Message-ID: <00bc01c35ab6$490f8f10$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
References: <009201c3599f$04ff05c0$322bde50@koticompaq> <20030803022723.760f6451.akpm@osdl.org> <00b901c359ac$0c7fe0a0$322bde50@koticompaq> <200308041215.h74CFLj12258@Port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Mon, 4 Aug 2003 21:29:05 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis,

----- Original Message ----- 
From: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, August 04, 2003 3:24 PM
Subject: Re: 2.6.0-test2-mm3 and mysql


> On 3 August 2003 13:43, Heikki Tuuri wrote:
> > > Well there's a problem.  We're kernel people, not database people.  I,
for
> > > one, would not have a clue how to set such a thing up.
> > >
> > > If someone could prepare a simple-enough-for-kernel-people description
of
> > > how to get such a test up and running, then we might make some
progress.
> >
> > ok :).
> >
> > 1. Download
>
> [4 screenfuls snipped]
>
> That's a hell of a setup work, and kernel folks will always get slightly
> different setups. Can database folks make a fully configured chrootable
> tarball for mysql stress testing?

I think an even better idea is to use some multithreaded file i/o stress
test program. There probably are such programs already. If not, write a
simple C program which calls pread(), pwrite(), and fsync() on pages of size
2 - 16 kB. Vary the data you write, and check that the data you read is what
you wrote to the file the last time. Run the test for several days or even
weeks. Vary the size of the files so that you get real disk reads.

Is there such a stress test in the standard test suite for Linux
kernel/driver developers?

Running an actual SQL database on top of that file i/o workload may also
have some effect, because it is possible some bugs are really corruption of
the process memory space. Maybe we could simulate the database CPU load by
simple memcpy's etc.

Some additional info I forgot to mention about corruption:

1. In some cases corruption happens very frequently, even several times per
hour. In those cases I suspect a hardware fault. In addition to mysqld, also
other programs may suffer and crash.

2. Most cases of corruption only happen once in several weeks. They require
heavy database load to manifest.

3. A typical case of corruption is that an area of size varying from 4 bytes
to 4 kB is reset to zero in a 16 kB database page. Often is has been the end
of the page. In Sergey's case the whole 16 kB page was reset to zero.

> --
> vda

Regards,

Heikki
http://www.innodb.com


