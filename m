Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUERUia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUERUia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbUERUia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:38:30 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:60688 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S263555AbUERUi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:38:28 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Black" <mblack@csi-inc.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problem with mlockall() and Threads: memory usage
Date: Tue, 18 May 2004 13:38:23 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEIJMBAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <40AA06ED.50203@beam.ltd.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2096
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 18 May 2004 13:16:22 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 18 May 2004 13:16:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for that.
> I have done some more investigating, and on my system (Standard RedHat 9)
> the stack ulimit is set to 8192 KBytes. So it appears that the thread
> library/kernel threads pre-allocates, and writes to, 8129 KBytes
> of stack per
> thread and so then mlockall() locks all of this in memory.
>
> Should'nt the Thread library grow the stack rather than
> preallocate it all even
> with mlockall() like malloc ?

	I thought you wanted improved latency. Surely having to find a page for you
when your stack grows will add unpredictable latency. So, no, the thread
library should reserve the stack when 'mlockall(MCL_FUTURE)' is specified.

	I do agree that having an 'initial stack size' in additional to a 'maximum
stack size' would be a good idea. The former good for application that are
concerned about physical memory usage and the latter for applications
concerned about virtual memory usage.

	DS


