Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHZFiZ>; Mon, 26 Aug 2002 01:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSHZFiY>; Mon, 26 Aug 2002 01:38:24 -0400
Received: from mail.spylog.com ([194.67.35.220]:19074 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S317898AbSHZFiY>;
	Mon, 26 Aug 2002 01:38:24 -0400
Date: Mon, 26 Aug 2002 09:42:33 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx & software raid5 & 2.4.20pre2 (Happened terrible)
Message-ID: <20020826054233.GA12073@an.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.


1. kernel 2.4.20pre2
   hardware Intel LanceWood L440GX with onboard AIC controller
   4 hdd, "Vendor: IBM       Model: DDYS-T18350M      Rev: S93E
 
2. software raid5:

 Personalities : [raid1] [raid5] [multipath] 
 read_ahead 1024 sectors
 md0 : active raid5 sdd2[3] sdc2[2] sdb2[1] sda2[0]
       52146624 blocks level 5, 64k chunk, algorithm 2 [4/4] [UUUU]
      
 unused devices: <none>

3. log:

...
Aug 21 16:37:29 ruby kernel: 09:00: rw=0, want=140379796, limit=52146624
Aug 21 16:37:29 ruby kernel: attempt to access beyond end of device
Aug 21 16:37:29 ruby kernel: 09:00: rw=0, want=1938395668, limit=52146624
Aug 21 16:37:29 ruby kernel: attempt to access beyond end of device
Aug 21 16:37:29 ruby kernel: 09:00: rw=0, want=1971900992, limit=52146624
Aug 21 16:37:29 ruby kernel: attempt to access beyond end of device
Aug 21 16:37:29 ruby kernel: 09:00: rw=0, want=1971900992, limit=52146624
Aug 21 16:37:29 ruby kernel: attempt to access beyond end of device
Aug 21 16:37:29 ruby kernel: 09:00: rw=0, want=140379796, limit=52146624
Aug 24 16:30:49 ruby kernel: attempt to access beyond end of device
Aug 24 16:30:49 ruby kernel: 09:00: rw=0, want=140379796, limit=52146624
Aug 24 16:30:49 ruby kernel: attempt to access beyond end of device
Aug 24 16:30:49 ruby kernel: 09:00: rw=0, want=1938395668, limit=52146624
Aug 24 16:30:49 ruby kernel: attempt to access beyond end of device
Aug 24 16:30:49 ruby kernel: 09:00: rw=0, want=1971900992, limit=52146624
Aug 24 16:30:49 ruby kernel: attempt to access beyond end of device
Aug 24 16:30:49 ruby kernel: 09:00: rw=0, want=1971900992, limit=52146624
Aug 24 16:30:49 ruby kernel: attempt to access beyond end of device
Aug 24 16:30:49 ruby kernel: 09:00: rw=0, want=140379796, limit=52146624
...

4. after uptime 8 day /dev/md0 - go "read-only"
   (tune2fs enable on /dv/md0 "Errors behavior:Remount read-only")
   and e2fsck found many error (empty lost+found)


Question: why such can occur and what to make to avoid repetition?

-- 
bye.
Andrey Nekrasov, SpyLOG.
