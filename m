Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271585AbRHPQVc>; Thu, 16 Aug 2001 12:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271586AbRHPQVW>; Thu, 16 Aug 2001 12:21:22 -0400
Received: from N23ch-01p18.ppp11.odn.ad.jp ([61.116.127.18]:35067 "HELO
	220fx.luky.org") by vger.kernel.org with SMTP id <S271585AbRHPQVP>;
	Thu, 16 Aug 2001 12:21:15 -0400
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: 4.7GB DVD-RAM geometry wrong?
In-Reply-To: <20010816232312R.shibata@luky.org>
In-Reply-To: <20010816165326B.shibata@luky.org>
	<20010816101007.T4352@suse.de>
	<20010816232312R.shibata@luky.org>
X-Face: (p:N+d=)]R.hGpO.WD'FWD}r"'N]'G~TQL>ZMHN6Ev":krdN|{+={]m/yqX7|9Qzu[eX[+}
 ^=d9Vr7#OCKV?ZAYq=#iG2v&fyuJZWeVwGrmTRvpcWiSTzga-$8/W\XR"r]63S56VQ@[8w}/;iq)sm
 1=B_r2J$Uf~aN5@8f2Fk$Oa[wZ
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010817012612Y.shibata@luky.org>
Date: Fri, 17 Aug 2001 01:26:12 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for too much frequent report.

With CVS UDF driver source tree from http://sourceforge.net/cvs/ and
2.4.9-pre4 seems almost the same result below...

It can not grow up from 37% disk usage...

> > So could you reproduce with latest -ac or Linus kernel + CVS UDF?
> 
> At first, I tried it with 2.4.9-pre4 and udf-0.9.4.1.
> I did not get segv nor Oops with them.
> 
> But it seems bad yet.
> 
> My operations are here.
> # mkudf /dev/hdb
> # mount -t udf /dev/hdb /mnt/floppy/
> # cp -auv ~/dir /mnt/floppy/ 1> /tmp/cp.log 2> /tmp/cp.log &
> 
> "cp" seems good until following "df" point.
> /dev/hdb               4470016   1639798   2830218  37% /mnt/floppy
> 
> After that point, "tail -f /tmp/cp.log" shows "cp going :-)" and
> my DVD-RAM driveseeks like working good.
> But result of "df" command is not change. 
> (it shows 37% forever...)
> 
> "df -i" shows
> /dev/hdb             1440735   25626 1415109    2% /mnt/floppy
> 
> tails of dmesg are;
> UDF-fs INFO UDF 0.9.4.1-rw (2001/06/13) Mounting volume '', timestamp 2001/08/16 21:54 (121c)
> hdb: irq timeout: status=0xd0 { Busy }
> hdb: ATAPI reset complete
> hdb: irq timeout: status=0xd0 { Busy }
> hdb: ATAPI reset complete
> hdb: irq timeout: status=0xd0 { Busy }
> hdb: ATAPI reset complete
> hdb: irq timeout: status=0xd0 { Busy }
> hdb: ATAPI reset complete
> hdb: irq timeout: status=0xd0 { Busy }
> hdb: ATAPI reset complete
> 
> I will try with CVS udf patch and will report it.

Thanks.

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata @ Fukuoka, JAPAN
0(mmm)0 IRC: #luky
   ~    http://his.luky.org/ http://hoop.euqset.org/
