Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUFXJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUFXJqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUFXJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:46:06 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:17054 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264129AbUFXJqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:46:00 -0400
Message-ID: <40DAA2D2.9010008@yahoo.com.au>
Date: Thu, 24 Jun 2004 19:45:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Yusuf Goolamabbas <yusufg@outblaze.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
References: <20040624091548.GA8264@outblaze.com> <40DA9E89.9020801@yahoo.com.au> <20040624093440.GA8422@outblaze.com>
In-Reply-To: <20040624093440.GA8422@outblaze.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yusuf Goolamabbas wrote:
>>Is it an SMP system? What sort of workload is it? Does it use threads?
>>Check vmstat to see how much context switching is going on with each
>>kernel.
> 
> 
> Yes, It's an SMP (Dual P3-800). Workload is a busy mailserver (get lots
> of SMTP traffic, validate users against a remote database, reject a
> truckload of connections). CONFIG_4K_STACKS=y on the 2.6.7 box, e100
> driver with NAPI turned off. No threads 
> 

OK

> The 2.6.7 box shows this wrt context swithes
> 
> procs                      memory      swap          io     system cpu
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
>  3  0      0  73096  63000  78100    0    0     0   524 5571 14772 25 73 0  2
>  6  0      0  70932  63000  78100    0    0     0   448 5861 11368 34 65 0  1
>  7  0      0  72916  63008  78092    0    0     0    12 5838 14956 30 70 0  1
>  7  0      0  70852  63016  78084    0    0     0  1008 5551 13951 30 69 0  1
> 22  0      0  65300  63016  78084    0    0     0     0 5989 16043 34 66 0  1
> 19  0      0  66516  63020  78148    0    0     0  1252 6100 14653 31 69 0  0
> 29  1      0  67620  63024  78212    0    0     0   992 6314 14747 31 69 0  0
> 
> The 2.6.5 box shows this
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 166  0      0 137752  38148 188836    0    0     0  2424 5973 21695 30 70  0  0
> 34  0      0 135928  38160 189028    0    0     0  2160 5923 22532 32 68 0  0
> 28  1      0 136928  38184 189344    0    0     0  2904 6393 22098 31 69 0  0
> 32  1      0 136672  38204 189324    0    0     0  3240 6412 21362 32 68 0  0
> 33  0      0 135456  38216 189380    0    0     0  1708 6044 24735 28 72 0  0
> 17  0      0 135372  38264 189536    0    0     0  3044 6305 22326 35 64 0  0
> 229  0      0 135060  38272 189732    0    0     0  2340 6416 23697 33 67  0  0 32  0      0 134100  38288 189852    0    0     0  3068 6342 24016 33 67 0  0
> 16  0      0 134292  38300 190044    0    0     0  2408 6451 24727 31 69 0  0
> 

OK. They're both using 100% CPU... is 2.6.5 getting more work done?
