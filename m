Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQLFMfN>; Wed, 6 Dec 2000 07:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbQLFMfE>; Wed, 6 Dec 2000 07:35:04 -0500
Received: from hermes.mixx.net ([212.84.196.2]:21011 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131517AbQLFMex>;
	Wed, 6 Dec 2000 07:34:53 -0500
From: andrewm@uow.edu.au (Andrew Morton)
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: test12-pre6
Date: 6 Dec 2000 13:04:26 +0100
Organization: innominate AG, Berlin, Germany
Distribution: local
Message-ID: <3A2E2C16.80AF82BB@uow.edu.au>
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com> <20001206064732.A6542@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 976104266 26271 10.0.0.1 (6 Dec 2000 12:04:26 GMT)
X-Complaints-To: news@innominate.de
X-Delivered-To: news-innominate.list.linux.kernel@localhost.bln.innominate.de
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
X-To: Wakko Warner <wakko@animx.eu.org>
X-Cc: news-innominate.list.linux.kernel@innominate.de
To: news-innominate.list.linux.kernel@innominate.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> 
> >  - pre6:
> >     - Andrew Morton: exec_usermodehelper fixes
> 
> pre4 oopsed all over the place on my alpha with modules and autoloading
> turned on as soon as it mounted / and freed unused memory.  I take it this
> was seen on i386 as well?

No...  The problems showed themselves a little more subtly than that,
although in the pre5 version there was potential for schedule_task tasks to
be queued before the kernel thread which handles them was started.

This shouldn't normally be a problem, but it becomes a fatal problem if
someone tries to schedule a task and then synchronously waits
for it to complete, as the new exec_usermodehelper does.

This change didn't affect module loading per-se.  But the
kernel does try to run /sbin/hotplug from deep within sys_insert_module
and sys_delete_module, so they're related.

> Will try pre6.

Please.

-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
