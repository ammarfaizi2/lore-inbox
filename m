Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTKBD5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 22:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTKBD5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 22:57:43 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:37316 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261345AbTKBD5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 22:57:41 -0500
Date: Sat, 01 Nov 2003 19:57:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: cesarb@nitnet.com.br
Subject: [Bug 1474] New: NTP needs too much time correction on	2.6.0-test9 
Message-ID: <6270000.1067745451@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1474

           Summary: NTP needs too much time correction on 2.6.0-test9
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: normal
             Owner: johnstul@us.ibm.com
         Submitter: cesarb@nitnet.com.br


Distribution: Debian testing/unstable
Hardware Environment: K6II-350
Software Environment: ntpd 4.1.2a
Problem Description:

After upgrading from 2.6.0-test8 to 2.6.0-test9, I started seeing too many time
reset messages from ntpd (about two or three every hour), all saying the clock
was set back between 0.5s and 1.5s. Checking the status with ntpq I noticed it
had a large offset (on the order of 500ms ahead of the peers) and a huge
frequency correction (about -490). Removing ntp.drift (to restore the correction
to 0) and rebooting didn't help; after a few hours it was back at -500 (the
maximum allowed backwards correction) and still stepping the clock.

Rebooting back into 2.6.0-test8 fixed it; the frequency correction is now around
-70 and it is no longer losing sync.

While it was in 2.6.0-test9, a highly unscientific test (running "date" in it
and in a 2.4 box also using ntpd, in that order, gave me a result 1 second
higher for the first box consistently) shows that ntpd's statistics weren't
bogus; the time in the 2.6 box was really ahead by about 1 second all the time,
even with ntp trying to slew it (it didn't get higher since ntpd gave up and
stepped it after some time).

Steps to reproduce:

I can reproduce it here simply booting back into 2.6.0-test9; I don't know which
changes made the difference. I suspect a highly suspicious change in the timer
code between 2.6.0-test8 and 2.6.0-test9; I will try to find out how to get the
exact cset in the bkbits web interface and revert by hand to see if it works.


