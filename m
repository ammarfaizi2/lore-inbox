Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284039AbRLAJ6c>; Sat, 1 Dec 2001 04:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281553AbRLAJ6W>; Sat, 1 Dec 2001 04:58:22 -0500
Received: from linux2.viasys.com ([194.100.28.129]:60676 "HELO mail.viasys.com")
	by vger.kernel.org with SMTP id <S284039AbRLAJ6J>;
	Sat, 1 Dec 2001 04:58:09 -0500
Date: Sat, 1 Dec 2001 11:58:03 +0200
From: Ville Herva <vherva@viasys.com>
To: linux-kernel@vger.kernel.org
Cc: thockin@sun.com, andre@linux-ide.org, support@highpoint-tech.com
Subject: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Message-ID: <20011201115803.B10839@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an addition to my reports about HPT370 corrupting data with a pair
of IBM-DPTA-373420's on linux. As a summary, my testing showed that hpt370 +
IBM-DPTA-373420 corrupt data on
                                                                                
- 2.2.18pre19 + ide patch 
- 2.2.20 + ide patch
- 2.2.20 + ide patch + Tim Hockin's hpt366.c patch                                      
- 2.2.20 + ide patch + Tim Hockin's hpt366.c patch, in UDMA33 mode (rather than UDMA66)  
- 2.4.15 + Tim Hockin's hpt366.c patch

The test involved reading /dev/md0 (that consists of /dev/hde and /dev/hdg)
several times and comparing the md5sums. I also tried reading /dev/hde and
/dev/hdg in parallel, and it did show errors. The problem disappeared when I
moved the drives over to Via 868B interface.

I reported the problem to Highpoint Tech Inc as well (they do explicitly
list IBM-DPTA-373420 as tested and compatible with HPT370), but as
anticipated, they didn't answer.


Now I bought a pair of SAMSUNG SV8004H's. Since the drives were blank, I was
able to do a write test. The test (see http://v.iki.fi/~vherva/tmp/wrchk.c
for the quick'n'dirty proggie) writes the /dev/md1 (which again consists of
the two SAMSUNG SV8004H's) full of a certain randomish 64MB block and then
tries to read it back. The write and read cycles are done over and over
again.

This is with 2.2.20 + ide + Hockin's patch. Drives are in UDMA100 mode (the
default) and no hdparm adjustions have been made.

The first write-read cycle went well, but one block mismatched already on
the second run. I've only run the test over night, but there are already
several mimatches (see http://v.iki.fi/~vherva/tmp/samsung-log for
complete log.)

Even during the succesfull first run, the IDE system gave these warningins:

  hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hdg: drive not ready for command

Later during the night, I got 27 of those errors. I also got 10 of these:

  probable hardware bug: clock timer configuration lost - probably a VIA686a.

I didn't get either of these with the IBM disks.

Smartctl shows 'No Errors Logged' for both drives. Also, it reports the
temperature of the drives being always under 35 degrees Celsius, at times
even under 30. I reckon temperatur is not a problem.

Right now I'm wondering two things:

- how come anyone else is not seeing this corruption (Abit KT7A, nevermind 
  HPT370 is fairly popular)?
- is it safe to solder the bugger off the motherboard so I can introduce it
  to my shotgun? 


regards,

-- 
Ville Herva            vherva@viasys.com             +358-40-5756996
Viasys Oy              Hannuntie 6  FIN-02360 Espoo  +358-9-2313-2160
PGP key available: http://www.iki.fi/v/pgp.html  fax +358-9-2313-2250
