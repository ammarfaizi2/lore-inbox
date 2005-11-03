Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVKCAoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVKCAoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKCAoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:44:37 -0500
Received: from www.eclis.ch ([144.85.15.72]:59339 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030227AbVKCAoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:44:37 -0500
Message-ID: <43695D94.10901@eclis.ch>
Date: Thu, 03 Nov 2005 01:45:08 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch> <1130976935.27168.512.camel@cog.beaverton.ibm.com>
In-Reply-To: <1130976935.27168.512.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :
> On Thu, 2005-11-03 at 00:37 +0100, Jean-Christian de Rivaz wrote:
> 
>>john stultz a écrit :
>>
>>>On Thu, 2005-11-03 at 00:05 +0100, Jean-Christian de Rivaz wrote:
>>>
>>>
>>>>Since I have installed the new kernel 2.6.14, ntpd is unable to
>>>>synchronize the time:
>>>
>>>
>>>I'm working to see if I can reproduce this. Is this with 2.6.14 vanilla,
>>>or from Linus' git tree post 2.6.14?
>>
>>This is a vanilla 2.6.14 kernel from Linus git tree.
>>The architecture is i386:
>>Linux talla 2.6.14 #1 PREEMPT Tue Nov 1 17:27:04 CET 2005 i686 GNU/Linux
> 
> 
> I can't seem to trivially reproduce this.
> 
> 
> Your ntpq associations output looks suspicious, though. 
> ind assID status  conf reach auth condition  last_event cnt
> ===========================================================
>    1 14484  9014   yes   yes  none    reject   reachable  1
> 
> That reject condition seems odd.
> 
> 
> What does running "ntpdate -uq <server>" produce?

First I have rebooted with a new kernel 2.6.14 that have the patch 
pointed out by Dean Gaudet, this don't change the problem.

On the machine with 2.6.14:

talla:~# uname -a
Linux talla 2.6.14-1 #2 PREEMPT Thu Nov 3 00:54:44 CET 2005 i686 GNU/Linux
talla:~# ntpdate -uq 10.0.0.1
server 10.0.0.1, stratum 3, offset -14.893095, delay 0.02644
  3 Nov 01:31:59 ntpdate[8186]: step time server 10.0.0.1 offset 
-14.893095 sec
talla:~# ntpdate -uq 129.132.2.21
server 129.132.2.21, stratum 2, offset -14.907672, delay 0.04263
  3 Nov 01:32:00 ntpdate[8187]: step time server 129.132.2.21 offset 
-14.907672 sec

> 
> Also, could you check 2.6.13, or even better do a binary search of
> mainline releases since 2.6.8 to narrow down where this broke for you?

On the others machines using the same server:

craie:~# uname -a
Linux craie 2.4.27-pre2-7-k7 #1 lun mai 17 00:08:15 CEST 2004 i686 GNU/Linux
craie:~# ntpdate -uq 10.0.0.1
server 10.0.0.1, stratum 3, offset 0.000046, delay 0.02641
  3 Nov 01:31:38 ntpdate[16783]: adjust time server 10.0.0.1 offset 
0.000046 sec
craie:~# ntpdate -uq 129.132.2.21
server 129.132.2.21, stratum 2, offset -0.013689, delay 0.04294
  3 Nov 01:31:39 ntpdate[16786]: adjust time server 129.132.2.21 offset 
-0.013689 sec

citron:~# uname -a
Linux citron 2.6.12-nfs-1 #1 Fri Jun 24 18:23:39 CEST 2005 i686 GNU/Linux
citron:~# ntpdate -uq 10.0.0.1
server 10.0.0.1, stratum 3, offset 0.003676, delay 0.02647
  3 Nov 01:32:06 ntpdate[13476]: adjust time server 10.0.0.1 offset 
0.003676 sec
citron:~# ntpdate -uq 129.132.2.21
server 129.132.2.21, stratum 2, offset -0.010485, delay 0.04341
  3 Nov 01:32:11 ntpdate[13477]: adjust time server 129.132.2.21 offset 
-0.010485 sec

So this could to be something after the 2.6.12. All machines run the 
same version of ntpd and use the same configuration file.

Thanks,
-- 
Jean-Christian de Rivaz
