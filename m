Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTHCRLi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 13:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271211AbTHCRLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 13:11:38 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:51911 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S270987AbTHCRLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 13:11:36 -0400
Message-ID: <004c01c359e2$47db2110$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
References: <009201c3599f$04ff05c0$322bde50@koticompaq> <20030803165522.GS22824@waste.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Sun, 3 Aug 2003 20:11:29 +0300
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

Matt,

----- Original Message ----- 
From: "Matt Mackall" <mpm@selenic.com>
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, August 03, 2003 7:55 PM
Subject: Re: 2.6.0-test2-mm3 and mysql


> On Sun, Aug 03, 2003 at 12:10:01PM +0300, Heikki Tuuri wrote:
> >
> > What to do? People who write drivers should run heavy, multithreaded
file
> > i/o tests on their computer using some SQL database which calls fsync().
For
> > example, run the Perl '/sql-bench/innotest's all concurrently on MySQL.
If
> > the problems are in drivers, that could help.
>
> Did you know that until test2-mm3, nothing would report errors that
> occurred on non-synchronous writes? There was no infrastructure to
> propagate the error back to userspace. If you wrote a page, the write
> failed on an intermittent I/O error, and then read again, you'd
> silently get back the old page.

we are not using the Linux async i/o. Do you mean that? Or the flush which
the Linux kernel does from the file cache to the disk time to time on its
own? I assume it will write to the system log an error message if a disk
write fails?

The error 5 Shane reported came from a call of fsync(), and apparently he
also got that same 5 from a simple file read which CHECK TABLE in MyISAM
does.

Why would a write in the Linux async i/o fail? I am using aio on Windows,
and if the disk space can be allocated, it seems to fail only in the case of
a hardware failure.

> -- 
> Matt Mackall : http://www.selenic.com : of or relating to the moon

Regards,

Heikki


