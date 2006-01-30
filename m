Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWA3PKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWA3PKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWA3PKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:10:51 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:11753 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932307AbWA3PKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:10:50 -0500
Message-ID: <43DE2DAC.9020708@aitel.hist.no>
Date: Mon, 30 Jan 2006 16:15:56 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Howard Chu <hyc@symas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43DDD1DA.6060507@aitel.hist.no> <Pine.LNX.4.61.0601300818290.28552@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0601300818290.28552@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>On Mon, 30 Jan 2006, Helge Hafting wrote:
>
>  
>
>>linux-os (Dick Johnson) wrote:
>>
>>    
>>
>>>To fix the current problem, you can substitute usleep(0); It will
>>>give the CPU to somebody if it's computable, then give it back to
>>>you. It seems to work in every case that sched_yield() has
>>>mucked up (perhaps 20 to 30 here).
>>>
>>>
>>>      
>>>
>>Isn't that dangerous?  Someday, someone working on linux (or some
>>other unixish os) might come up with an usleep implementation where
>>usleep(0) just returns and becomes a no-op.  Which probably is ok
>>with the usleep spec - it did sleep for zero time . . .
>>    
>>
>
>Dangerous?? You have a product that needs to ship. You can make
>it work by adding a hack. You add a hack. I don't see danger at
>all. I see getting the management off the back of the software
>engineers so that they can fix the code. Further, you __test__ the
>stuff before you ship. If usleep(0) just spins, then you use
>usleep(1).
>  
>
The dangerous part was that usleep(0) works as a "yield"
today, as your testing will confirm before you ship the product.
But it may break next year if someone changes this part of
the kernel.  Then your customer suddenly have a broken product.

Helge Hafting
