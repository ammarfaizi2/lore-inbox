Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUDZUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUDZUWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUDZUWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:22:37 -0400
Received: from [81.219.144.6] ([81.219.144.6]:30478 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263460AbUDZUWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:22:25 -0400
Message-ID: <408D6F77.4060303@pointblue.com.pl>
Date: Mon, 26 Apr 2004 21:22:15 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz> <408B7C13.1000708@pointblue.com.pl> <20040425204506.GG24375@elf.ucw.cz>
In-Reply-To: <20040425204506.GG24375@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>>Second one, starting KDE, and when swap usage != 0 (just to be sure 
>>>>there is no problem with any assumption), gives me loads of error 
>>>>messages (see attached file).
>>>>  
>>>>
>>>>        
>>>>
>>>Can you try CONFIG_PREEMPT=n?
>>>	
>>>
>>>      
>>>
>>Funny, now it doesn't run BUG(), but, instead I have two way behavior. 
>>Either he is complaining that bash
>>will not stop !! or that there is not enough pages free. Both wrong and 
>>bizzareus. This really needs fixing before 2.6.6 is out (imo).
>>    
>>
>
>Dump stack at time when process refuses to stop, and see why it can't
>be stopped. Then fix that :-).
>					
>
Quite easy to say. I don't really understeand all changes that 've been 
done over mm between 2.6.6-rc2-bk2 and 2.6.5.
But from my tests today, it looks like processes locked (?) in kernel 
are not getting freezed.

Simple example. Mount something over nfs, than disconnect your network 
cable, and inside that dir run ls.
Kernel will not be able to freeze bash !!, obvioulsy bug. I'll try to 
investigate it my self, but if someone can get with fast explanation, to 
enlight me problem, that would be nice.
Nfs is maybe a tougth example. Try i.e. dd bs=1 (to make it slower) 
if=/proc/kmem of=/dev/null,
or even open mc, and press F3 on /proc/kmem, providing that your 
machines is slow.  At that point, MC on my computer eats about  900MB of 
swap ! (I  have only 128MB of ram, so it's quite strange). Anyways,
echo "4" >/proc/acpi/sleep, and kernel will not be able to freeze it.

--
GJ


