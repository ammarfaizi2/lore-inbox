Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVFQPKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVFQPKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVFQPKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:10:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50904 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261991AbVFQPKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:10:24 -0400
Message-ID: <42B2E7D2.9080705@us.ibm.com>
Date: Fri, 17 Jun 2005 08:10:10 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>	<20050616002451.01f7e9ed.akpm@osdl.org>	<1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>	<20050616133730.1924fca3.akpm@osdl.org>	<1118965381.4301.488.camel@dyn9047017072.beaverton.ibm.com> <20050616175130.22572451.akpm@osdl.org>
In-Reply-To: <20050616175130.22572451.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
>>>Try this:
>>
...
>>
>> Wow !! Reducing the dirty ratios and the above patch did the trick.
>> Instead of 100% sys CPU, now I have only 50% in sys.
> 
> 
> It shouldn't be necessary to do both.  Either the patch or the tuning
> should fix it.  Please confirm.
> 
> Also please determine whether the deep CFQ queue depth is a problem when
> the VFS tuning/patching is in place.
> 
> IOW: let's work out which of these three areas needs to be addressed.
> 

Andrew,

Sorry for not getting back earlier. I am running into weird problems.
When running "dd" write tests to 2048 ext3 filesystems, just with your
patch (no dirty ratio or CFS queue depth tuning), I see "buff" 
increasing instead of "cache" and I see "bi" instead of "bo".
Whats going on here ?

But files are getting written to and increasing in size. I am
really confused. Why are we reading stuff to buffers and not
writing to cache or disk ?

Thanks,
Badari


procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
..
  2  0      4 6339920  42712  24884    0    0     0    19  413  1237 46 
  6 48  0
  2  0      4 6233728  42748  25364    0    0     0    13  380   732 50 
  3 47  0
  0  0      4 6168192  42784  25328    0    0     0    13  336   485 44 
  2 54  0
  7 914      4 6156672  71520  24456    0    0  1559    15  336  3498  2 
13 61 24
18 1525      4 6081296 145752  24528    0    0  3789    13  813  7354 19 
36  0 45
  7 1843      4 5995024 220824  24276    0    0  3807    13  883  6637 
25 47  0 29
  6 2046      4 5898740 299228  23788    0    0  3955    13  876  6372 
25 60  0 15
13 2046      4 5790588 385156  24548    0    0  4301    13  860  7171  0 
59  0 41
13 2044      4 5676452 475736  24784    0    0  4533     0  848  7169  0 
69  0 31
18 2044      4 5557836 569840  24592    0    0  4710     0  841  7227  0 
74  0 26
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  9 2046      4 5438480 665492  24400    0    0  4785     0  833  7244 
0 77  0 23
  5 2046      4 5318292 761148  24204    0    0  4787     0  835  7152 
0 71  0 29
  5 2046      4 5197580 857284  24560    0    0  4806     8  838  7340 
0 71  0 29
18 2045      4 5078328 953056  24248    0    0  4789     0  833  7565  0 
68  0 32
11 2046      4 4958484 1049240  24556    0    0  4809     0  838  7558 
0 68  0 32
20 2044      4 4839300 1144704  24552    0    0  4777     0  840  7479 
0 67  0 33
10 2045      4 4720740 1239784  24416    0    0  4757     0  842  7446 
0 68  0 32
  6 2048      4 4602264 1334736  24408    0    0  4755     0  844  7437 
  0 66  0 34
10 2044      4 4483712 1429272  24300    0    0  4741     0  873  7433 
0 68  0 31
12 2044      4 4366552 1523220  24780    0    0  4712    17  933  7431 
0 68  0 31
  5 2047      4 4248488 1617952  24476    0    0  4753     0  873  7396 
  0 69  0 31
10 2047      4 4130764 1712128  24212    0    0  4717     0  840  7437 
0 66  0 34
  9 2046      4 4011812 1807536  24264    0    0  4776     0  839  7402 
  0 68  0 32
  9 2046      4 3892444 1903080  24180    0    0  4781     0  839  7386 
  0 70  0 30
15 2046      4 3772796 1998880  24872    0    0  4794     5  835  7358 
0 72  0 28
  5 2047      4 3656624 2092104  24528    0    0  4701     0  838  7358 
  0 67  0 33
12 2047      4 3547912 2178752  24568    0    0  4392     0  866  7246 
0 57  0 43
10 2046      4 3443524 2261348  25048    0    0  4188    16  880  7038 
0 53  0 47
  7 2045      4 3340784 2342932  24992    0    0  4149     0  868  7132 
  0 51  0 49
  1 2048      4 3239292 2423576  24328    0    0  4097     0  874  7172 
  0 50  0 50
12 2044      4 3134688 2507120  24892    0    0  4217     0  873  7294 
0 54  0 46
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  4 2047      4 3026604 2593700  24484    0    0  4349     0  869  7335 
  0 56  0 44
16 2046      4 2916504 2681900  24520    0    0  4421     0  861  7317 
0 58  0 42
  2 2047      4 2806032 2770784  24388    0    0  4451     0  865  7326 
  0 59  0 41
12 2046      4 2694388 2860208  24748    0    0  4481     0  865  7304 
0 61  0 39
  8 2044      4 2584656 2948112  24564    0    0  4423     0  857  7245 
  0 61  0 39


