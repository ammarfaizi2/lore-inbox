Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267826AbTBJMs3>; Mon, 10 Feb 2003 07:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267829AbTBJMs3>; Mon, 10 Feb 2003 07:48:29 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:39114 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267826AbTBJMs2>; Mon, 10 Feb 2003 07:48:28 -0500
Message-ID: <3E47A1E5.6020902@namesys.com>
Date: Mon, 10 Feb 2003 15:58:13 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@digeo.com>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <20030210120916.GD31401@dualathlon.random>
In-Reply-To: <20030210120916.GD31401@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the following a fair summary?

There is a certain minimum size required for the IOs to be cost 
effective.  This can be determined by single reader benchmarking.  Only 
readahead and not anticipatory scheduling addresses that.

Anticipatory scheduling does not address the application that spends one 
minute processing every read that it makes.  Readahead does.

Anticipatory scheduling does address the application that reads multiple 
files that are near each other (because they are in the same directory), 
and current readahead implementations (excepting reiser4 in progress 
vaporware) do not.

Anticipatory scheduling can do a better job of avoiding unnecessary 
reads for workloads with small time gaps between reads than readahead 
(it is potentially more accurate for some workloads).

Is this a fair summary?

-- 
Hans


