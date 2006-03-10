Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWCJNXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWCJNXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWCJNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:23:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63891 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750774AbWCJNX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:23:29 -0500
To: Kirill Korotaev <dev@openvz.org>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com
Subject: Re: sysctls inside containers
References: <43F9E411.1060305@sw.ru>
	<m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	<1141062132.8697.161.camel@localhost.localdomain>
	<m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
	<1141442246.9274.14.camel@localhost.localdomain>
	<4411524B.1000707@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 10 Mar 2006 06:22:34 -0700
In-Reply-To: <4411524B.1000707@openvz.org> (Kirill Korotaev's message of
 "Fri, 10 Mar 2006 13:17:47 +0300")
Message-ID: <m1zmjyjuxx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:

> After checking proposed yours, Eric and vserver solutions, I must say that these
> all are hacks.
> If we want to virtualize sysctl we need to do it in honest way:
> multiple sysctl trees, which can be different in different namespaces.
> For example, one namespace can see /proc/sys/net/route and the other one
> not.

At least a different copy of /proc/sys/net/route :)

> Introducing helpers/handlers etc. doesn't fully solve the problem of
> visibility of different parts of sysctl tree and it's access rights.

I need to look a little deeper but I think if we add two helper
functions: One that returns the address of a value based upon our state,
and another that returns a subdirectory based upon our state I think we
should be ok.

Both of them taking a struct task_struct argument so we can make the decision
what to show based upon the calling process.

> Another example, the same network device can present in 2 namespaces and these
> are dynamically(!) created entries in sysctl.
>
> So we need to address actually 2 issues:
> - ability to limit parts of sysctl tree visibility to namespace
> - ability to limit/change sysctl access rights in namespace
>
> You can check OpenVZ for cloning sysctl tree code. It is not clean, nor elegant,
> but can be cleanuped.

Sounds like a decent idea.

What I have found so far with access rights is that if you dig deep enough
you don't need magic to make it safe.  But this may only be because I have
not hit something that is fundamentally different.


Eric
