Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUIXUWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUIXUWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUIXUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:22:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269113AbUIXUWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:22:00 -0400
Message-ID: <415481D3.4060104@redhat.com>
Date: Fri, 24 Sep 2004 16:21:39 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@redhat.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <41547C16.4070301@pobox.com> <4154805D.8030904@redhat.com>
In-Reply-To: <4154805D.8030904@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> Jeff Garzik wrote:
> 
>>
>> How feasible is it to create an mlock(1) utility, that would allow 
>> priveleged users to execute a daemon such that none of the memory the 
>> daemon allocates will ever be swapped out?
>>
>> ntp daemon does mlock(2) internally, for example, but IMHO this is 
>> really a policy decision that could be moved out of the app.
>>
>> Unfortunately I am VM-ignorant as always ;-)
>>
>>     Jeff
>>
> 
> I think it would be pretty easy to do.  Since mlock(2) operates on the 
> calling processes vma tree you'd need an interface to the kernel that 
> let you specify a child process and an address range to lock.  Then in 
> the kernel you'd need to translate the pid into task struct and 
> replicate the functionality of sys_mlock without the assumption that 
> current points to the task that you're modifying.  Sounds like something 
> you could do pretty easy with a proc file in fact.
> 
> 
> Neil
> 
>>
>>
>> -

Clarification: didn't mean to say child process there.  Any process 
would be modifiable with this interface I think.
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
