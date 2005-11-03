Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbVKCVMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbVKCVMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbVKCVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:12:47 -0500
Received: from www.eclis.ch ([144.85.15.72]:55773 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030486AbVKCVMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:12:46 -0500
Message-ID: <436A7D4B.8080109@eclis.ch>
Date: Thu, 03 Nov 2005 22:12:43 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch>	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>	 <43695D94.10901@eclis.ch>	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>	 <43697550.7030400@eclis.ch> <1131046348.27168.537.camel@cog.beaverton.ibm.com>
In-Reply-To: <1131046348.27168.537.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :

>>So with 2.6.8 this machine have a working ntpd. Now I stopped ntpd and 
>>used your script with the server 10.0.0.1:
>>
>>03 Nov 02:46:33         offset: -0.087156       drift: -144.790697674 ppm
> 
>>As before, the ntpd is not working properly with the 2.6.14 kernel. Now 
>>I stopped ntpd and used your script with the 10.0.0.1 server:
>>
>>03 Nov 03:04:58         offset: -7.564786       drift: -12538.5986733 ppm
>>
>>Interresting! So if I understand correctly the ntpd problem is because 
>>the kernel 2.6.14 kernel show a drift about 100 time bigger than with 
>>the kernel 2.6.8 on the same hardware. For information the mainboard is 
>>the MSI K7N2 (nForce 2). Here is the cpuinfo in case that matter:
> 
> 
> Yep. Thats what I was guessing. For some reason time is running too
> quickly on your system. Since it is more then +/-500ppm NTP gives up and
> won't sync.
> 
> Time running too fast can have a number of causes.
> 
> Could you open a bugme bug on this and tag me as the owner?
> http://bugzilla.kernel.org
> 
> Also attach dmesg output and we'll see if that doesn't provide more
> clues.

Ok, I will make open a bug in a moment.

>>>Would you mind confirming 2.6.12 does not have the issue on the same
>>>hardware?
>>
>>The kernel 2.6.12 run on a different hardware and is not configured to 
>>work on the hardware that have the problem with 2.6.14, so I can't 
>>confime exactly your question yet. If you don't have any better idea, I 
>>can try several kernel version to find when the problem start. But I 
>>will make that after I sleep because I you look at the time field into 
>>the test result this is very late now for me...
> 
> When you get a chance starting with a binary search of kernel versions
> would help narrow down the issue (start w/ 2.6.8 vanilla to make sure
> something in the distro tree isn't avoiding this issue). 

A have tested 7 differents vanilla kernel on the same suspect hardware:

                2.6.8  : ntpd working : drift from    -77ppm to   -144ppm
                2.6.9  : ntpd working : drift from    -99ppm to   -231ppm
                2.6.10 : ntpd failed  : drift from -37825ppm to -29912ppm
                2.6.12 : ntpd failed  : drift from -43429ppm to -45251ppm
CONFIG_HZ=100  2.6.14 : ntpd failed  : drift from  -7598ppm to  -4410ppm
CONFIG_HZ=250  2.6.14 : ntpd failed  : drift from -13519ppm to -12538ppm
CONFIG_HZ=1000 2.6.14 : ntpd failed  : drift from -14497ppm to -19543ppm

So it seems that the problem start from the kernel 2.6.10. While testing 
I feel that the 2.6.14 kernel behave a little different than the others 
kernels. The drift don't increase alway in the same direction as for the 
others kernels, but oscillate around a central (too high) value. I also 
tested differents values of CONFIG_HZ with the 2.6.14 like suggested by 
Roman Zippel, but this don't make the ntpd working. Interresting, with 
CONFIG_HZ=100 the drift is halfed and ntpd reset his stats after each 5 
pools! Something I didn't notice with any others kernels.

> 
>>Thanks for you support, I hope we will quicky find to solution.
> 
> I really appreciate your immediate feedback and testing! I'm sure we can
> resolve this soon, esp since you do have a working configuration to
> compare against.

I have 2 others machines with kernel >=2.6.10: one with kernel 2.6.12 
and one with kernel 2.6.13 and theres don't have any problem with ntpd. 
So this seems to be specific to the hardware. The two machines without 
problem are based on VIA chipset, one with a K7 and one with a K8. The 
machine with the ntp problem is based on a nForce2 with a K7. I see an 
other post saying that there exists the same problem with a other 
nForce2 based board.

Hope this help,
-- 
Jean-Christian de Rivaz
