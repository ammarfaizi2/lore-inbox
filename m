Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUA0Uic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbUA0Uic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:38:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64241 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265788AbUA0Ui2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:38:28 -0500
Message-ID: <4016CC1C.8020709@mvista.com>
Date: Tue, 27 Jan 2004 12:37:48 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jim.houston@comcast.net
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>	 <20040127155619.7efec284.ak@suse.de>	 <1075225399.1020.239.camel@new.localdomain>	 <20040127190251.4edb873d.ak@suse.de> <1075232116.1020.326.camel@new.localdomain>
In-Reply-To: <1075232116.1020.326.camel@new.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> On Tue, 2004-01-27 at 13:02, Andi Kleen wrote:
> 
>>On 27 Jan 2004 12:43:20 -0500
>>Jim Houston <jim.houston@comcast.net> wrote:
> 
> 
>>>arch/x86_64/Kconfig
>>>arch/x86_64/Kconfig.kgdb
>>>	We used a different approach to selecting DEBUG_INFO.
>>>	I was not really happy with the way select DEBUG_INFO worked.
>>
>>You reverted it back? 
>>
>>What I did was to change all not really kgdb specific CONFIG_KGDB uses in
>>the main kernel with CONFIG_DEBUG_INFO (mostly CFI support). I don't feel
>>strongly about it, but this way there is no reference to an unknown
>>config symbol in mainline. Also DEBUG_INFO including CFI makes sense I think.

If we are going to use DEBUG_INFO could we change the "-g" it produces to 
"-gdwarft-2", especially since you (and I) are using dwarft2 CFI stuff.

-g
> 
> 
> Hi Andi,
> 
> I'm using CONFIG_DEBUG_INFO, but I used a different mechanism to
> select it when KGDB is selected.  I'm still learning to speak Kconfig.
> 
> My patch:
> 
>    config KGDB
>         bool "Include kgdb kernel debugger"
>         depends on DEBUG_KERNEL
>         select DEBUG_INFO
>         help
>           If you say Y here, the system will be compiled with the debug
> 
> Your patch:
> 
>   config DEBUG_INFO
>         bool "Compile kernel with debug information" if !KGDB
>         default y
> 
> Using "select DEBUG_INFO" selects the option and makes the input box
> on xconfig disappear.  The line describing the option remains, perhaps
> leaving a user wondering why this line doesn't have an input box.
> 
> With your version, the DEBUG_INFO option disappears when KGDB forces
> it on.
> 
> I was looking for a way to get the old behavior where the 
> the effect was controlled by an OR of the two options.
> 
> Jim Houston - Concurrent Computer Corp.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

