Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264149AbTCXKhD>; Mon, 24 Mar 2003 05:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264150AbTCXKhC>; Mon, 24 Mar 2003 05:37:02 -0500
Received: from nox.lemuria.org ([213.191.86.30]:7635 "EHLO nox.lemuria.org")
	by vger.kernel.org with ESMTP id <S264149AbTCXKhB>;
	Mon, 24 Mar 2003 05:37:01 -0500
Date: Mon, 24 Mar 2003 11:48:09 +0100
From: Tom <tom@lemuria.org>
To: linux-kernel@vger.kernel.org
Subject: /proc/uptime overrun
Message-ID: <20030324114809.A11393@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(no maintainer for proc listed in MAINTAINERS)


[1.] One line summary of the problem:    
/proc/uptime overrun, resetting uptime counter to 0

[2.] Full description of the problem/report:
uptime is stored in an unsigned long int in fs/proc/proc_misc.c (around
line 121), set from jiffies defined in include/sched.h. 
On systems available to me, HZ is always 100, which makes this value 
overrun the unsigned long after about 497 days.

[3.] Keywords (i.e., modules, networking, kernel):
kernel, proc

[4.] Kernel version (from /proc/version):
found on a 2.4.12, but apparently still there in 2.4.19


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
(no oops)

[6.] A small shell script or example program which triggers the
     problem (if possible)
#!/bin/sh
sleep 498d
cat /proc/uptime

[7.] Environment
(not considered relevant)

[X.] Other notes, patches, fixes, workarounds:
No, I don't consider this very important. However, the wrong uptime
display may trigger a search for a power failure or system compromise.
Did for me.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5
