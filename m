Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271229AbTHCQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271230AbTHCQ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 12:59:47 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:42433 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP id S271229AbTHCQ7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 12:59:44 -0400
Message-ID: <004601c359e0$9f905ad0$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Sun, 3 Aug 2003 19:59:37 +0300
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

Shane,

"
| tv01.program     | check | error    | got error: 5 when reading datafile
at record: 6696 |
"

InnoDB reported that same error 5 "EIO I/O error" in a call of fsync().
MyISAM never calls fsync(), but I guess these problems are related. Let us
hope Andrew's fix fixes this MyISAM problem, too.

Before your case I have not seen MyISAM report table corruption with error
5. A brief Googling only returns 4 reports of 'got error: 5'. Thus, it is
likely that the bug in this case is in the OS/drivers/hardware.

Regards,

Heikki

....................
List:     linux-kernel
Subject:  Re: 2.6.0-test2-mm3 and mysql
From:     Shane Shrybman <shrybman () sympatico ! ca>
Date:     2003-08-03 15:01:52
[Download message RAW]

On Sat, 2003-08-02 at 22:08, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:
> >
> > The db corruption hit again on test2-mm2.
>
> How do you know it is "db corruption"?

I haven't been able to get an exact recipe for producing this but I have
posted a couple of the mysql corruption messages.

I still haven't been able to make it appear in 2.6.0-test1-mm1, but once
when I rebooted from -test1-mm1 to -test2-mm3 the tables had problems
immediately, when they came up clean in -test1-mm1 right before. When I
ran the mysql repair tables command it fixed them up and did not delete
any rows from the corrupted table, (or only very few). The repair
command usually deletes thousands of rows in order to repair the table.

http://zeke.yi.org/linux/mysql.tables.corrupt

I haven't found any info on this error message but maybe someone has
seen it before?

BTW: I am using myisam table type in mysql.

I will let you know if I find the exact way to reproduce this problem.

Regards,

Shane


