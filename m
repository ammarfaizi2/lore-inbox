Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWA2UGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWA2UGF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWA2UGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:06:05 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:31473 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751146AbWA2UGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:06:04 -0500
Message-ID: <43DD2010.7010700@austin.rr.com>
Date: Sun, 29 Jan 2006 14:05:36 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
 library
References: <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de> <1138540148.3002.9.camel@laptopd505.fenrus.org>
In-Reply-To: <1138540148.3002.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>You are taking the wrong approach.
>>
>>The _only_ question that matters is:
>>Why is it technically impossible to do the same in userspace?
>>
>>If it's technically possible to do the same in userspace, it must not be 
>>done in the kernel.
>>    
>>
>
>
>that is not a reasonable statement because...
>1) you can do all of tcp/ip in userspace just fine
>2) you can do the NFS server in userspace
>3) ...
>4) ...
>
>there are reasons why things that can be done in userspace sometimes
>still make sense to do in kernel space, performance could be one of
>those reasons, being unreasonably complex in userspace is another.
>
>Identity management to some degree belongs in the kernel, simply because
>identity *enforcing* is in the kernel. Some things related to security
>need to be in the kernel at least partially just to avoid a LOT of hairy
>issues and never ending series of security holes due to the exceptional
>complexity you get.
>
>
>  
>
Yes - nicely stated.  There are a few cases in which code would be 
simpler in kernel, and there are even more cases where performance or 
security considerations argue for a mostly kernel implementation of a 
key piece of function.  Although I don't know if the case has been 
reproven for web servers (userspace) or nfs server (kernel) recently,  
this case may be easier to work through if we understood the likely use 
scenarios better of this piece of code. I don't know the right answer 
for the particular math library question, but I have not seen the 
typical argument considered about whether a user space implementation of 
this paticular function could deadlock - ie would this code (proposed to 
move to userspace) ever be called in a path in which the:
    1) kernel were out of memory and userspace is needed to resolve the 
write out of dirty memory
    2) hang due to code going up to userspace in path in which key 
kernel semaphores must be held across the call.
