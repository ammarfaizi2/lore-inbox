Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWDMGpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWDMGpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWDMGpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:45:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:52393 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964794AbWDMGpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:45:17 -0400
Message-ID: <443DF523.3060906@openvz.org>
Date: Thu, 13 Apr 2006 10:52:19 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Sam Vilain <sam@vilain.net>, devel@openvz.org,
       Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <4428BB5C.3060803@tmr.com> <4428DB76.9040102@openvz.org> <1143583179.6325.10.camel@localhost.localdomain> <4429B789.4030209@sacred.ru> <1143588501.6325.75.camel@localhost.localdomain> <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru> <1143668273.9969.19.camel@localhost.localdomain> <443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at>
In-Reply-To: <20060413010506.GA16864@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

Thanks a lot for the details, I will give it a try once again. Looks 
like fairness in this scenario simply requires sched_hard settings.

Herbert... I don't know why you've decided that my goal is to prove that 
your scheduler is bad or not precise. My goal is simply to investigate 
different approaches and make some measurements. I suppose you can 
benefit from such a volunteer, don't you think so? Anyway, thanks again 
and don't be cycled on the idea that OpenVZ are so cruel bad guys :)

Thanks,
Kirill

> well, your mistake seems to be that you probably haven't
> tested this yet, because with the following (simple)
> setups I seem to get what you consider impossible 
> (of course, not as precise as your scheduler does it)
> 
> 
> vcontext --create --xid 100 ./cpuhog -n 1 100 &
> vcontext --create --xid 200 ./cpuhog -n 1 200 &
> vcontext --create --xid 300 ./cpuhog -n 1 300 &
> 
> vsched --xid 100 --fill-rate 1 --interval 6
> vsched --xid 200 --fill-rate 2 --interval 6
> vsched --xid 300 --fill-rate 3 --interval 6
> 
> vattribute --xid 100 --flag sched_hard
> vattribute --xid 200 --flag sched_hard
> vattribute --xid 300 --flag sched_hard
> 
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
>    39 root      25   0  1304  248  200 R   74  0.1   0:46.16 ./cpuhog -n 1 300  
>    38 root      25   0  1308  252  200 H   53  0.1   0:34.06 ./cpuhog -n 1 200  
>    37 root      25   0  1308  252  200 H   28  0.1   0:19.53 ./cpuhog -n 1 100  
>    46 root       0   0  1804  912  736 R    1  0.4   0:02.14 top -cid 20        
> 
> and here the other way round:
> 
> vsched --xid 100 --fill-rate 3 --interval 6
> vsched --xid 200 --fill-rate 2 --interval 6
> vsched --xid 300 --fill-rate 1 --interval 6
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
>    36 root      25   0  1304  248  200 R   75  0.1   0:58.41 ./cpuhog -n 1 100  
>    37 root      25   0  1308  252  200 H   54  0.1   0:42.77 ./cpuhog -n 1 200  
>    38 root      25   0  1308  252  200 R   29  0.1   0:25.30 ./cpuhog -n 1 300  
>    45 root       0   0  1804  912  736 R    1  0.4   0:02.26 top -cid 20        
> 
> 
> note that this was done on a virtual dual cpu
> machine (QEMU 8.0) with 2.6.16-vs2.1.1-rc16 and
> that there were roughly 25% idle time, which I'm
> unable to explain atm ...
> 
> feel free to jump on that fact, but I consider
> it unimportant for now ...
> 
> best,
> Herbert
> 
> 
>>Thanks,
>>Kirill
> 
> 


