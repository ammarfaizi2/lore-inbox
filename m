Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUAHPfH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUAHPfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:35:07 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:61085 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265268AbUAHPe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:34:59 -0500
Message-ID: <3FFD789D.7020908@cyberone.com.au>
Date: Fri, 09 Jan 2004 02:34:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problems in X with 2.6.0
References: <20040107102352.GA2954@piper.madduck.net> <3FFC2621.7060808@cyberone.com.au> <20040107174606.GA25307@piper.madduck.net>
In-Reply-To: <20040107174606.GA25307@piper.madduck.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



martin f krafft wrote:

>also sprach Nick Piggin <piggin@cyberone.com.au> [2004.01.07.1630 +0100]:
>
>>Can you post 20 or so lines of 'vmstat 1' captured while the problem is
>>happening? See if you can see which lines correspond to X freezing (ie.
>>watch the xterm), but that might be impossible if everything freezes.
>>
>
>procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 2  2      0 1137424 235064 456972    0    0   736   712 4303  8686 15  6 17 62
> 0  3      0 1135696 236116 457008    0    0  1000   688 4321  8004 11 15 14 61
> 2  2      0 1132336 237724 457304    0    0  1508    40 4475 10604 25 12 19 44
> 1  2      0 1129008 238852 457400    0    0  1036  1616 4476  9232 17 11 13 59
> 1  2      0 1125488 240740 457552    0    0  1836  1408 4509  9179 15 10  4 72
> 0  3      0 1121328 243212 457732    0    0  2340   988 4634 11376 27 14 12 47
> 2  5      0 1117744 245336 457920    0    0  2040    44 4538  9344 17 17 16 51
> 1  1      0 1115632 246228 458116    0    0   776   784 4339  9230 22  9  5 63
> 0  3      0 1112624 247448 458256    0    0  1108  1424 4456  9141 22 10 22 46
> 1  5      0 1110896 248104 458416    0    0   576   536 4294  8767 18  8  6 68
> 3  1      0 1107728 250068 458492    0    0  1876   792 4626  9652 20 10 23 47
> 1  2      0 1105872 251028 458620    0    0   916  1236 4399  8839 16 17 19 48
> 0  2      0 1102224 253096 458864    0    0  1956   500 4583  9880 29 11 13 49
> 2  1      0 1098896 255128 459008    0    0  1972   464 4628  9729 18  8 23 51
> 0  2      0 1096448 256500 459132    0    0  1316   920 4476  9485 18 10  3 71
> 0  3      0 1094016 257884 459244    0    0  1280  1004 4467  9896 23  9  8 59
> 0  3      0 1091328 258800 459416    0    0   848   824 4316  8754 17 17 12 53
> 1  2      0 1087744 260236 459476    0    0  1392    28 4447  9077 13  8 16 62
> 0  2      0 1086096 261028 459704    0    0   692   788 4226  8918 24  8 12 56
> 0  3      0 1085776 261284 459652    0    0   256   760 4200  7934  6  4 29 63
> 4  2      0 1083632 262220 459872    0    0   796   504 4321  9680 29 10 10 51
> 0  3      0 1082800 262924 459848    0    0   704   456 4227  7885  6 13 17 64
> 2  2      0 1081824 263500 460020    0    0   512    28 4228  9024 19  6 13 62
> 1  2      0 1080608 264360 460044    0    0   824   388 4238  9320 14  7 13 66
> 2  2      0 1079648 264964 460188    0    0   544   388 4260  8962 19  7 13 60
> 0  2      0 1078160 265800 460304    0    0   808   360 4264  8831 15  9 28 48
>
>Although I can't see a clear pattern of when exactly it froze, it
>definitely froze everytime right before outputting a line with
>r > 1. Sometimes, it also froze when r == 1 and sometimes even with
>r == 0.
>

OK so its not VM stalls. In fact, it looks like your system is
only under a moderate load.

You could try my alternate CPU scheduler which would tell us if your
problem is the scheduler or something else. Its against the mm tree.
http://www.kerneltrap.org/~npiggin/v29p6.gz


