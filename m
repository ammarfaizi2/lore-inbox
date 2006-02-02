Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWBBQ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWBBQ3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBBQ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:29:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33967 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932132AbWBBQ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:29:11 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
	<43E22DCA.3070004@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Feb 2006 09:27:05 -0700
In-Reply-To: <43E22DCA.3070004@sw.ru> (Kirill Korotaev's message of "Thu, 02
 Feb 2006 19:05:30 +0300")
Message-ID: <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>> There areas.
>> 1) Checkpointing.
>> 2) Isolation for security purposes.
>>    There may be secrets that the sysadmin should not have access to.
> I hope you understand, that such things do not make anything
> secure. Administrator of the node will always have access to /proc/kcore,
> devices, KERNEL CODE(!) etc. No security from this point of view.

Only if they have CAP_SYS_RAWIO.  I admit it takes a lot more
to get there than just that.  But having a mechanism that has the
potential to be secured and is much simpler to understand
and to setup for minimal privileges than any of the other unix
addons I have seen is very interesting.


>> 3) Nesting of containers, (so they are general purpose and not special hacks).
> Why are you interested in nesting? Any applications for this?
> Until everything is virtualized in nesting way (including TCP/IP stack, routing
> etc.) I see no much use of it.

For everything except the PID namespace I am just interested in having multiple
separate namespaces.  For the PID namespace to keep the traditional unix
model you need a parent process so it is actually nesting.

I am interested because, it is easy, because if it is possible than
the range of applications you can apply a containers to is much
larger.  At the far end of that spectrum is migrating a server running
on real hardware and bringing it up as a guest on a newer much more
powerful machine.  With the appearance that it had only been
unreachable for a few seconds.

>> The vserver way of solving some of these problems is to provide a way
>> to enter the guest.  I would rather have some explicit operation that puts
>> you into the guest context so there is a single point where we can tackle
>> the nested security issues, than to have hundreds of places we have to
>> look at individually.
> Huh, it sounds too easy. Just imagine that VPS owner has deleted ps, top, kill,
> bash and other tools. You won't be able to enter. 

Entering is different from execing a process on the inside.
Implementation wise it is changing the context pointer on your task.

> Another example when VPS owner
> is near its resource limits - you won't be able to do anything after VPS
> entering.

For debugging this is a good reason for being inside.  What if the
problem is that you are out of resources?  

I have no intention of requiring monitoring to work from the inside though.

> Do you need other examples?

No I need to post patches.

Eric
