Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbTCIMST>; Sun, 9 Mar 2003 07:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTCIMST>; Sun, 9 Mar 2003 07:18:19 -0500
Received: from static-ctb-210-9-247-209.webone.com.au ([210.9.247.209]:40204
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id <S262501AbTCIMSR>; Sun, 9 Mar 2003 07:18:17 -0500
Message-ID: <3E6B337E.70804@cyberone.com.au>
Date: Sun, 09 Mar 2003 23:28:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@digeo.com>
Subject: 2.5.64-mm4 tiobench (as vs dl)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
We are making progress in the IO scheduler department. No benchmarks to the
list for a while so here is everyone's favourite (formatted for 
readability).

If you are interested in IO performance, please try out the latest mm tree
and test as vs. deadline. If AS damages important your IO loads, please
report them to me and Andrew. Thanks.


UP PIII 1.0GHz 256MB
Kernel is plain 2.5.64-mm4

Antched-8192 is simply Antsched with 8192 request slots each for reads
and writes. It is there for interest - it hits platter speed on my rusty
old IDE disk in the seq tests. Other results have standard number of
requests.

File (set) size is 512MB
Block size is 4096

                   Num               Avg     Max    CPU
Identifier         Thr  Rate  CPU%   Lat     Lat    Eff
Sequential Reads
------------------ ---  ----  -----  ------  -----  ---
Deadline            32  10.8   3.8%   10       870  284
Deadline            64  10.1   3.5%   19      1706  288
Deadline           128   8.2   2.9%   32     32179  287
 
Antsched            32  21.3   7.8%    5      2056  275
Antsched            64  21.0   7.7%    8      9293  273
Antsched           128  18.7   6.9%   15     15417  272
 
Antsched-8192       32  19.7   7.5%    6      1804  261
Antsched-8192       64  26.3   9.2%    6      2834  285
Antsched-8192      128  23.0   8.6%   14      5005  266
 
Random Reads
------------------ ---  ----  -----  ------  -----  ---
Deadline            32   0.8   0.5%  122       405  158
Deadline            64   0.8   0.6%  234       593  135
Deadline           128   0.8   0.6%  369      1010  135
 
Antsched            32   0.9   0.7%  117       994  119
Antsched            64   0.9   0.7%  165      1946  121
Antsched           128   1.0   0.7%  262      3558  136
 
Antsched-8192       32   0.8   0.7%  129      1280  112
Antsched-8192       64   0.9   0.7%  177      2177  123
Antsched-8192      128   1.0   0.7%  294      3639  132
 
Sequential Writes
------------------ ---  ----  -----  ------  -----  ---
Deadline            32  19.6  22.4%    3     14430   87
Deadline            64  19.1  21.9%    6     22190   87
Deadline           128  18.7  21.9%    9     23285   86
 
Antsched            32  19.1  21.8%    3     14858   88
Antsched            64  19.1  22.1%    5     19031   87
Antsched           128  18.0  20.7%   10     25844   87
 
Antsched-8192       32  22.6  26.2%    3      9139   86
Antsched-8192       64  23.2  28.0%    3      8517   83
Antsched-8192      128  22.2  26.8%    3     10933   83
 
Random Writes
------------------ ---  ----  -----  ------  -----  ---
Deadline            32   0.8   0.6%    3      2501  129
Deadline            64   0.8   0.7%   10      5128  118
Deadline           128   0.8   0.6%   21      6611  122

Antsched            32   0.8   0.6%    1      1024  124
Antsched            64   0.8   0.7%   11      2687  114
Antsched           128   0.8   0.7%   13      7445  112

Antsched-8192       32   1.0   0.8%    0.02      1  130
Antsched-8192       64   1.0   0.8%    0.03     30  128
Antsched-8192      128   0.9   0.7%    0.03     21  128

