Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbVBEMtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbVBEMtY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 07:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbVBEMtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 07:49:24 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:57328 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S265817AbVBEMsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 07:48:31 -0500
Message-ID: <4204C09C.2030409@tiscali.de>
Date: Sat, 05 Feb 2005 13:48:28 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
CC: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050201173622.GA1206@stilzchen.informatik.tu-chemnitz.de> <4200FAE1.4000504@tiscali.de>
In-Reply-To: <4200FAE1.4000504@tiscali.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott wrote:

> Mirko Parthey wrote:
>
>> On Mon, Jan 31, 2005 at 05:22:02PM +0100,  wrote:
>>  
>>
>>> My Debian machine hangs during shutdown, with messages like this:
>>> unregister_netdevice: waiting for br0 to become free. Usage count = 1
>>>
>>> I narrowed it down to the command
>>>  # brctl delbr br0
>>> which does not return in the circumstances shown below.
>>>
>>> The problem is reproducible with both 2.6.11-rc2 from kernel.org and 
>>> the
>>> Debian kernel-image-2.6.10-1-686.
>>> [...]
>>>   
>>
>>
>> The problem was introduced between 2.6.8.1 and 2.6.9,
>> and it is still present in 2.6.11-rc2-bk9.
>>
>> Mirko
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>  
>>
> Jep it appears in 2.6.8 and above. I don't know the process who's 
> using it:
>
> Before shutdown:
>  PID TTY          TIME CMD
>    1 ?        00:00:00 init
>    2 ?        00:00:00 ksoftirqd/0
>    3 ?        00:00:00 events/0
>    4 ?        00:00:00 khelper
>    9 ?        00:00:00 kthread
>   19 ?        00:00:00 kacpid
>   17 ?        00:00:00 vesafb
>  100 ?        00:00:00 kblockd/0
>  164 ?        00:00:00 pdflush
>  165 ?        00:00:00 pdflush
>  166 ?        00:00:00 kswapd0
>  167 ?        00:00:00 aio/0
>  168 ?        00:00:00 jfsIO
>  169 ?        00:00:00 jfsCommit
>  170 ?        00:00:00 jfsSync
>  171 ?        00:00:00 xfslogd/0
>  172 ?        00:00:00 xfsdatad/0
>  173 ?        00:00:00 xfsbufd
>  774 ?        00:00:00 kseriod
>  862 ?        00:00:00 ata/0
>  882 ?        00:00:00 kcryptd/0
>  883 ?        00:00:00 kmirrord/0
>  887 ?        00:00:00 xfssyncd
>  939 ?        00:00:00 udevd
> 1061 ?        00:00:00 devfsd
> 1242 ?        00:00:00 khubd
> 1616 ?        00:00:00 syslog-ng
> 2562 ?        00:00:00 khpsbpkt
> 2646 ?        00:00:00 knodemgrd_0
> 3987 ?        00:00:00 crond
> 4027 tty2     00:00:00 agetty
> 4028 tty3     00:00:00 agetty
> 4029 tty4     00:00:00 agetty
> 4030 tty5     00:00:00 agetty
> 4031 tty6     00:00:00 agetty
> 4473 tty1     00:00:00 bash
> 4553 tty1     00:00:00 ps
>
> And my System can't shutdown because of this bug. Currently disabling 
> this checking function seems to be the only solution (see my diff).
>
> Matthias-Christian Ott
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Well I think my problem was not ipv6 problem Herbert discribed, it was 
syslog-ng. I replaced it with metalog and it seems to work well (I'll 
test it with 2.6.11-rc3 today).

Matthias-Christian Ott
