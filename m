Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSHGI2U>; Wed, 7 Aug 2002 04:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSHGI2U>; Wed, 7 Aug 2002 04:28:20 -0400
Received: from mail.genesys.ro ([193.230.224.5]:64169 "EHLO mail.genesys.ro")
	by vger.kernel.org with ESMTP id <S317298AbSHGI2T>;
	Wed, 7 Aug 2002 04:28:19 -0400
Message-ID: <3D50DAFD.2040704@genesys.ro>
Date: Wed, 07 Aug 2002 11:31:57 +0300
From: Silviu Marin-Caea <silviu@genesys.ro>
Organization: http://www.genesys.ro
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020730
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suse-linux-e@suse.com, linux-kernel@vger.kernel.org
Subject: "almost" a server crash: syslog & keventd involved
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning I found the mail server (SuSE 8 all updates) in a weird 
state.  Mail wasn't working, DNS wasn't working, couldn't ssh into it. 
Luckily, I had a console open from yesterday and was able to ps -Al.

Here's what I've got:

http://www.genesys.ro/ps-l
After killing the cron and pop3
http://www.genesys.ro/ps-f

Also, load average was 2.

Notice the syslogd line in "ps -l", when in weird state

006 D     0   519     1  0  80   0 -   352 flush_ ?        00:03:46 syslogd
Same with ps -f:
root       519  0.0  0.0  1408  312 ?        D    Jul15   3:46 /sbin/syslogd

and in normal state

006 S     0   523     1  0  80   0 -   352 do_sel ?        00:00:01 syslogd

man ps says
PROCESS STATE CODES
        D   uninterruptible sleep (usually IO)

There is this too:
007 Z     0     2     1  0  80   0 -     0 do_exi ?        00:00:00 
keventd <defunct>
with ps -f
root         2  0.0  0.0     0    0 ?        Z    Jul15   0:00 [keventd 
<defunct>]

Couldn't get it out of the weirdness without a reboot (ugh).  Now, after 
the crisis, I think that maybe I should've restarted syslog.  And, 
besides, the deep magic of keventd is beyond me, just yet.

Considering that daily cronjobs run at 0:15, I think the problem was 
there.  This is the last file in /var/log: "Wed Aug 07 00:17:21 2002 
mail-20020807.gz" and this is the last message in /var/log/messages "Aug 
  7 00:17:06 mail named[24944]: lame server"

The conclusion is that syslogd restart after running daily jobs did not 
go well.  What could have caused this?  And what about keventd?

I was planning on going on vacation knowing that I have a reliable linux 
server (it's been running for a couple of months).  Now there is doubt :-(

-- 
Silviu Marin-Caea   Systems Engineer Linux/Unix   http://www.genesys.ro
Phone +40723-267961


