Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132197AbRAQIPe>; Wed, 17 Jan 2001 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132343AbRAQIPR>; Wed, 17 Jan 2001 03:15:17 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:34240 "EHLO
	inet-smtp4.oracle.com") by vger.kernel.org with ESMTP
	id <S130270AbRAQIO5>; Wed, 17 Jan 2001 03:14:57 -0500
Message-ID: <3A6553F1.C1A87632@oracle.com>
Date: Wed, 17 Jan 2001 03:12:33 -0500
From: Svein Erik Brostigen <svein.brostigen@oracle.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre8, webbrowsers and proxies...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

After compiling and booting into 2.4.1-pre8, I found some strange
behaviour. I was not able to connect to any website using a http proxy.

The message I get back is: "... connection was refused by the server".
If I remove the proxy setting, everything works fine.
I have tried the following browsers: Netscape 4.75, Opera 40b5, lynx and
Konquerer. All is showing the same behaviour.

Here is output from strace on a failed connection using lynx:
1638  wait4(1640, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG, NULL)
= 1640
1638  close(4)                          = 0
1638  rt_sigaction(SIGTSTP, {SIG_IGN}, {0x4003e4b0, [],
SA_RESTART|0x4000000}, 8) = 0
1638  poll([{fd=0, events=POLLIN}], 1, 0) = 0
1638  poll([{fd=0, events=POLLIN}], 1, 0) = 0
1638  write(1, "\r\33[0;1m\17\33[33m\33[44mMaking HTT\33[15"..., 74) =
74
1638  rt_sigaction(SIGTSTP, {0x4003e4b0, [], SA_RESTART|0x4000000},
NULL, 8) = 0
1638  socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 4
1638  ioctl(4, FIONBIO, [1])            = 0
1638  connect(4, {sin_family=AF_INET, sin_port=htons(80),
sin_addr=inet_addr("206.223.27.62")}}, 16) = -1 EINPROGRESS 1638 
select(1024, NULL, [4], NULL, {0, 100000}) = 1 (out [4], left {0,
20000})
1638  connect(4, {sin_family=AF_INET, sin_port=htons(80),
sin_addr=inet_addr("206.223.27.62")}}, 16) = -1 ECONNREFUSED 1638 
close(4)                          = 0
1638  rt_sigaction(SIGTSTP, {SIG_IGN}, {0x4003e4b0, [],
SA_RESTART|0x4000000}, 8) = 0
1638  poll([{fd=0, events=POLLIN}], 1, 0) = 0
1638  poll([{fd=0, events=POLLIN}], 1, 0) = 0
1638  write(1, "\r\33[0;1m\17\33[33m\33[41mAlert!: Unable"..., 84) =
84                                                     

Here is the output from a successfull connection without a proxy using
lynx:
16265 wait4(16273, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG, NULL)
= 16273
16265 close(4)                          = 0
16265 rt_sigaction(SIGTSTP, {SIG_IGN}, {0x4003e4b0, [],
SA_RESTART|0x4000000}, 8) = 0
16265 poll([{fd=0, events=POLLIN}], 1, 0) = 0
16265 poll([{fd=0, events=POLLIN}], 1, 0) = 0
16265 write(1, "\r\33[0;1m\17\33[33m\33[44mMaking HTT\33[15"..., 75) =
75
16265 rt_sigaction(SIGTSTP, {0x4003e4b0, [], SA_RESTART|0x4000000},
NULL, 8) = 0
16265 socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 4
16265 ioctl(4, FIONBIO, [1])            = 0
16265 connect(4, {sin_family=AF_INET, sin_port=htons(80),
sin_addr=inet_addr("138.2.184.209")}}, 16) = -1 EINPROGRESS 16265
select(1024, NULL, [4], NULL, {0, 100000}) = 1 (out [4], left {0,
100000})
16265 connect(4, {sin_family=AF_INET, sin_port=htons(80),
sin_addr=inet_addr("138.2.184.209")}}, 16) = 0
16265 ioctl(4, FIONBIO, [0])            = 0
16265 brk(0x81fa000)                    = 0x81fa000
16265 rt_sigaction(SIGTSTP, {SIG_IGN}, {0x4003e4b0, [],
SA_RESTART|0x4000000}, 8) = 0
16265 poll([{fd=0, events=POLLIN}], 1, 0) = 0
16265 poll([{fd=0, events=POLLIN}], 1, 0) = 0
16265 write(1, "\r\33[0;1m\17\33[33m\33[44mSending HTTP r"..., 64) = 64
16265 rt_sigaction(SIGTSTP, {0x4003e4b0, [], SA_RESTART|0x4000000},
NULL, 8) = 0
16265 write(4, "GET / HTTP/1.0\r\nHost: stsun1.us."..., 806) = 806     


                                                     
-- 
Regards
Svein Erik

If you would know the value of money, go try to borrow some. -- Ben
Franklin 
_____________________________________________________________
Svein Erik Brostigen       e-mail: svein.brostigen@oracle.com
Senior Technical Analyst                  Phone: 407.458.7168
EBC - Extended Business Critical
Oracle Support Services   
5955 T.G. Lee Blvd
Orlando FL, 32822

Enabling the Information Age Through Internet Computing
_____________________________________________________________

The statements and opinions expressed here are my own and
do not necessarily represent those of Oracle Corporation.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
