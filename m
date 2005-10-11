Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVJKTcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVJKTcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJKTcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:32:01 -0400
Received: from mail29.messagelabs.com ([140.174.2.227]:59846 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S932110AbVJKTcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:32:00 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-29.tower-29.messagelabs.com!1129059115!23518497!1
X-StarScan-Version: 5.4.15; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Date: Tue, 11 Oct 2005 14:35:01 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F36B115@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Thread-Index: AcXOkdPnYkKrXGNORnaqIldhn07K9wABe0OQ
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2005 19:35:03.0024 (UTC) FILETIME=[E01D7700:01C5CE9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Once a process in in the 'Z' state it should not receive any
> signals. Its signal handlers are already gone. It's just a
> snippit of sys_exit code that remains. If the process truly
> is in the 'Z' state, its input/output/error file-descriptors
> should have already been closed so the time-out from the
> shutdown should have already happened.

Hi Dick,

You are right, its not a zombie.

The process is held up in "drain" in the tty close of the
processes stdin (/dev/ttyS0).
(I assumed brackets in ps -ef meant zombies, but that's wrong)

I added some code to make a short timeout in the "tty close" part of
the driver, then check the values of:

current->signal->shared_pending.list.next
current->signal->shared_pending.list.prev

They *do* change, when I send the process (date) a signal.

The kernel just isn't waking up the driver's "wait" to let it
know that there are signals pending.

Also, why did this work under 2.4?

This is why I was wondering if this was intentional, or was just an
oversight...

Thanks!
Scott
