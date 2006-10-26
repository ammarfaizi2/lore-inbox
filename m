Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161432AbWJZQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWJZQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbWJZQ31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:29:27 -0400
Received: from adsl-ull-235-236.42-151.net24.it ([151.42.236.235]:34856 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1161432AbWJZQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:29:26 -0400
Message-ID: <4540E1BB.1000101@abinetworks.biz>
Date: Thu, 26 Oct 2006 18:26:35 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain>	<20061025205923.828c620d.akpm@osdl.org>	<1161859199.12781.7.camel@localhost.localdomain> <20061026090002.49b04f1b@freekitty>
In-Reply-To: <20061026090002.49b04f1b@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>On Thu, 26 Oct 2006 11:39:59 +0100
>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>  
>
>>Ar Mer, 2006-10-25 am 20:59 -0700, ysgrifennodd Andrew Morton:
>>    
>>
>>>May be so.  But this patch was supposed to print a helpful taint message to
>>>draw our attention to the fact that ndis-wrapper was in use.  The patch was
>>>not intended to cause gpl'ed modules to stop loading 
>>>      
>>>
>>The stopping loading is purely because it now uses _GPLONLY symbols,
>>which is fine until the user wants to load a windows driver except for
>>the old CIPE driver. Some assumptions broke somewhere along the way and
>>the chain of events that was never forseen unfolded.
>>
>>    
>>
>>>Now, if we do want to disallow gpl module loading after ndis-wrapper has
>>>been used then fine
>>>      
>>>
>>The problem is we do the dynamic link at module load time. We would have
>>to unlink the module if it tried to taint itself, which is clearly not
>>what the end user needs to suffer. Having the taint function actually
>>taint and printk + return a "Linked gplonly you can't" error seems the
>>better solution.
>>
>>Really ndiswrapper shouldn't be using _GPLONLY symbols, that would
>>actually make it useful to the binary driver afflicted again and more
>>likely to be legal.
>>
>>    
>>
>
>What are the symbols in question? A simple test would be to take the GPL
>MODULE_LICENSE() off of ndiswrapper and try loading it.
>
>  
>
i've found:

__create_workqueue
queue_work

As i said removing add_taint() in modules.c in the section regarding 
ndiswrapper makes the module load correctly.

regards,

Gianluca
