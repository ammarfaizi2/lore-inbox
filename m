Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTHCUuo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbTHCUuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:50:44 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:63477 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S270486AbTHCUum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:50:42 -0400
Message-ID: <00ae01c35a00$e33188c0$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Sun, 3 Aug 2003 23:50:35 +0300
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

I looked at your .err file, and you have really got very bad corruption.

The first crash looks like there were index records in the insert buffer to
insert to a page, but the contents of that page were completely wiped to
zero.

After that crash, InnoDB fails to recover, because the log contains an index
record insertion to a page which is completely wiped to zero except for the
lsn field at the start and the end of the page.

Are you running the same workload on MySQL-4.0.14 on other computers?

What MySQL version did you run previously on this computer or did you create
the tablespace from scratch?

Did you upgrade MySQL before upgrading to Linux-2.6, or after that?

Before blaming Linux-2.6 we should know the same load runs ok on
MySQL-4.0.14 on some Linux-2.4 box.

Regards,

Heikki

........................
List:     linux-kernel
Subject:  Re: 2.6.0-test2-mm3 and mysql
From:     "Sergey S. Kostyliov" <rathamahata () php4 ! ru>
Date:     2003-08-03 18:58:17
[Download message RAW]

Hello Andrew,

On Sunday 03 August 2003 05:04, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:

<cut>

>
> > One last thing, I have started seeing mysql database corruption
> > recently. I am not sure it is a kernel problem. And I don't know the
> > exact steps to reproduce it, but I think I started seeing it with
> > -test2-mm2. I haven't ever seen db corruption in the 8-12 months I have
> > being playing with mysql/php.
>
> hm, that's a worry.  No additional info available?
>

I also suffer from this problem (I'm speaking about heavy InnoDB corruption
here), but with vanilla 2.6.0-test2. I can't blame MySQL/InnoDB because
there are a lot of MySQL boxes around of me with the same (in fact the box
wich failed is replication slave) or allmost the same database setup.
All other boxes (2.4 kernel) works fine up to now.

Sorry but I can't provide additional info. There was no messages in kernel
log.
All I have is mysql error logs. But I'm afraid they are not very helpfull
for kernel developers.
http://sysadminday.org.ru/linux-2.6.0-test2_InnoDB_crash

System is x86 UP PIII 500, 1Gb RAM with software RAID1 over two scsi disks.



-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc


