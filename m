Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315808AbSEEB04>; Sat, 4 May 2002 21:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315809AbSEEB0z>; Sat, 4 May 2002 21:26:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55818 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315808AbSEEB0z>; Sat, 4 May 2002 21:26:55 -0400
Message-ID: <3CD47BA7.9080006@evision-ventures.com>
Date: Sun, 05 May 2002 02:24:07 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <Pine.LNX.4.44.0205031110550.1602-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Fri, 3 May 2002, Martin Dalecki wrote:
> 
> 
>>Uz.ytkownik Andi Kleen napisa?:
>>
>>>Hi,
>>>
>>>When booting an preemptible kernel 2.5.13 kernel on x86-64 I get
>>>very quickly an scheduling in interrupt BUG. It looks like the
>>>preempt_count becomes 0 inside the ATA interrupt handler. This
>>>could happen when save_flags/restore_flags and friends are unmatched
>>>and you have too many flags restores in IDE.
>>
>>Thank you for pointing out. I will re check it.
> 
> 
> Martin, may I suggest that the next line of cleanups should be to remove
> all vestiges of the old global interrupt locking from the IDE driver?
> Including, for example, the crap "PCI method 1" access stuff in CMD640x..
> 
> Also, if you turn on spinlock debugging, that tends to help find the
> really silly things faster (leaving the harder races to be solved by
> brainforce ;)


OK, lest's make a deal you do the following and - realize
immediately that there is a need for single argument
time_past() or whatever and I turn spinlock debugging on :-).

[root@kozaczek linux]# find ./ -name "*.[ch]" -exec grep time_after /dev/null {} 
\; | wc
     265    1638   21285
[root@kozaczek linux]# find ./ -name "*.[ch]" -exec grep time_after /dev/null {} 
\; | grep jiffies | wc
     239    1497   19080
[root@kozaczek linux]#






