Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVB1Wtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVB1Wtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVB1Wtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:49:33 -0500
Received: from mail.tmr.com ([216.238.38.203]:61457 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261801AbVB1WtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:49:08 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: [2.6.11-rc4-bk9] Bad behaviour using RAID
Date: Mon, 28 Feb 2005 17:54:09 -0500
Organization: TMR Associates, Inc
Message-ID: <d006fl$7eq$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1109630262 7642 192.168.12.100 (28 Feb 2005 22:37:42 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just added a few more 200GB drives on a Promise controller, and they 
are configured as:
   md0 - raid1, 6GB of stuff I really don't want to lose 64k stripe
   md1 - raid0, 350GB for streaming video capture, 512k stripe
This space was configured with "mdadm" if that makes a difference, and I 
didn't get the right options to make it start at boot, so it gets run 
out of rc.local. I doubt that makes a difference, but I mention it.

Since this machine is often idle for hours, I have the two drives of 
interest set to spin down after 20 minutes of disuse. Other than a 
fairly slow start I have had no problems with restarting after an idle 
period.

There are no problems with data corruption or error messages, nor have I 
ever see any indication of a rebuild in progress. HOWEVER, every once in 
a while the disk light comes on and the system becomes very 
unresponsive. Since the Promise controller isn't connected to the disk 
light, the activity is one the original (120gb, 200gb) drives somewhere. 
The system is unresponsive for 1-2 minutes, although not totally so, I 
can look at /proc/mdstat and see no rebuild, and even guess that the 
raid drives are spun down because access takes seconds after the system 
seems normal.

The system was up since the night the kernel was released, and I never 
saw any such behaviour until I added the other drives, but the activity 
is not on the new drives. This happens 1-2 times a day by observation, 
and since I use the system remotely during the week, I can only say that 
I haven't seen the unresponsive behaviour before, nor observed it on the 
weekend in the office. If I see it several times a day it's likely to be 
happening more often.

If anyone has even the slightest clue what's happening, I'd love to hear 
it. It started when the new hardware was added, but occurs on the old.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
