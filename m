Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRC3Jgj>; Fri, 30 Mar 2001 04:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRC3Jg3>; Fri, 30 Mar 2001 04:36:29 -0500
Received: from [212.17.18.2] ([212.17.18.2]:37392 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S131261AbRC3JgS>;
	Fri, 30 Mar 2001 04:36:18 -0500
Message-Id: <200103300935.QAA02956@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: Strange lines in dmesg
Date: Fri, 30 Mar 2001 16:33:14 +0700
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following lines in dmesg:

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S C144DF28  4912     1      0   840  (NOTLB)
Call Trace: [<c01111ab>] [<c01110f0>] [<c01398e5>] [<c0139c8e>] [<c01330c4>] 
[<c0106dd7>]
keventd   S FFFFFFFF  6020     2      1        (L-TLB)       3
Call Trace: [<c011d9db>] [<c01054f4>]
kswapd    S C1455FAC  5812     3      1        (L-TLB)       4     2
Call Trace: [<c01111ab>] [<c01110f0>] [<c01116ea>] [<c0127499>] [<c01054f4>]
kreclaimd  S 00000286  6316     4      1        (L-TLB)       5     3
Call Trace: [<c0111695>] [<c012754b>] [<c01054f4>]
bdflush   S C1450000  5972     5      1        (L-TLB)       6     4
Call Trace: [<c012f97e>] [<c01054f4>]
kupdated  S C147FFC8  6296     6      1        (L-TLB)     197     5

And more for other processes.

As far as I can understand lines containing 'Call Trace' are printed in 
trap.c in show_trace function. Does anyone know what this thing can mean, and 
how to found a real reason?

Problem is that on this machine I have install 2.3.2-ac26 + Morton's patch to 
allow very large processes not be killed when there are not reused pages in 
swap, etc.

My sci advisor have real problem as his process beying killed when reached 
960Mb. There is 256Mb of RAM in machine, and 1.5Gb of swap... It looks like
it is again a problem with kernel does not use all possibilities before kill 
a process.

And what worries me is that I found mentioned above lines in kernel log.

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
