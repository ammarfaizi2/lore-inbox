Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWHQMBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWHQMBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHQMBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:01:06 -0400
Received: from tresys.irides.com ([216.250.243.126]:17690 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S1751218AbWHQMBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:01:04 -0400
Message-ID: <44E45A70.8090801@gentoo.org>
Date: Thu, 17 Aug 2006 08:00:48 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
References: <20060730011338.GA31695@sergelap.austin.ibm.com>	 <20060814220651.GA7726@sergelap.austin.ibm.com>	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>	 <20060815020647.GB16220@sergelap.austin.ibm.com>	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>	 <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com>	 <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>	 <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0633-2, 08/16/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 17 Aug 2006 12:01:03.0594 (UTC) FILETIME=[D034CCA0:01C6C1F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Tue, 2006-08-15 at 21:42 -0500, Serge E. Hallyn wrote:
>   
> <snip>
>> Very good point.  Preventing communication channels i.e. through signals
>> isn't a concern, but user hallyn ptracing himself running /bin/passwd
>> certainly is.
>>     
>
> Actually, ptrace already performs a capability comparison (cap_ptrace).
> Wrt signals, it wasn't the communication channel that concerned me but
> the ability to interfere with the operation of a process running in the
> same uid but different capabilities, like stopping it at a critical
> point.  Likewise with many other task hooks - you wouldn't want to be
> able to depress the priority of a process running with greater
> capabilities.
>
>   
On this point, what about environment tampering of processes with caps? 
LD_PRELOAD=my_bad_lib.so /usr/bin/passwd. glibc atsecure logic would 
have to be updated to do a capability comparison.

> One other point to consider is Solaris seems to have diverged from their
> own past approaches for privileges/capabilities,
> http://blogs.sun.com/casper/20040722
> http://www.opensolaris.org/os/community/security/library/howto/privbracket/
>
> Doesn't sound like they are even using file capabilities at all.
>
> Also, think about the real benefits of capabilities, at least as defined
> in Linux.  The coarse granularity and the lack of any per-object support
> is a fairly significant deficiency there that is much better handled via
> TE.  At least some of the Linux capabilities lend themselves to easy
> privilege escalation to gaining other capabilities or effectively
> bypassing them
