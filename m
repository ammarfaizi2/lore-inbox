Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTH1T12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTH1T12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:27:28 -0400
Received: from village.ehouse.ru ([193.111.92.18]:53510 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264266AbTH1T1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:27:24 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Thu, 28 Aug 2003 23:27:30 +0400
User-Agent: KMail/1.5
References: <046201c36d8e$34669eb0$322bde50@koticompaq> <200308282301.16139.rathamahata@php4.ru> <068801c36d98$1b6c8820$322bde50@koticompaq>
In-Reply-To: <068801c36d98$1b6c8820$322bde50@koticompaq>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308282327.30036.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 August 2003 23:10, Heikki Tuuri wrote:
> Sergey,
>
> ----- Original Message -----
> From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
> To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>;
> <linux-kernel@vger.kernel.org> Sent: Thursday, August 28, 2003 10:01 PM
> Subject: Re: 2.6.0-test2-mm3 and mysql
>
> > Hi Heikki,
> >
> > On Thursday 28 August 2003 21:59, Heikki Tuuri wrote:
> > > Sergey,
> > >
> > > does it always crash when you start mysqld?
> >
> > Yes It was always crashing until I deleted all InnoDB files and restored
> > InnoDB tables from backup.
> >
> > > It is page number 0 in the InnoDB tablespace. That is, the header page
>
> of
>
> > > the whole tablespace!
> > >
> > > The checksums in the page are ok. That shows the page was not corrupted
>
> in
>
> > > the Linux file system.
> > >
> > > InnoDB is trying to do an index search, but that of course crashes,
>
> because
>
> > > the header page is not any index page.
> > >
> > > The reason for the crash is probably that a page number in a pointer
>
> record
>
> > > in the father node of the B-tree has been reset to zero. The corruption
>
> has
>
> > > happened in the mysqld process memory, not in the file system of Linux.
> > > Otherwise, InnoDB would have complained about page checksum errors.
> > >
> > > No one else has reported this error. I have now added a check to a
>
> future
>
> > > version of InnoDB which will catch this particular error earlier and
>
> will
>
> > > hex dump the father page.
> >
> > Yes, now it seems for me that this particular crash in not related to
>
> linux
>
> > kernel at all.
> > The funny thing I've managed to get another InnoDB crash on the same box
> > http://sysadminday.org.ru/linux-2.6.0-test4_InnoDB_crash-20030828
> > which in turn was posted to linux-kernel over a two hours ago.
> > This time the cheksums are different :(
>
> ok, this time the corruption probably happened in the file cache, or the
> file system of Linux, or in the hardware.
>
> It is not at all surprising that you encounter memory corruption and file
> corruption in the same computer. That is a common pattern if these problems
> appear at all.
>
> Do you have a swap partition? I do not know Linux well enough, but in
> theory, file or disk corruption could cause also memory corruption if pages
> of the process memory get swapped to disk.

Yes, the swap is used on this box.

rathamahata@dev rathamahata $ free -k
             total       used       free     shared    buffers     cached
Mem:       1035248     860740     174508          0      32676     581852
-/+ buffers/cache:     246212     789036
Swap:      8969484     195136    8774348

