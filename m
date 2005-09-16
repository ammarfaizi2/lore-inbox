Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbVIPMnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbVIPMnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbVIPMnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 08:43:03 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:44183 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1161067AbVIPMnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 08:43:01 -0400
Date: Fri, 16 Sep 2005 14:42:56 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       aurora-sparc-devel@lists.auroralinux.org, davem@redhat.com
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
In-Reply-To: <20050915.133026.21581824.davem@davemloft.net>
Message-ID: <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
 <20050915.133026.21581824.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-618788828-1126872823=:5000"
Content-ID: <Pine.BSO.4.62.0509161417340.5000@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-618788828-1126872823=:5000
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0509161417341.5000@rudy.mif.pg.gda.pl>

On Thu, 15 Sep 2005, David S. Miller wrote:

> From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
> Date: Thu, 15 Sep 2005 19:40:27 +0200 (CEST)
>
>> I'm just catch series of kernel messages with soft lockup detected reports
>> (in attachment).
>> It occures during store big amout of data on NFS volume.
>>
>> As NIC I use now Sun Swift gigabit eth (cassini driver). Probably this is
>> NFS related because I'm just browse yesterday logs and simillar was also
>> on Sun Happy Meal.
>
> Interesting.  Can you reproduce this with SLAB poisioning disabled?
> That debugging feature is extremely expensive, although it shouldn't
> make the CPU stop scheduling processes for more than 10 seconds.
> 
> I wonder if the NFS daemon code needs to have some limits put on
> how much cpu it consumes handling requests before it gives up the
> cpu.  Perhaps, it has such throttling already, I don't know.

But this not case NFS server but NSF client. During this lookups I observe 
rpciod takes 90-99% time of single processor. Load is between 10 and 20.

> I'll also try to see if there can be some kind of sparc64 specific
> issue which would cause this.
>
> Where did you get that Cassini driver btw?  It's not upstream,
> although if it exists it should be.

It is avalaible on Sun pages (Copyright by Sun by it is GPLed):

http://www.sun.com/download/index.jsp?cat=Hardware%20Drivers&tab=3

Few days ago I'm talk about this driver with spot on #aurora channel and 
it was included during prepare next kernel package.

But continue ..

Yesterday before testing NFS I was trying utilize NIC is using only 
ftp/http/rcync/scp and all works correctly (without reporting lookups). 
~23:00 CET after reported series of lookups system hangs completly. After 
restart to now I see in dmesg some known messages:

[root@boss]# dmesg | sort | uniq -c | sort -n | tail -n 2
      87 svc: bad direction 268435456, dropping request   <==========
     285 hw tcp v4 csum failed

Also I have question about second (hw tcp v4 csum failed):

[root@boss]# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:03:BA:18:41:F9
           inet addr:153.19.33.230  Bcast:153.19.33.255  Mask:255.255.255.0
           inet6 addr: fe80::203:baff:fe18:41f9/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:2361199 errors:0 dropped:0 overruns:0 frame:0
           TX packets:4060978 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:352428791 (336.1 Mb)  TX bytes:4884521951 (4658.2 Mb)
           Interrupt:192

As you see in both errors is "0". Is this correct reporting broken packets 
in kernel messages instead in RX errors ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-618788828-1126872823=:5000--
