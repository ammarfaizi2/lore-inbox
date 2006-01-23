Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWAWWPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWAWWPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWAWWPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:15:30 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48519 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964958AbWAWWPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:15:30 -0500
Message-ID: <43D5557F.9060006@watson.ibm.com>
Date: Mon, 23 Jan 2006 17:15:27 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>	<43D52592.8080709@watson.ibm.com>	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>	<1138050684.24808.29.camel@localhost.localdomain> <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> 
>>On Llu, 2006-01-23 at 12:28 -0700, Eric W. Biederman wrote:
>>
>>>>Yes, that's possible.. In the current patch that is not a problem, because
>>>>the internal pid (aka kpid) == <vpid,containerid>  mangeled together.
>>>>So in those cases, the kernel would have to keep <pid, container_id>
>>>
>>>Agreed, and for the internal implementation I think having them mangled
>>>together make sense, so long as we never export that form to userspace.
>>
>>You have to refcount the container ids anyway or you may have stale
>>container references and end up reusing them.
> 
> 
> The short observation is currently we use at most 22bits of the pid
> space, and we don't need a huge number of containers so combining them
> into one integer makes sense for an efficient implementation, and it
> is cheaper than comparing pointers.
> Additional identifiers are really not necessary to user space and providing
> them is one more thing that needs to be virtualized.  We can already
> talk about them indirectly by referring to processes that use them.
> 
> And there will be at least one processes id assigned to the pid space
> from the outside pid space unless we choose to break waitpid, and friends.
> 
> I just don't want a neat implementation trick to cause us maintenance grief.
> 
> Eric
> 

In that case, I think we do require the current vpid_to_pid(translations)
in order to transfer the external user pid ( relative to the namespace )
into one that combines namespace (aka container_id) with the external pid.
Exactly how it is done today.
What will slightly change is the low level implementations of the

inline pid_t pid_to_vpid_ctx(pid_t pid, const struct task_struct *ctx);
pid_t __pid_to_vpid_ctx_excp(pid_t pid, int pidspace_id,const struct task_struct *ctx);

and reverse.
The VPID_2_PID and PID_2_VPID still remain at same locations.

Did I get your comments correctly, Eric ?..

Thanks as usual
-- Hubertus



