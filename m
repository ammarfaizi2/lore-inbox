Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316440AbSEORC2>; Wed, 15 May 2002 13:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316442AbSEORC1>; Wed, 15 May 2002 13:02:27 -0400
Received: from holomorphy.com ([66.224.33.161]:34978 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316440AbSEORC0>;
	Wed, 15 May 2002 13:02:26 -0400
Date: Wed, 15 May 2002 10:00:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020515170025.GF27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <200205151514.g4FFEmY13920@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44L.0205151310130.9490-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Denis Vlasenko wrote:
>> I think two patches for same kernel piece at the same time is
>> too many. Go ahead and code this if you want.

On Wed, May 15, 2002 at 01:13:33PM -0300, Rik van Riel wrote:
> OK, here it is.   Changes against yesterday's patch:
> 1) make sure idle time can never go backwards by incrementing
>    the idle time in the timer interrupt too (surely we can
>    take this overhead if we're idle anyway ;))
> 2) get_request_wait also raises nr_iowait_tasks (thanks akpm)
> This patch is against the latest 2.5 kernel from bk and
> pretty much untested. If you have the time, please test
> it and let me know if it works.

Boots compiles and runs on an 4-way physical HT box. I didn't wake
the evil twins to cut down on the number of variables so it stayed
4-way despite the ability to go 8-way.

Sliding window of 120 seconds, sampled every 15 seconds, under a
repetitive kernel compile load:

Wed May 15 09:56:37 PDT 2002
cpu  60701 0 5137 203545 9327
cpu0 15048 0 1566 50868 2298
cpu1 15257 0 1176 50818 2392
cpu2 15248 0 1346 50802 2247
cpu3 15148 0 1049 51057 2390

Wed May 15 09:56:52 PDT 2002
cpu  66304 0 5543 203545 9327
cpu0 16460 0 1656 50868 2298
cpu1 16606 0 1330 50818 2392
cpu2 16655 0 1441 50802 2247
cpu3 16583 0 1116 51057 2390

Wed May 15 09:57:07 PDT 2002
cpu  71877 0 5980 203545 9327
cpu0 17849 0 1769 50868 2298
cpu1 17972 0 1466 50818 2392
cpu2 18060 0 1539 50802 2247
cpu3 17996 0 1206 51057 2390

Wed May 15 09:57:22 PDT 2002
cpu  77446 0 6420 203545 9327
cpu0 19269 0 1852 50868 2298
cpu1 19328 0 1612 50818 2392
cpu2 19448 0 1653 50802 2247
cpu3 19401 0 1303 51057 2390

Wed May 15 09:57:37 PDT 2002
cpu  83031 0 6843 203545 9327
cpu0 20699 0 1924 50868 2298
cpu1 20704 0 1738 50818 2392
cpu2 20846 0 1757 50802 2247
cpu3 20782 0 1424 51057 2390

Wed May 15 09:57:52 PDT 2002
cpu  87432 0 7216 204779 9328
cpu0 21788 0 2000 51205 2298
cpu1 21737 0 1845 51180 2393
cpu2 21871 0 1806 51230 2247
cpu3 22036 0 1565 51164 2390

Wed May 15 09:58:07 PDT 2002
cpu  93003 0 7653 204779 9328
cpu0 23178 0 2112 51205 2298
cpu1 23134 0 1950 51180 2393
cpu2 23281 0 1898 51230 2247
cpu3 23410 0 1693 51164 2390

Wed May 15 09:58:22 PDT 2002
cpu  98583 0 8082 204779 9328
cpu0 24538 0 2254 51205 2298
cpu1 24521 0 2065 51180 2393
cpu2 24704 0 1978 51230 2247
cpu3 24820 0 1785 51164 2390


It looks very constant, not sure if it should be otherwise.


Cheers,
Bill
