Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269807AbRHIN4n>; Thu, 9 Aug 2001 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHIN4d>; Thu, 9 Aug 2001 09:56:33 -0400
Received: from biancha.hardboiledegg.com ([66.38.186.202]:35591 "HELO
	biancha.hardboiledegg.com") by vger.kernel.org with SMTP
	id <S269810AbRHIN4X>; Thu, 9 Aug 2001 09:56:23 -0400
Message-ID: <32774.213.7.60.90.997365391.squirrel@webmail.hbesoftware.com>
Date: Thu, 9 Aug 2001 09:56:31 -0400 (EDT)
Subject: 2.4.8-pre7: still buffer cache problems
From: "marc heckmann" <heckmann@hbesoftware.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

While 2.4.8-pre7 definitely fixes the "dd if=/dev/zero of=bigfile bs=1000k
count=bignumber" case. The "dd if=/dev/hda of=/dev/null" is still quite
broken for me. while I appreciate that it is a case of "root" doing
something stupid, it shouldn't mess up the system so badly. On 2.2.19 the
system is completely useable. on 2.4.8-pre7 it's thrashing swap like mad and
the buffercache is huge. this is all on a PPC [G3] w/ 192Mb's of RAM and
200MB's of swap. so no highmem is involved. vmstat outputs:

##############
2.2.19: [in X w/ full gnome, galeon all is very useable]

 r  b  w   swpd   free   buff  cache  si  so    bi  bo   in    cs  us  sy id
 2  0  0      0   2148  79160  25388   0   0 10112   4  174   639   6  17 76
 1  0  0      0   3164  78136  25388   0   0 10496   0  179   625   5  21 74
 1  0  0      0   2264  79208  25212   0   0 10112   1  187   612   4  21 75
 1  0  0      0   3032  78440  25212   0   0 10624   0  183   613   3  23 75
 2  0  0      0   2888  78568  25212   0   0 10496   2  184   617   5  23 73
 1  0  0      0   2768  78696  25212   0   0 10368   0  186   614   4  19  7

###############
2.4.8-pre7: [the buffer cache tends to max out at around 145mb but the
system is still trashing after we get there...]

 r  b  w   swpd free   buff  cache  si  so    bi    bo   in    cs  us  sy id
 2  1  0  57696 2648 135076   8172 648   0  3656     0  281   653  20  15 66
 0  2  0  57696 2404 135092   8172 784   0  2320     0  312   350  12   9 79
 1  1  0  58540 2096 135076   8172 360 1452   808  1452  175  274   0   4 96 
 1  2  0  59024 2036 135972   8172 772   0  1668     0  155   518  23  11 67
 1  0  0  59024 2152 136536   7936 200   0  6728     0  356   699  10  18 73
 1  2  1  59024 2656 135648   7956 368 1024  1224  1024  375  600  12   6  
                     76
 2  0  0  59560 2216 137784   7912   8 380  6216   380  254   682  15  17 69
 2  2  0  60824 2720 137956   7732 100 1772  3044  1772  191   645  9  12 79  
 1  1  0  61928 2144 139372   7656 340 508  4720   508  286   746  15   1 71
 2  2  1  62856 2036 139992   7652   4 768  3344   768  245   649   9  11 81

Hope this helps. willing to test.

Cheers,

-- 
	Marc Heckmann <heckmann@hbe.ca>
 	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/


