Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTBDN6w>; Tue, 4 Feb 2003 08:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBDN6w>; Tue, 4 Feb 2003 08:58:52 -0500
Received: from k101-11.bas1.dbn.dublin.eircom.net ([159.134.101.11]:58116 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S267270AbTBDN6v>;
	Tue, 4 Feb 2003 08:58:51 -0500
Message-ID: <3E3FC898.4040809@draigBrady.com>
Date: Tue, 04 Feb 2003 14:05:12 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <3E3F9C82.7000607@Linux.ie> <3E3FBC1C.167E779A@aitel.hist.no>
In-Reply-To: <3E3FBC1C.167E779A@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Padraig@Linux.ie wrote:
> [...]
> 
>>Interesting. I just noticed that I get 50% decrease in
>>the speed of my program if I just insert a printf(). I.E.
>>my program is like:
>>
>>printf()
>>for(;;) {
>>     do_sorting_loop_test();
>>}
>>
>>If I remove the initial printf it doubles in speed?
>>I assume this is some weird caching thing?
> 
> 
> Looks like a cacheline alignment issue to me.
> This loop of yours occupy x cachelines on your cpu,
> moving it in memory by adding the printf
> might cause it to ocupy x+1 cachelines.
> That might be noticeable if x is a really small number,
> such as 1.

OK it is (as I suspected and as you explained nicely)
related to the cachelines on my CPU (866 celery).

===============================
GCC options		loops/s
===============================
gcc			2283
gcc -O3 -falign-loops=2	3451
gcc -O3 -falign-loops=4	3443
gcc -O3 -falign-loops=8	7045
gcc -march=i686 -O3	9101
===============================

cheers,
Pádraig.

