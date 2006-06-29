Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWF2SDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWF2SDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWF2SDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:03:14 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:41110 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751218AbWF2SDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:03:13 -0400
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FE2@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FE2@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8A7E4B7C-8744-47FF-90FA-9B68C5187CEE@freescale.com>
Cc: "'Vitaly Bordug'" <vbordug@ru.mvista.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, "'Paul Mackerras'" <paulus@samba.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Thu, 29 Jun 2006 13:03:23 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 29, 2006, at 04:28, Li Yang-r58472 wrote:

>>> +config MPC8360E_PB
>>> +	bool "Freescale MPC8360E PB"
>>> +	select DEFAULT_UIMAGE
>>> +	select QUICC_ENGINE
>>> +	help
>>> +	  This option enables support for the MPC836x EMDS Processor  
>>> Board.
>>> +
>>>  endchoice
>>
>> I don't think this is really required option. I guess 836x +  
>> QUICC_ENGINE should
>> be enough (with a proviso that 8360 won't boot without qe.
>
> We select a board and the board implies cpu family and soc  
> feature.  That will be better for users rather than expecting them  
> to know the very detail.


Yeah, this seems fine to me.  In order to eliminate this option, we'd  
need to merge 8360 PB support with the existing board support for  
83xx.  A laudable goal, but not what the 83xx maintainer has  
currently requested.



>>> diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
>> b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
>>> new file mode 100644
>>> index 0000000..b4ddb0a
>>> --- /dev/null
>>> +++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
>>> @@ -0,0 +1,213 @@
>>> +/*
>>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights  
>>> reserved.
>>> + *
>>> + * Author: Li Yang <LeoLi@freescale.com>
>>> + *	   Yin Olivia <Hong-hua.Yin@freescale.com>
>>> + *
>>> + * Description:
>>> + * MPC8360E MDS PB board specific routines.
>>> + *
>>> + * Changelog:
>>> + * Jun 21, 2006	Initial version
>>> + *
>> No changelog entries for new files please... git tracks it good  
>> enough.
>
> This is Freescale protocol.  If it is not welcomed, we will change it.


Yeah, this is one of the problems with the protocol.



>>> +#ifdef CONFIG_QUICC_ENGINE
>>> +	qe_reset();
>>> +
>>> +	for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
>>> +		par_io_of_config(np);
>>> +
>>> +	/* Reset the Ethernet PHY */
>>> +	bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
>>> +	bcsr_regs[9] &= ~0x20;
>>> +	udelay(1000);
>>> +	bcsr_regs[9] |= 0x20;
>>> +	iounmap(bcsr_regs);
>>> +
>> And if we have a design, which do not contain real ethernet UCC  
>> usage? Or UCC
>> geth is disabled somehow explicitly? Stuff like that normally goes  
>> to the
>> callback that is going to be triggered upon Etherbet init.
> I will move it.


Wait...no.  I don't understand Vitaly's objection.  If someone  
creates a board with an 8360 that doesn't use the UCC ethernet, they  
can create a separate board file.  This is the board-specific code,  
and it is perfectly acceptable for it to reset the PHY like this.   
What ethernet callback could be used?

Andy
