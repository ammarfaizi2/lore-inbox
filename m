Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTHCJKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270980AbTHCJKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:10:15 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:52452 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S270469AbTHCJKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:10:08 -0400
Message-ID: <009201c3599f$04ff05c0$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Sun, 3 Aug 2003 12:10:01 +0300
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

Andrew,

I do not know about the specific corruption Shane is talking about, but I
could summarize what we have found out in the past 2 years. I have written
the InnoDB backend to MySQL, and have been hunting Linux corruption bugs for
2 years now.

- Corruption seems to happen on Red Hat kernels 2.4.18 under heavy file i/o
load on some computers.

- A user ran a very simple stress test of type SELECT 'abbaguu' with many
clients. On a 2-way Dell server he was able to get mysqld to crash
predictably in < 24 hours. Sometimes he also got corruption. But another,
cheaper computer worked ok. Both were running a Red Hat kernel 2.4.18. When
the user upgraded to a 'stock' kernel 2.4.20, the crashes and corruption
disappeared.

- Our 4-way Xeon SuSE-2.4.18 computer never corrupts databases, though I run
very heavy stress tests on it.

- Kernels 2.4.20 seem to be more reliable than 2.4.18. I have only one
corruption case from such a kernel.

- We know with certainty that corruption is sometimes caused by
OS/drivers/hardware and not by mysqld, because in some cases rebooting the
computer has magically fixed the corruption. Looks like Linux had corrupted
its own file cache, but the data on disk was ok. I reported this on the
Linux kernel mailing list 2 years ago, but got no definite feedback.

- In some cases InnoDB reports checksum errors in pages. In those cases it
is also very probable that the corruption was caused by OS/drivers/hardware,
and not by mysqld.

- I have not noticed any clear connection between corruption reports and the
used file system.

- I have personally tested on 4 Linux computers. On an old 2.2 kernel
computer I was able to get read errors in 30 seconds. The three 2.4 kernel
computers have worked ok.

My hypothesis is that there are bugs in drivers of Linux. That would explain
why some computers work ok. Or there are Linux kernel bugs which only
manifest on certain hardware under certain file i/o workload.

What to do? People who write drivers should run heavy, multithreaded file
i/o tests on their computer using some SQL database which calls fsync(). For
example, run the Perl '/sql-bench/innotest's all concurrently on MySQL. If
the problems are in drivers, that could help.

Best regards,

Heikki Tuuri
Innobase Oy

.................

List:     linux-kernel
Subject:  Re: 2.6.0-test2-mm3 and mysql
From:     Andrew Morton <akpm () osdl ! org>
Date:     2003-08-03 2:08:59
[Download message RAW]

Shane Shrybman <shrybman@sympatico.ca> wrote:
>
> The db corruption hit again on test2-mm2.

How do you know it is "db corruption"?

>
>  I am still backing out the 64 bit devt bit

why?


