Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311357AbSCLWQ1>; Tue, 12 Mar 2002 17:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311356AbSCLWQS>; Tue, 12 Mar 2002 17:16:18 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13510 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311357AbSCLWQG>; Tue, 12 Mar 2002 17:16:06 -0500
Message-ID: <3C8E7E08.C3CF4227@us.ibm.com>
Date: Tue, 12 Mar 2002 14:15:36 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: kessler@us.ibm.com with your comments.

Patch for kernel version 2.5.6:
http://prdownloads.sourceforge.net/evlog/evlog-1.3.0_kernel2.5.6.patch
Patch for kernel version 2.4.17, 2.4.18:
http://prdownloads.sourceforge.net/evlog/evlog-1.3.0_kernel2.4.17.patch

This patch, in combination with the event logging and event
notification user library, provides a comprehensive event 
logging package based on the draft POSIX standard 1003.25.
See http://evlog.sourceforge.net/ for details and downloads.

A summary of the kernel patch:
1) A static kernel buffer is implemented for POSIX events logged
   in the kernel.  Size is configurable during kernel build.
2) If the buffer overruns the oldest events are kept, newest
   discarded, and a count of discarded events is reported.
3) Optionally, POSIX events can be created from printk messages
   (printk messages still go to /var/log/messages, as before)
4) Functions are provided for: 
   - logging directly to kernel event buffer (text string or
     binary data which gets formatted outside of the kernel)
   - registering facilities beyond the standard ones in syslog.h
     (device drivers can have facility other than KERN)
5) Events are displayed on the system console as single-line
   summary messages (based on printk's default console logging level).

Please be clear that this is NOT intended to replace printk and
syslog, but to coexist with them and provide additional 
capabilities not available with printk/syslog that are highly 
desirable in large servers and Telecom environments (to name a few).

Larry Kessler
