Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTH1TLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTH1TLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:11:17 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:51952 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S264220AbTH1TK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:10:59 -0400
Message-ID: <068801c36d98$1b6c8820$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>,
       <linux-kernel@vger.kernel.org>
References: <046201c36d8e$34669eb0$322bde50@koticompaq> <200308282301.16139.rathamahata@php4.ru>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Thu, 28 Aug 2003 22:10:52 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey,

----- Original Message ----- 
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, August 28, 2003 10:01 PM
Subject: Re: 2.6.0-test2-mm3 and mysql


> Hi Heikki,
>
> On Thursday 28 August 2003 21:59, Heikki Tuuri wrote:
> > Sergey,
> >
> > does it always crash when you start mysqld?
>
> Yes It was always crashing until I deleted all InnoDB files and restored
> InnoDB tables from backup.
>
> >
> > It is page number 0 in the InnoDB tablespace. That is, the header page
of
> > the whole tablespace!
> >
> > The checksums in the page are ok. That shows the page was not corrupted
in
> > the Linux file system.
> >
> > InnoDB is trying to do an index search, but that of course crashes,
because
> > the header page is not any index page.
> >
> > The reason for the crash is probably that a page number in a pointer
record
> > in the father node of the B-tree has been reset to zero. The corruption
has
> > happened in the mysqld process memory, not in the file system of Linux.
> > Otherwise, InnoDB would have complained about page checksum errors.
> >
> > No one else has reported this error. I have now added a check to a
future
> > version of InnoDB which will catch this particular error earlier and
will
> > hex dump the father page.
>
> Yes, now it seems for me that this particular crash in not related to
linux
> kernel at all.
> The funny thing I've managed to get another InnoDB crash on the same box
> http://sysadminday.org.ru/linux-2.6.0-test4_InnoDB_crash-20030828
> which in turn was posted to linux-kernel over a two hours ago.
> This time the cheksums are different :(


ok, this time the corruption probably happened in the file cache, or the
file system of Linux, or in the hardware.

It is not at all surprising that you encounter memory corruption and file
corruption in the same computer. That is a common pattern if these problems
appear at all.

Do you have a swap partition? I do not know Linux well enough, but in
theory, file or disk corruption could cause also memory corruption if pages
of the process memory get swapped to disk.


> > By the way, I noticed that a website http://www.linuxtestproject.org has
> > made an extensive regression test suite for Linux. They have also
> > successfully run big MySQL and DB2 stress tests on their computers, on
> > 2.5.xx kernels. If there is something wrong with 2.5.xx or 2.6.0, it
> > apparently does not concern all computers.
> >
> > "
> > The Linux Test Project test suite, ltp-20030807, has been released. The
> > latest version of the testsuite contains 2000+ tests for the Linux OS.
> > "
> >
> > The general picture about InnoDB corruption is that reports have almost
> > stopped after I advised people on the mailing list to upgrade to
> > Linux-2.4.20 kernels.
>
> In fact I'm also a happy InnoDB user. It runs fine on 6 of my production
> servers. Thanks for a nice work btw!
>
> It has worked fine also on our development server until I upgraded it to
> 2.6.0-testX. I don't know. It might be just a broken hardware
> which is better stressed with 2.6 than with 2.4...
>
> >
> > With apologies,
> >
> > Heikki
> > Innobase Oy

Best regards,

Heikki
Innobase Oy
http://www.innodb.com


