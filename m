Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbTKESq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTKESq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:46:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:28101 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263110AbTKESqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:46:15 -0500
X-Authenticated: #4512188
Message-ID: <3FA945DD.8030105@gmx.de>
Date: Wed, 05 Nov 2003 19:47:57 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de> <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de>
In-Reply-To: <20031105123923.GP1477@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> (cc me, just caught your message by luck)
> 
> On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> 
>>>>>it's a cdrecord option, I've never used k3b so cannot comment on how to
>>>>>make it enable that.
>>>>
>>>>Hmm, I'll take a look, but I don't really think it is a problem of the 
>>>>recording programme, otherwise how could my reader read it out completely?
>>>
>>>
>>>It isn't a problem of the recorder program. But some drives wont read
>>>the very end of a disc unless there are some pad blocks at the end.
>>>Thus, you should always use the cdrecord pad option.

Well, I now used the -pad option, but now the image (naturally) gets 
larger and thus k3b reports verify fail. I think the k3b people need to 
ignore the last 00s and calc the md5sum according to the original iso 
size...

>>>Don't remember, sorry :)
>>
>>I probably will make a new topic regarding issues (I think) I found with 
>>the new mm kernel.
> 
> 
> Fine, check the SG_IO thing first though.

I am sorry, but could you explain how to find out? I dunno where to 
look... But I made your vmstat output:

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  2  0      0 579472  13976 308572    0    0   425    85 1255   645  5 
3 84  9
  2  0      0 579456  13976 308572    0    0     0     0  725   521  5 
5 91  0
  1  0      0 579448  13976 308572    0    0     0     0  736   523  2 
5 94  0
  0  0      0 579448  13976 308572    0    0     0    25  745   439  2 
6 92  0
  0  0      0 579448  13976 308572    0    0     0     0  723   541  2 
6 92  0
  1  0      0 579472  13976 308572    0    0     1    17  944   712  3 
5 89  3
  0  0      0 579280  13976 308624    0    0    35    26  919   869 11 
8 77  5
  0  0      0 579272  13976 308624    0    0     0     0  741   439  2 
6 92  0
  1  0      0 579192  13976 308624    0    0     0     2  743  1944 36 
8 56  0
  0  0      0 579200  13976 308624    0    0     0     0  741   491  3 
5 92  0
  0  0      0 579200  13976 308624    0    0     0     0  729   521  2 
5 94  0
  2  0      0 579208  13976 308624    0    0     0     0  733   478  3 
6 91  0
  0  0      0 579200  13976 308624    0    0     0     0  724   519  2 
5 94  0
  0  0      0 579216  13976 308624    0    0     0     0  739   470  3 
6 91  0
  1  0      0 579216  13976 308624    0    0     0     0  719   537  2 
6 92  0
  0  0      0 579216  13976 308624    0    0     0     0  736   495  3 
6 91  0
  0  0      0 579216  13976 308624    0    0     0    12  724   562  2 
5 94  0
  1  0      0 579200  13976 308624    0    0     0     0  844  1271  8 
6 86  0
  0  0      0 579192  13976 308624    0    0     0    17  930   815  3 
6 91  0
  0  0      0 579128  13976 308624    0    0     0     0  988  1808 28 
8 64  0
  1  0      0 579128  13976 308624    0    0     0     0  857  1056 26 
8 67  0
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  0  0      0 579136  13976 308624    0    0     0     0 1023   911 12 
9 78  0
  0  0      0 579192  13976 308624    0    0     0     0  864   883 35 
8 58  0
  1  0      0 579000  13976 308624    0    0     0     4  830   932 48 
6 46  0
  1  0      0 579000  13976 308624    0    0     0     2  922   899 33 
9 59  0
  0  0      0 578816  13976 308824    0    0   192     4  766   847 38 
8 52  2
  1  0      0 578816  13976 308824    0    0     0     0  739   500  6 
5 89  0
  0  0      0 578816  13976 308824    0    0     0     0  787   744  5 
6 89  0
  0  0      0 578816  13976 308824    0    0     0    28  759   552  3 
6 91  0
  1  0      0 578832  13980 308824    0    0     3     0  840   823 17 
8 75  0
  0  0      0 578816  13980 308820    0    0     0    10  769   696 27 
8 64  2
  0  0      0 578824  13980 308820    0    0     0     0  761   626  3 
6 91  0
  2  0      0 578816  13980 308820    0    0     0     0  765   512  6 
6 88  0
  0  0      0 578808  13980 308820    0    0     0    20  863   860 11 
5 85  0
  0  0      0 578808  13980 308820    0    0     0     0  744   524  2 
8 91  0
  1  0      0 578808  13980 308820    0    0     0     0  736   547  3 
5 92  0
  0  0      0 578808  13980 308820    0    0     0     0  890   699  8 
8 84  0
  0  0      0 578824  13980 308820    0    0     0    25  932   805  9 
5 86  0
  1  0      0 578872  13980 308824    0    0     0     1  836   913 33 
10 57  0
  1  0      0 578872  13980 308824    0    0     0     0  842   776 23 
6 71  0
  3  0      0 578872  13980 308824    0    0     0     0  889   806 17 
9 74  0
  1  0      0 578952  13980 308824    0    0     0     5  842   995 68 
9 23  0
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  2  0      0 578944  13980 308828    0    0     0    11  835   979 36 
13 52  0
  0  0      0 578944  13980 308828    0    0     0     0  843   852 38 
7 55  0
  1  0      0 578944  13980 308828    0    0     0     0 1171   650  8 
3 89  0
  0  0      0 578960  13980 308828    0    0     0     0 1182   419 13 
1 86  0
  0  0      0 578960  13980 308832    0    0     0     0 1119   371  2 
0 98  0
  2  0      0 578880  13980 308832    0    0     0     1 1269   600 16 
2 82  0
  0  1      0 578240  13980 309128    0    0   288    14 1265   626 26 
2 69  3
  0  0      0 576720  13996 309940    0    0   825    10 1333  1230 46 
6 39  9
  0  0      0 576720  13996 309952    0    0     0    10 1101   759 38 
4 57  1
  0  0      0 576528  13996 310088    0    0   128     5 1257   730 22 
2 75  1
  0  0      0 576528  13996 310088    0    0     0     0 1161   621 11 
2 87  0
  0  0      0 576624  13996 310088    0    0     0     0 1115   346  1 
1 98  0
  0  0      0 576624  13996 310088    0    0     0     0 1099   249  1 
0 99  0
  0  0      0 576624  13996 310088    0    0     0     0 1067   199  0 
0 100  0
  0  0      0 576624  13996 310088    0    0     0     0 1104   258  1 
1 98  0
  2  0      0 576632  13996 310088    0    0     0    24 1104   440  3 
2 94  0
  0  0      0 576632  13996 310088    0    0     0     0 1037   242  0 
0 100  0
  0  0      0 576640  13996 310088    0    0     0     0 1221   408  4 
0 96  0
  0  0      0 580928  13996 305988    0    0     0     0 1050   269  1 
1 98  0
  5  0      0 581008  13996 305988    0    0     0     0 1234   482 10 
2 88  0
  3  0      0 580928  13996 305988    0    0     0   223 1289  1420 88 
12  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  0  0      0 580928  13996 305988    0    0     0     0 1138  1194 39 
5 56  0
  0  0      0 580928  13996 305988    0    0     0     0 1065   145  1 
0 99  0


