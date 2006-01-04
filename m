Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWADBlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWADBlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWADBlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:41:20 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:20954 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965139AbWADBlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:41:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Pa7lUMLjBx7qYFCQe76KywrCSvXXrbWPigFVjhX7lullT1i5w5/2O/sfnPVZg2nRrGm0D+sM9i2r5Gy82l3YwCRUqDfYldc46ZpzvycWtGfCnNQeWRzaQWvPLH9fMbEWC4gO/EkmQBykn08n56B+MxH+MYIO/WmPIzU2Nd24+CA=
Message-ID: <43BB27AE.3040200@gmail.com>
Date: Wed, 04 Jan 2006 09:41:02 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, gregkh@suse.de,
       akpm@osdl.org
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
References: <43B4F287.6080307@gmail.com>	 <2cd57c900512310113i5467a258s@mail.gmail.com>	 <43B64ECA.8090004@gmail.com> <2cd57c900512310144o4aafd05en@mail.gmail.com>
In-Reply-To: <2cd57c900512310144o4aafd05en@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

>2005/12/31, Yi Yang <yang.y.yi@gmail.com>:
>  
>
>>Coywolf Qi Hunt wrote:
>>    
>>
>>>You didn't set the trailing '\0', I wonder how your printf did work
>>>properly ever. You've just been lucky or something.
>>>
>>>-- Coywolf
>>>
>>>
>>>      
>>>
>>The variable target does it, its value is 0x00000001, so you mustn't
>>worry it.
>>osname only has 4-bytes space, so if you set '\0' to its tail, a byte
>>information will be lost.
>>    
>>
>
>I'm worrying more. We should set '\0'. Let the one byte information
>lost, the caller deserve that. Actually here printf sees "mylo"+'\01'
>if little endian.
>  
>
I want to remind of you, my program is an example to verify this bug, it 
can run on both little-endian and big-endian computer correctly, because 
the variable target  is 0x00000001 or 0x00000000, it sets 0 to the tail 
of osname, only a byte '\01' isn't expected for little-endian, but my 
program really can run correctly.

For compatibility, you don't worry, you can try the application 'sysctl -a'.

This bug is very serious as far as security is concerned, so it is 
necessary, the kernel shouldn't corrupt the user data no matter what the 
reason is, if the user provides more space, Linus's patch has set 0 to 
the tail, but if the user space is not enough, to set 0 to the tail is 
not necessary, because a user mode application should do it by itself, 
but not depends on kernel.

>Linus, besides fixing bug, your commit certainly breaks userland
>compatibility. Please consider.
>--
>Coywolf Qi Hunt
>
>  
>

