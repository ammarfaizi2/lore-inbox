Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWEOPbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWEOPbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWEOPbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:31:36 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:42010 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751450AbWEOPbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:31:35 -0400
Subject: sched: 64-bit nr_running
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, rostedt@goodmis.org
Content-Type: text/plain
Date: Mon, 15 May 2006 08:31:20 -0700
Message-Id: <1147707081.15392.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There was a conversation over the mtd redboot bug related to unsigned
long vs. unsigned int . On a 64-bit machine unsigned long is 64-bits ,
and unsigned int is 32-bits . However, both are 32-bits on a 32-bit
machine .

Looking over the scheduler I found a few places that use "unsigned long"
for task counting variables (nr_running, nr_active, nr_interruptible) .
The problem is that these variables are all bound to 29 bits (according
to kernel/pid.c) , but they get expanded to 64-bits on 64-bit machines .

I CC'd Steve cause he seems interested in the topic of variable size
issues (bitmaps , unsigned long longs , etc ) .

Daniel

