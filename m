Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWDHBPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWDHBPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWDHBPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:15:12 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:4118 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751387AbWDHBPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:15:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XAgeP0UVqdPQp78EC+wBcYNsXUgIHQs1dKCot2pYPQleAg5L6EXQPZ2O5nYmCESD7jmiCwEb6fTJg3/LPZ2gbZE80Inmtpn+WdIPBxu1szizRF5d4TuTHfsLMbO2LBJhUkcAa8CJnV7QpLJo3iSElRGe2He42+WU0k/Ts0TQzMs=
Message-ID: <44370E9B.8060309@gmail.com>
Date: Fri, 07 Apr 2006 21:15:07 -0400
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.17-rc1-mm1 - detects buggy TSC on GEODE
References: <20060404014504.564bf45a.akpm@osdl.org>	<4436D275.2010402@gmail.com> <20060407170706.1ae11ea1.akpm@osdl.org>
In-Reply-To: <20060407170706.1ae11ea1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jim Cromie <jim.cromie@gmail.com> wrote:
>   
>> FYI, 
>>
>> as the 2 syslog extracts show;
>> 1.   the new kernel is now detecting the buggy TSC on the GEODE-sc1100
>> 2.    the bug is apparently correctable by passing 'idle=poll' on kernel 
>> boot-line.
>>
>> Heres one vendor's bug/erratta description:
>>     http://soekris.com/Issue0003.htm
>>
>>
>> Apr  7 11:42:01 truck kernel: [   19.160016] Kernel command line: 
>> console=ttyS0,115200n81 root=/dev/nfs 
>> nfsroot=192.168.42.1:/nfshost/soekris 
>> nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
>> panic=5   BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
>> Apr  7 11:42:01 truck kernel: [   24.314851] Time: tsc clocksource has 
>> been installed.
>> Apr  7 11:42:01 truck kernel: [   29.977802] TSC appears to be running 
>> slowly. Marking it as unstable
>> Apr  7 11:42:01 truck kernel: [   20.460000] Time: pit clocksource has 
>> been installed.
>>
>>
>> Apr  7 12:35:56 truck kernel: [   21.562573] Kernel command line: 
>> console=ttyS0,115200n81 root=/dev/nfs 
>> nfsroot=192.168.42.1:/nfshost/soekris 
>> nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
>> panic=5  idle=poll BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
>> Apr  7 12:35:56 truck kernel: [   21.563049] using polling idle threads.
>> Apr  7 12:35:56 truck kernel: [   28.393469] Time: tsc clocksource has 
>> been installed.
>>
>>
>> Its nice to see the buggy TSC detector detect, and the work-around work.
>>     
>
> hm.
>
> John, does this mean that enable-tsc-for-amd-geode-gx-lx.patch is only safe
> to merge after all your time-management patches have gone in?
>
>   

that patch adds only MGEODE_LX, MGEODEGX1 was already there.

per the soekris link:

The net4801 board use a new single chip x86 processor from National 
Semiconductor, the SC1100. It is based on the Cyrix GX1 core and the 
CS5530 support chip, but has some difference. So far we have identified 
the following issues that might need a patch to the operating system:

So, by a narrow reading, the current Kconfig already enables the TSC for 
my board.
IOW, the patch doesnt worsen the situation.  I dont know whether the bug 
affects MGEODE_LX,
but it sounds like it could be a different core, w/o the bug.

The only folks possibly hurt by this patch are those who have 
mis-selected MGEODE_LX
when they have a MGEODEGX1, and are currently protected from using the 
buggy TSC.

my $.02, keep it in.
