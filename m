Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129414AbQKVRtn>; Wed, 22 Nov 2000 12:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129415AbQKVRte>; Wed, 22 Nov 2000 12:49:34 -0500
Received: from ikar.t17.ds.pwr.wroc.pl ([156.17.210.253]:23825 "HELO
        ikar.t17.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
        id <S129414AbQKVRt2>; Wed, 22 Nov 2000 12:49:28 -0500
Date: Wed, 22 Nov 2000 17:17:31 +0100
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
To: linux-kernel@vger.kernel.org
Subject: setrlimit() and 2.4.0-test11
Message-ID: <20001122171731.B13272@pld.ORG.PL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
X-Operating-System: Linux dark 4.0.20 #119 Tue Jan 16 12:21:53 MET 2001 i986 pld
X-Team: Polish Linux Distribution Team Member
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is probably broken (I didnt't saw any disscusion about this here,
I missed it?).

when I try to start first user process I get:
4366  fork()                            = -1 EAGAIN (Resource temporarily unavailable)
but strace show proper value passed to setrlimit() -- 40 max number of processes:
4366  setrlimit(0x6 /* RLIMIT_??? */, {rlim_cur=40, rlim_max=40}) = 0

On test10 everything is ok.

This change broke test11 ?

diff -u --recursive --new-file v2.4.0-test10/linux/fs/proc/array.c linux/fs/proc/array.c
--- v2.4.0-test10/linux/fs/proc/array.c Tue Oct 31 12:42:27 2000
+++ linux/fs/proc/array.c       Tue Nov 14 11:22:36 2000
@@ -372,7 +372,7 @@
                task->start_time,
                vsize,
                mm ? mm->rss : 0, /* you might want to shift this left 3 */
-               task->rlim ? task->rlim[RLIMIT_RSS].rlim_cur : 0,
+               task->rlim[RLIMIT_RSS].rlim_cur,
                mm ? mm->start_code : 0,
                mm ? mm->end_code : 0,
                mm ? mm->start_stack : 0,

I need patch.

-- 
Arkadiusz Mi¶kiewicz, AM2-6BONE    [ PLD GNU/Linux IPv6 ]
http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/   [ enabled ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
