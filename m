Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTAOUwd>; Wed, 15 Jan 2003 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTAOUwd>; Wed, 15 Jan 2003 15:52:33 -0500
Received: from adsl-173-18.barak.net.il ([62.90.173.18]:58240 "EHLO
	laptop.slamail.org") by vger.kernel.org with ESMTP
	id <S266761AbTAOUwc>; Wed, 15 Jan 2003 15:52:32 -0500
Message-ID: <3E25CAC4.5080406@slamail.org>
Date: Wed, 15 Jan 2003 22:55:32 +0200
From: Yaacov Akiba Slama <ya@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en, fr, he
MIME-Version: 1.0
To: jens.taprogge@rwth-aachen.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [BUG] cardbus/hotplugging still broken in 2.5.56
References: <3E25C0F3.9000208@slamail.org> <20030115203134.GA2215@valsheda.taprogge.wh>
In-Reply-To: <20030115203134.GA2215@valsheda.taprogge.wh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



jens.taprogge@rwth-aachen.de wrote:

>I am not sure if you have seen the patch I posted on l-k. It should fix
>both issues.
>
I don't know enough about pci/cardbus, but in 
arch/i386/pci.c::pcibios_assign_resources, I can see the following :

if (!r->start && r->end)
                pci_assign_resource(dev, idx);

without testing the result and without freeing the ressource for all 
index if it fails on one index. So I don't know if your tests are necessary.
Beside that, testing (!r->start && r->end) seems to be more in sync 
with arch/i386/pci.c than testing r->flags

Thanks,
Yaacov Akiba Slama

>
>Jens
>
>On Wed, Jan 15, 2003 at 10:13:39PM +0200, Yaacov Akiba Slama wrote:
>  
>
>>Jens Taprogge wrote :
>>
>>    
>>
>>>You are not freeing the possibly already allocated resources in case of
>>>a failure of either pci_assign_resource() or pca_enable_device(). In
>>>fact you are not even checking if pci_assign_resource() fails. That
>>>seems wrong to me.
>>>      
>>>
>>There are two separate issues :
>>1) Fix the "ressource collisions" problem (and irq not known).
>>2) Freeing ressources in case of failure of some functions.
>>
>>My patch solves the first issue only in order to make cardbus with rom work.
>>The point 2 is a janitor work.
>>
>>Thanks,
>>Yaacov Akiba Slama
>>    
>>
>
>  
>

