Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRDEUjp>; Thu, 5 Apr 2001 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132541AbRDEUjZ>; Thu, 5 Apr 2001 16:39:25 -0400
Received: from mail.digitalme.com ([193.97.97.75]:62233 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S132479AbRDEUjU>;
	Thu, 5 Apr 2001 16:39:20 -0400
Message-ID: <3ACCD746.3010000@bigfoot.com>
Date: Thu, 05 Apr 2001 16:36:22 -0400
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux Kernel <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: 2.4.3 (and possibly 2.4.2) don't enter S5 (ACPI) on shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE810@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

>> From: Trever L. Adams [mailto:trever_Adams@bigfoot.com]
>> 2.4.3 no longer shuts down automatically with S5.
>> 
>> [2.] Full description of the problem/report:
>> 
>> 2.4.3 no longer shuts down automatically with S5.  I have an Athlon 
>> based system using the FIC-SD11 motherboard.  In 2.4.1 and possibly 
>> 2.4.2 the system used to shut down just fine.
> 
> 
> This is the most likely culprit. Trevor please let me know if this does it:
> 
> --- linux/drivers/acpi/hardware/hwsleep.c.orig	Fri Feb  9 11:45:58 2001
> +++ linux/drivers/acpi/hardware/hwsleep.c	Thu Apr  5 12:11:54 2001
> @@ -179,8 +179,6 @@
>  
>  	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_a_CONTROL, PM1_acontrol);
>  	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_b_CONTROL, PM1_bcontrol);
> -	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_CONTROL,
> -		(1 << acpi_hw_get_bit_shift (SLP_EN_MASK)));
>  
>  	enable();


Thank you Andrew.  This fixed it perfectly.  I wish I understood what

the different PM controls were, but it sure did the trick.

I do have a question that you might be able to answer.

Since I left the 2.2.x series of kernels, my harddrives never spin down 
now.  I do not know what else doesn't sleep.  This is the case with APM 
(on a box that doesn't crash from it) as well as ACPI.  What could be 
the cause?  I would like the system to go to sleep as much as possible 
when it is idle.

TrevEr Adams

