Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWC3B4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWC3B4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWC3B4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:56:44 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:19926 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751427AbWC3B4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:56:43 -0500
Date: Wed, 29 Mar 2006 17:41:01 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Chris Wright <chrisw@sous-sol.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
In-Reply-To: <20060330013618.GS15997@sorel.sous-sol.org>
Message-ID: <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
References: <20060328085206.GA14089@MAIL.13thfloor.at>  <4428FB29.8020402@yahoo.com.au>
 <20060328142639.GE14576@MAIL.13thfloor.at>  <44294BE4.2030409@yahoo.com.au>
 <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>  <442A26E9.20608@vilain.net>
 <20060329182027.GB14724@sorel.sous-sol.org>  <442B0BFE.9080709@vilain.net>
 <20060329225241.GO15997@sorel.sous-sol.org>  <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
 <20060330013618.GS15997@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Chris Wright wrote:

> 
> * Eric W. Biederman (ebiederm@xmission.com) wrote:
>> Chris Wright <chrisw@sous-sol.org> writes:
>>
>>> * Sam Vilain (sam@vilain.net) wrote:
>>>> extern struct security_operations *security_ops; in
>>>> include/linux/security.h is the global I refer to.
>>>
>>> OK, I figured that's what you meant.  The top-level ops are similar in
>>> nature to inode_ops in that there's not a real compelling reason to make
>>> them per process.  The process context is (usually) available, and more
>>> importantly, the object whose access is being mediated is readily
>>> available with its security label.
>>>
>>>> There is likely to be some contention there between the security folk
>>>> who probably won't like the idea that your security module can be
>>>> different for different processes, and the people who want to provide
>>>> access to security modules on the systems they want to host or consolidate.
>>>
>>> I think the current setup would work fine.  It's less likely that we'd
>>> want a separate security module for each container than simply policy
>>> that is container aware.
>>
>> I think what we really want are stacked security modules.
>
> I'm not convinced we need a new module for each container.  The module
> is a policy enforcement engine, so give it a container aware policy and
> you shouldn't need another module.

what if the people administering the container are different from the 
people administering the host?

in that case the people working in the container want to be able to 
implement and change their own policy, and the people working on the host 
don't want to have to implement changes to their main policy config (wtih 
all the auditing that would be involved with it) every time a container 
wants to change it's internal policy.

I can definantly see where a container aware policy on the master would be 
useful, but I can also see where the ability to nest seperate policies 
would be useful.

David Lang
