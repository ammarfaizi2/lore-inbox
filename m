Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268206AbRHKPkN>; Sat, 11 Aug 2001 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbRHKPkD>; Sat, 11 Aug 2001 11:40:03 -0400
Received: from james.kalifornia.com ([208.179.59.2]:51768 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S268206AbRHKPju>; Sat, 11 Aug 2001 11:39:50 -0400
Message-ID: <3B7551C8.4080303@blue-labs.org>
Date: Sat, 11 Aug 2001 11:39:52 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: VM nuisance
In-Reply-To: <E15VYaU-0002aw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>Followup to:  <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
>>By author:    Rik van Riel <riel@conectiva.com.br>
>>In newsgroup: linux.dev.kernel
>>
>>>I haven't got the faintest idea how to come up with an OOM
>>>killer which does the right thing for everybody.
>>>
>>Basically because there is no such thing?
>>
>
>And also because 
>
>-	people mix OOM and thrashing handling up - when they are logically
>	seperated questions.
>

I understand this, I use reiserfs and because of this there is an 
increased baseline for "no more memory".  This leads to your last 
paragraph below.  The problem is that the OOM handler hasn't been made 
aware of this.

Don't we already measure VM pressure?  It may be a hack but we could 
adjust the triggerpoint of the OOM handler on a sliding scale 
proportionate to the VM pressure, could we not?  I think that is the 
most simple hack until we have a decent resource baseline in place..each 
subsystem would keep a tally of how much required memory it had/wanted 
and that way, the OOM handle would be much more intelligent about when 
to fire.

So this posits two questions.

- How hard/how much time.. is a sliding pressure scale hack to implement

- How hard/how much time.. to implement resource baselines (or similar 
concept)

David

>-	The 2.4 VM goes completely gaga under high load. Its beautiful under
>	light loads, there nobody can touch it, but when you actually really
>	need it - splat. 
>
>
>So people either need to get an OOM when they are not but in fact might
>thrash, or the box thrashes so hard it makes insufficient progress to
>actually get out of memory.
>
>OOM is also very hard to get right without reservations tracking in kernel
>for the journalling file systems and other similar stuff. To an extent
>thrash handling also wants RSS limits.
>

