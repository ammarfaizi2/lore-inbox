Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRLQSd2>; Mon, 17 Dec 2001 13:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281877AbRLQSdT>; Mon, 17 Dec 2001 13:33:19 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:39903 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S281854AbRLQSdF>; Mon, 17 Dec 2001 13:33:05 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: affinity and tasklets...
Date: Mon, 17 Dec 2001 10:32:46 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBMEAHCAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

when i call tasklet_schedule() to do deferred processing, looking at the
code it seems like it queues it to the current processor. So typically when
a cpu takes interrupt and the isr queues a tasklet, it gets queued to the
same processor that took the interrupt.

Assume iam running many protocols on a single piece of hw using the same
physical fibre link. Say running Network and storage etc. Most Virtual
Interface Hardware, and the new IB technologies allow doing this.

The way the interrupt processing is done is a little bit different, in the
sense the intr are ganged. e.g it could report 2 different drivers have
completions to process. Now both of those can be processed in parallel,
since they share no data.

In a MP case, we would like 2 separate processors taking the completion
processing. But running tasklets dont seem to suit this since it basically
queues on the same CPU that is currently running, and this means both get
queued to the same tasklet_vec[cpu]. But i want each to run on a separate
CPU. is using softirq the right method? or could i have cpu affinity for
tasklets? (i know there is afficinity for interrupts, but iam not aware of
this for tasklets.)

any help is greatly appreciated.

ashokraj

