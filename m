Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJPWBo>; Wed, 16 Oct 2002 18:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSJPWBo>; Wed, 16 Oct 2002 18:01:44 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:60
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261508AbSJPWBm>; Wed, 16 Oct 2002 18:01:42 -0400
Message-ID: <3DADE4C0.9030809@rackable.com>
Date: Wed, 16 Oct 2002 15:14:24 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: mcuss@cdlsystems.com, jamesclv@us.ibm.com, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
References: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com> <200210161228.58897.jamesclv@us.ibm.com> <0d3901c2754c$7bf17060$2c0e10ac@frinkiac7> <3DADD064.8010707@rackable.com> <20021016214455.GA9624@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 22:07:40.0148 (UTC) FILETIME=[71827340:01C27560]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:

>On Wed, Oct 16, 2002 at 01:47:32PM -0700, Samuel Flory wrote:
>  
>
>>  Try shutting off hyperthreading in the bios.  Keep in mind 
>>hyperthreading is net loss if you are running a single nonthreaded app. 
>>Also you might want to check if there aren't io speed issues.  
>>    
>>
>
>Is this true? It seems to me that the 'on-demand execution units' would
>simply be devoted to the one task, resulting in zero loss.
>  
>

  In perfect world yes, but in reality there is overhead.  I've tested 
this on a quad xeon.  A "make bzImage" is a bit faster with 
hyperthreading off.  Of course a make -j 8 bzImage is faster with 
hyperthreading on.  I haven't tried this on a dual xeon.  (It could be a 
scaling issue 4 vs 8 processors.)

>I see hyperthreading becoming a problem if two threads are scheduled to
>execute at the same time before the operating system, and if they each
>need access to the same execution units at the same time.
>  
>
And if both threads need different items in L(whatever) cache it gets 
even worse.

There are a few good overviews on the subject:
http://www.intel.com/technology/hyperthread/
http://arstechnica.com/paedia/h/hyperthreading/hyperthreading-1.html
http://www.anandtech.com/cpu/showdoc.html?i=1576&p=2

