Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUIHFlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUIHFlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 01:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUIHFlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 01:41:07 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:45033 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S268294AbUIHFlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 01:41:02 -0400
Date: Wed, 8 Sep 2004 01:41:01 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: proc stalls
Message-ID: <20040908054101.GR2966@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Please give me some hints on where to look and what possibly to do to
bring system back to usable without rebooting, or at least to catch what
can be a problem.

I've discroverd that mozilla-firefox didn't want to start - just hanged
during start... well - I've found that 'fuser -m /dev/dsp' causes it to
stall... well - I've fount that any fuser process stalls... well... I've
found using strace that they stall around next point:
getdents64(4, /* 0 entries */, 1024)    = 0
close(4)                                = 0
chdir("/proc/26336")                    = 0
stat64("root", {st_mode=S_IFDIR|0755, st_size=720, ...}) = 0
lstat64("root", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
stat64("cwd", 

well.. I've tried to cd to /proc/26336 and my bash got frozen as well...


now my sytem load is around 20 probably due to all the unkillable fuser
processes I've ran so far... They look like:
yoh      29083  0.0  0.0  1532  560 ?        D    00:48   0:00 fuser -m
/dev/dsp

no abnormal logs are reported in syslog... 


What can I do to find the cause or to resolve the situation somehow
without reboot? Which else hints can I provide? I'm reporting main
system params and linux kernel config on

http://www.onerussian.com/Linux/bugs/bug.proc/

(Many other tools like df stall as well)

Thank you in advance

-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

