Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbTCJSPU>; Mon, 10 Mar 2003 13:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbTCJSPT>; Mon, 10 Mar 2003 13:15:19 -0500
Received: from s383.jpl.nasa.gov ([137.78.170.215]:44263 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S261394AbTCJSPS>; Mon, 10 Mar 2003 13:15:18 -0500
Message-ID: <3E6CD8B1.5070300@jpl.nasa.gov>
Date: Mon, 10 Mar 2003 10:25:53 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
References: <200303081948.LAA05459@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>       There is nothing in devfs that prevents you from registering
> devfs devices even if they are not yet bound to specific hardware
> (you do not need a sysfs mapping, for example).  So, you should be
> able to register /dev/tts/0..N at initialization, where N is the
> maximum number of serial devices you want to support.

are you saying there is a way to force devfs to make more entries in 
/dev/tts/ without any hardware being attached to the entries? Then i can 
use setserial? so on boot I'd have 4 entries in /dev/tts ?

Or are you saying I write a script to goto /dev/tts after boot and mknod 
the ports that are missing?

>         Another approach, which I think provides a little more
> information to users, makes for a more readable /dev tree and should
> make some programs a few cycles faster would be to what my version of
> /dev/loop does (not the one currently in Linus's tree, alas): start by
> just creating /dev/tts/0, and then create /dev/tts/n+1 whenever
> /dev/tts/n is assigned and /dev/tts/n+1 has not already been defined.
> For /dev/loop, it was also useful to have the extra devices unregister
> when the highest number device became undefined (if a device in the
> middle were de-defined, it would not disappear until all higher
> numbered devices were also de-defined).
> 
>         Is this the issue, or do I misunderstand?
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

