Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317791AbSHCVE2>; Sat, 3 Aug 2002 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHCVE1>; Sat, 3 Aug 2002 17:04:27 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:47805 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S317791AbSHCVEY>; Sat, 3 Aug 2002 17:04:24 -0400
From: Marc Lefranc <lefranc.m@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Problem with AHA152X driver in 2.4.19
Date: 03 Aug 2002 19:02:50 +0200
Message-ID: <p6r65yrlvt1.fsf@free.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I just built 2.4.19 and checked that the problem that had been
introduced in the aha152x driver between 2.4.19-pre8 and pre10 (bad
initialization due to lost interrupt) had been corrected. However, I
have experienced another problem related to blocking factor.

Using tar without specifying a blocking factor works fine but as soon
as I specify one, tar exits with a segmentation violation immediately
after trying to write to the tape. There is a also a message about a
NULL pointer dereference written to /var/log/messages (see below).

The exact command I used is (taken from a shell script):

tar --create --blocking-factor 96 --file=/dev/st0 --listed-incremental=$JOURNAL --verbose --preserve --one-file-system --atime-preserve $1

The very same script worked flawlessly with 2.4.19-pre8 and before. If
I remove the blocking-factor option, everything is back to normal.

Marc


----------------------------------------------------------------------
Aug  3 17:44:55 socrate kernel: Unable to handle kernel NULL pointer dereference
 at virtual address 0000001b
Aug  3 17:44:55 socrate kernel:  printing eip:
Aug  3 17:44:55 socrate kernel: c68a21d9
Aug  3 17:44:55 socrate kernel: *pde = 00000000
Aug  3 17:44:55 socrate kernel: Oops: 0000
Aug  3 17:44:55 socrate kernel: CPU:    0
Aug  3 17:44:55 socrate kernel: EIP:    0010:[<c68a21d9>]    Not tainted
Aug  3 17:44:55 socrate kernel: EFLAGS: 00010002
Aug  3 17:44:55 socrate kernel: eax: 00000000   ebx: c2575000   ecx: c26e9e30   
edx: c1d9a240
Aug  3 17:44:55 socrate kernel: esi: c251c000   edi: 0000000c   ebp: c251c000   
esp: c2691e4c
Aug  3 17:44:55 socrate kernel: ds: 0018   es: 0018   ss: 0018
Aug  3 17:44:55 socrate kernel: Process tar (pid: 1141, stackpage=c2691000)
Aug  3 17:44:55 socrate kernel: Stack: 00000297 c116fdb4 c2575000 c68a22e3 c2575
000 00000000 00000000 00000000 
Aug  3 17:44:55 socrate kernel:        c687fab0 c687f517 c2575000 c687fab0 00000
000 c2575000 c116fdb4 c25750b8 
Aug  3 17:44:55 socrate kernel:        c116fdb4 c688662f c2575000 c2575000 00000
000 c251c000 c5995c00 c116fd60 
Aug  3 17:44:55 socrate kernel: Call Trace:    [<c68a22e3>] [<c687fab0>] [<c687f
517>] [<c687fab0>] [<c688662f>]
Aug  3 17:44:55 socrate kernel:   [<c6885a5f>] [<c6885ab9>] [<c68984cc>] [<c6898
300>] [<c6899ce6>] [<c0132bc8>]
Aug  3 17:44:55 socrate kernel:   [<c013266f>] [<c01088b3>]
Aug  3 17:44:55 socrate kernel: 
Aug  3 17:44:55 socrate kernel: Code: 0f b6 50 1b 8b 14 95 dc 24 27 c0 2b 82 a0 
00 00 00 69 c0 a3 

