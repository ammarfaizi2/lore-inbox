Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262297AbSJJAlp>; Wed, 9 Oct 2002 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262403AbSJJAlp>; Wed, 9 Oct 2002 20:41:45 -0400
Received: from themargofoundation.org ([65.206.132.246]:18449 "HELO
	themargofoundation.org") by vger.kernel.org with SMTP
	id <S262297AbSJJAln>; Wed, 9 Oct 2002 20:41:43 -0400
From: "Steven Dake" <scd@broked.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Realtime Kernel Resource Monitor Project
Date: Wed, 9 Oct 2002 17:45:49 -0700
Message-ID: <000001c26ff6$61a9ef80$0200000a@persist>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I invite you to contribute code, comments, or whatever you like.  I hope

this patch can be part of the 2.5 kernel proper soon.

Visit http://www.broked.org/projects.html to visit the sourceforge
project. subscribe to kernel-rmon-devel@lists.sourceforge.net (which
should be 
available 10/10/2002)

Project Description
--------------------------
The project includes Kernel patches for Linux 2.4, Linux 2.5, an 
instrumented E100 driver (Becker driver) a userland library, userland 
samples, and a programming guide.

Resource Monitor support provides the capability within the kernel to 
monitor resources in realtime.  A resource is represented by a gauge, 
which is a container for a value that can increase or decrease 
arbitrarily.  An example resource is the number of ethernet packets 
transmitted on an ethernet interface.

Gauges are mapped via a reference identifier.  Per-item references can 
also be created, allowing for drivers to support multiple resources of 
the same type.  An example where this would be useful is when two 
Ethernet drivers of the same type want to represent the number of errors

per Ethernet interface.

A statistic can then be generated to monitor a gauge.  Statistics can be

absolute, which means to take the value of the gauge, high watermark, 
which means to take the highest value of the gauge, a low watermark, 
which means to take the lowest value of the gauge, a rate, which means 
to monitor the change in value over a time period, and a leakybucket 
which means to decrement the value of the statistic based upon some time

period.

A threshold can be created to execute a callback routine when a 
statistic reaches some threshold value.  Thresholds can be above, which 
means to execute a callback when the statistic reaches or exceeds a 
threshold value, below which means to execute a callback when the 
statistic reaches or is below a threshold value, above with cancel which

will cancel the callback when the value drops below the threshold value,

and below with cancel which will cancel the callback when the value 
exceeds the threshold value.

Why is this useful?

Carriers, Datacomms, ISPs, and other forms of service providers need a 
mechanism to monitor system resources from a central programming 
interface.  This patch supports nearly unlimited statistics and 
thresholds with minimal performance overhead.  Further, the patch is 
completely ifdef'ed so that if it is configured off in the kernel, it 
will not include any code or performance penalty.

Why not just poll /proc for gauges instead of instrumenting the kernel?

There are several problems with this technique.  The main problem is 
that a statistic won't be updated (and a threshold checked) until a poll

interval.  This means that a threshold can be triggered and then 
untriggered, without generating a threshold event.  Finally, a threshold

won't be triggered in realtime in a polling system since the only time a

threshold can be triggered is when the poll occurs.

A further problem is the failure capable nature of a user-land daemon to

poll the statistics and distribute threshold events.  Messaging must 
invariably be used (be it SYSV IPC or sockets) which introduce more code

failure paths, resulting in lower availability of the service.

This patch isn't totally complete, but I wanted to get feedback as soon 
as possible.  Please send comments, code, feedback and join the open 
source project above.

Thanks!
-steve




