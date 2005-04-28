Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVD1P7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVD1P7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVD1P7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:59:51 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:37517 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262104AbVD1P7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:59:46 -0400
Message-ID: <4270FA5B.5060609@davyandbeth.com>
Date: Thu, 28 Apr 2005 09:59:39 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext3 issue.. 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
   I'm having an issues with ext3.  For about 3 months the /home 
partition has had low-to-medium use/activity.. adding files, nightly log 
rotations, some mysql dbs coming and going at a slow pace..  Well, 
yesterday after I had migrated everything off of it (no files in /home 
anymore) the df output looked like this:

# uptime
 10:35:54 up 96 days, 14:22,  1 user,  load average: 0.00, 0.00, 0.00
# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/ide/host0/bus0/target0/lun0/part1
                      2.0G  483M  1.4G  26% /
/dev/ide/host0/bus0/target0/lun0/part6
                       33G  -64Z   31G 101% /home

I did notice that if I created a file (cat /dev/zero >/home/foo) of 
significant size that I could make it look normal again.. So I figure 
it's an underflow in some count.

Crazy huh?  Well, I unmounted /home and did an fsck -f  on the partition 
and remounted it.  Then everything looked okay.

---

Well today on a different server (that I have not cleaned off yet) that 
has been up and running for 6 months is saying the same thing:

# uptime
 10:39:16 up 181 days,  2:42,  2 users,  load average: 0.00, 0.00, 0.00
# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/ide/host0/bus0/target0/lun0/part1
                      2.0G  483M  1.4G  26% /
/dev/ide/host0/bus0/target0/lun0/part6
                       33G  -64Z   31G 101% /home

Now, this server is still in production.  I could bring it down for a 
brief time to fsck or reboot it, but I'd be afraid to.  du -h /home 
shows that really only 268M is used.

If I create a large file (176M) in /home it then don't underflow on the 
df, but is still incorrect.


Is this a known issue with ext3? Or ext2?  Anything I should or should 
not do about it? 


Thanks,
 Davy





BTW- df -k looks like
# df -k
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/ide/host0/bus0/target0/lun0/part1
                       2054064    493660   1454380  26% /
/dev/ide/host0/bus0/target0/lun0/part6
                      33690964 -73786976294838186940  31971456 101% /home

