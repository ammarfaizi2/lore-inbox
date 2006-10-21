Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992998AbWJUM5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992998AbWJUM5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992999AbWJUM5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:57:08 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:37910 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S2992998AbWJUM5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:57:07 -0400
Subject: [Patch 0/5] I/O statistics through request queues
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Oct 2006 14:57:03 +0200
Message-Id: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set makes the block layer maintain statistics for request
queues. Resulting data closely resembles the actual I/O traffic to a
device, as the block layer takes hints from block device drivers when a
request is being issued as well as when it is about to complete.

It is crucial (for us) to be able to look at such kernel level data in
case of customer situations. It allows us to determine what kind of
requests might be involved in performance situations. This information
helps to understand whether one faces a device issue or a Linux issue.
Not being able to tap into performance data is regarded as a big minus
by some enterprise customers, who are reluctant to use Linux SCSI
support or Linux.

Statistics data includes:
- request sizes (read + write),
- residual bytes of partially completed requests (read + write),
- request latencies (read + write),
- request retries (read + write),
- request concurrency,

For sample data please have a look at the SCSI stack patch or the DASD
driver patch respectively. This data is only gathered if statistics have
been enabled by users at run time (default is off).

The advantage of instrumenting request queues is that we can cover a
broad range of devices, including SCSI tape devices.
Having the block layer maintain such statistics on behalf of drivers
provides for comparability through a common set of statistics.

A previous approach was to put all the code into the SCSI stack:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115928678420835&w=2
I gathered from feedback that moving that stuff to the block layer
might be preferable.

These patches use the statistics component described in
Documentation/statistics.txt.

Patches are against 2.6.19-rc2-mm2.

[Patch 1/5] I/O statistics through request queues: timeval_to_us()
[Patch 2/5] I/O statistics through request queues: queue instrumentation
[Patch 3/5] I/O statistics through request queues: small SCSI cleanup
[Patch 4/5] I/O statistics through request queues: SCSI
[Patch 5/5] I/O statistics through request queues: DASD

Martin

