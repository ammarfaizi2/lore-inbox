Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbSJNTLN>; Mon, 14 Oct 2002 15:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSJNTLN>; Mon, 14 Oct 2002 15:11:13 -0400
Received: from cynaptic.com ([128.121.116.181]:10763 "EHLO cynaptic.com")
	by vger.kernel.org with ESMTP id <S262106AbSJNTLM>;
	Mon, 14 Oct 2002 15:11:12 -0400
From: "Eff Norwood" <enorwood@effrem.com>
To: <linux-kernel@vger.kernel.org>
Subject: Why so many intr/s? VM problem?
Date: Mon, 14 Oct 2002 12:17:03 -0700
Message-ID: <CFEAJJEGMGECBCJFLGDBOEGECFAA.enorwood@effrem.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a 2.4.18 kernel running on a dual 2.4Ghz Xeon platform using software
RAID 5 via IBM's EVMS and EXT3. The system is being used as an NFS server
and although local disk performance is excellent, NFS performance (over UDP
and TCP, vers 2 and 3 with multiple different client mount block sizes) is
poor to bad. Looking at mpstat while the system is under load shows the
%system to be quite high (94-96%) but most interestingly shows the number of
intr/s (context switches) to be 17-18K plus!

Since I was not sure what was causing all of these context switches, I
installed SGI kernprof and ran it during a 15 minute run. I used this
command to start kernprof: 'kernprof -r -d time -f 1000 -t pc -b -c all' and
this one to stop it: 'kernprof -e -i | sort -nr +2 | less >
big_csswitch.txt'

The output of this collection is located here (18Kb):

http://www.effrem.com/linux/kernel/dev/big_csswitch.txt

Most interesting to me is why in the top three results:

default_idle [c010542c]: 861190
_text_lock_inode [c015d031]: 141795
UNKNOWN_KERNEL [c01227f0]: 101532

that default_idle would be the highest value when the CPUs showed 94-96%
busy. Also interesting is what UNKNOWN_KERNEL is. ???

The server described above has 14 internal IDE disks configured as software
Raid 5 and connected to the network with one Syskonnect copper gigabit card.
I used 30 100 base-T connected clients all of which performed sequential
writes to one large 1.3TB volume on the file server. They were mounted
NFSv2, UDP, 8K r+w size for this run. I was able to achieve only 35MB/sec of
sustained NFS write throughput. Local disk performance (e.g. dd file) for
sustained writes is *much* higher. I am using knfsd with the latest 2.4.18
Neil Brown fixes from his site. Distribution is Debian 3.0 Woody Stable.

Many thanks in advance for the insight,

Eff Norwood


