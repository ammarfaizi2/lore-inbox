Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSHUQso>; Wed, 21 Aug 2002 12:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSHUQso>; Wed, 21 Aug 2002 12:48:44 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:36331 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S318389AbSHUQsn>;
	Wed, 21 Aug 2002 12:48:43 -0400
Message-ID: <3D63C533.90706@acm.org>
Date: Wed, 21 Aug 2002 11:52:03 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] IPMI driver for Linux
References: <3D63B612.8020706@acm.org> <1029945764.26845.93.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Wed, 2002-08-21 at 16:47, Corey Minyard wrote:
>  
>
>>I have been working on an IPMI driver for Linux for MontaVista, and I 
>>think it's ready to see the light of day :-).  I would like to see this 
>>included in the mainstream kernel eventually.   You can get it at 
>>http://home.attbi.com/~minyard.  It should work on any kernel version, 
>>although you will have to fix up the Config.in and Makefile, and the 
>>Configure.help stuff may not work (it's currently in the 2.4 location).
>>
>>The web page has documentation on the driver, and documentation is 
>>included in the patch, too.  This is a fairly full-featured driver with 
>>a watchdog, panic event generation, full kernel and userland access to 
>>the driver, multi-user/multi-interface support, and emulators for other 
>>IPMI device drivers.
>>    
>>
>
>Comments in general.
>
>It touches user space with spinlocks held -> bad idea
>
Oops, thanks.  I've uploaded a version that fixes this.  I only found 
one instance of this, but it's pretty bad.

>It doesnt check copy_*_user returns instead commenting that some other
>driver didnt so it wont - bad idea too
>
This was only in the emulation code.  I debated about this, but it's 
quite possible that doing the check will break the current users of this 
code.  I'm afraid if I add the checks it will cause other broken code to 
not work.  I could pull out the emulation code and supply it separately; 
I would probably choose to not put that part into the mainstream kernel, 
anyway.

>It seems to be allocating a major - can you have > 1 ipmi per host, can
>it use misc devices, can it get one registered properly with lanana
>
Yes, you can have multiple IPMI interfaces on a host (I have a board 
that has 3!).  There are serial-port interfaces planned that could also 
easily have multiple instances as well as an on-board KCS.  If there's 
an easy way to do this with a minor device, I'm all ears, but I'd prefer 
to have a separate device for each interface.  This is one of the things 
I wanted discussion about.  Once that gets settled, I'll go to lanana. 
 Right now it's just being auto-assigned.

>Otherwise its way way way nicer than the hideous thing a certain chip
>vendor sent me.
>  
>
I know what you mean.

Thank you for your response and suggestions.

-Corey
minyard@acm.org

