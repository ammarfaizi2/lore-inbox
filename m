Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWA3IpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWA3IpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWA3IpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:45:04 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:39241 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751264AbWA3IpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:45:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sB1OwWURneS1DUFbqw/llw+Tv/uFNYR4skkAeS6r0XGk/vNjfUwz2qGhxwcJnKJ1CzZYM283LkXG0hAfk1zES0IT9osB9lKrnOIiyb2COJf5cA445OcuEAT+eV+tmfQYhduAFhRKms1wABPU1/311tuD5OOESbCyfCLM8mzdMV4=
Message-ID: <43DDD206.6000502@gmail.com>
Date: Mon, 30 Jan 2006 17:44:54 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de> <43DDBA71.6040402@gmail.com> <200601300936.43977.ioe-lkml@rameria.de>
In-Reply-To: <200601300936.43977.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Monday 30 January 2006 08:04, Tejun Heo wrote:
>> I object.  Using array is intentional.  Slave aware controllers (PATA / 
>> ata_piix) will use [0..1], most SATA controllers will use only [0], and 
>> PM aware ones will use [0..15].  The intention was requiring low level 
>> drivers of only what they know and normalize them in the core layer.
>>
>> eg. Current std SATA reset routines consider the argument as *class (a 
>> single class value) and it's intentional.  As long as a lldd is aware of 
>> only one device per port, it's allowed/recommeded to consider the passed 
>> classes argument as a pointer to single class value.  The rest is upto 
>> the core libata layer.
>  
> But what you pass along is basically an unbounded array, which is
> a bug waiting to happen.


Hello, again.

I'm a little bit lost here.

So, are you saying....

struct ata_classes {
	unsigned int classes[2];
|;

is safer than

unsigned int *class;

?

> 
> So please let the core layer pass a bounded array here or provide
> a function from core layer to set that and check the index.
> 

Can you show me what you have in mind as code?

-- 
tejun
