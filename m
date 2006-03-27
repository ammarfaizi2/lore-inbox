Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWC0Xs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWC0Xs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWC0Xs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:48:27 -0500
Received: from mail.vtacs.com ([207.42.84.219]:53164 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S932072AbWC0Xs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:48:26 -0500
From: "Greg Lee" <glee@swspec.com>
To: <linux-kernel@vger.kernel.org>, <rmk+kernel@arm.linux.org.uk>
Subject: HZ != 1000 causes problem with serial device shown by git-bisect
Date: Mon, 27 Mar 2006 18:46:02 -0500
Message-ID: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcZR+JtbL264IrTkQ2qYXlhOs+es9w==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem when using PPP over a particular PCMCIA based serial device and have
pinned the problem down using git-bisect to this particular commit that was made between
2.6.12.6 and 2.6.13:

59121003721a8fad11ee72e646fd9d3076b5679c is first bad commit
diff-tree 59121003721a8fad11ee72e646fd9d3076b5679c (from
799d19f6ec5ca2102c61122f5219a17f1c4e961a)
Author: Christoph Lameter <christ...@lameter.com>
Date:   Thu Jun 23 00:08:25 2005 -0700

    [PATCH] i386: Selectable Frequency of the Timer Interrupt

    Make the timer frequency selectable. The timer interrupt may cause bus
    and memory contention in large NUMA systems since the interrupt occurs
    on each processor HZ times per second.


The problem that I am seeing can be reproduced by attempting to send large packets via a
PPP interface on the modem, e.g. "ping -s 1000 www.kernel.org".

With this patch, the value of HZ was changed from the previously "hardcoded" 1000 to be
configurable with the default being 250.  My ping packet size problem goes away if I
select 1000 as the new value.  I do need to be able to run with HZ = 250 (actually 100 is
better for my situation).

It looks to me like the git-bisect did not really get me down to the core problem which is
that there is something is the system that isn't happy with HZ == 250.

I have also tried a number of other kernels and the problem exists all the way to 2.6.15.6
but is fixed in 2.6.16, so I am going to git-bisect 2.6.15.6 to 2.6.16, but I thought I
would get this message out now in case someone has an inkling of what the problem is.

Please cc me on any responses.  Russell I copied you directly since I think you may be in
the best position to understand the problem.

Greg Lee


