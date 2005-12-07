Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbVLGWSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbVLGWSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVLGWSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:18:06 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:41118 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030400AbVLGWSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:18:03 -0500
Message-ID: <43975F8F.6080703@fr.ibm.com>
Date: Wed, 07 Dec 2005 23:17:51 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dave Hansen <haveblue@us.ibm.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>	<m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>	<1133977623.24344.31.camel@localhost> <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>>Who do you report as the source of your signal.  
>>
>>I've never dealt with signal enough from userspace to give you a good
>>answer.  Can you explain the mechanics of how you would go about doing
>>this?
> 
> Look at siginfo_t si_pid....

the siginfo is queued when a process is killed and si_pid is updated using
the pidspace of the killing process. Processes parent of a pidspace are of
a special kind : the init kind.

>>>What pid does waitpid return when the parent of your pidspace exits?

Well, a process doing waitpid on a parent of a pidspace, is not part
of that pidspace so waitpid would return the 'real pid'.

Am i getting your point correctly ?

>>>What pid does waitpid return when both processes are in the same pidspace?

hmm, please elaborate.

There are indeed issues when a process is the parent of different
namespaces. This case that should be avoided.

>>>How does /proc handle multiple pid spaces?
>>
>>I'm working on it :)
>>
>>Right now, there's basically a hack in d_hash() to get new dentries for
>>each pidspace.  It is horrible and causes a 50x decrease in performance
>>on some benchmarks like dbench.
>>
>>I think the long-term solution is to make multiple, independent proc
>>mounts, and give each pidspace a separate filesystem view.  That
>>requires some of the nifty new bind mount functionality and a chroot
>>when a new pidspace is created, but I think it works.
> 
> I think you will ultimately want a new filesystem namespace
> not just a chroot, so you can ``virtualize'' your filesystem namespace
> as well.

"virtualize" the mount points but not necessarily the whole filesystem.

> I wonder if you could hook up with the linux vserver project.  The
> requirements are strongly similar, and making a solution that
> would work for everyone has a better chance of getting in.

We feel the same.

C.
