Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWBAQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWBAQpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWBAQpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:45:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23969 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161108AbWBAQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:45:51 -0500
To: Greg <gkurz@fr.ibm.com>
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
	<m13bj34spw.fsf@ebiederm.dsl.xmission.com>
	<43E0E1D3.5000803@fr.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Feb 2006 09:44:44 -0700
In-Reply-To: <43E0E1D3.5000803@fr.ibm.com> (gkurz@fr.ibm.com's message of
 "Wed, 01 Feb 2006 17:29:07 +0100")
Message-ID: <m1u0bjvxj7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg <gkurz@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>> 
>> On this front I have been planning on using sys_clone as it allows
>> pieces of the virtualization to be incrementally built, it already
>> supports the FS namespace, and it supports flexibly specifying what
>> you want to contain.
>> 
>
> What would you do to handle the following case:
>
> pid = getpid();
> if (sys_clone(CLONE_CONTAINER) == 0) {
> 	ppid = getppid();
> 	assert(ppid == pid);
> }
>
> Most of the calls involving resource ids will return values that aren't
> *consistent* with ids already stored in userland... could possibly break some
> piece of code. Perhaps a sys_exec() should also be enforced to reset the process
> memory.

Well that assertion will fail.
At that point getppid() will return 0, and getpid() will return 1.

Processes getting confused is their own problem.

Now there will be a pid that the parent sees that will not be 0.
And that is what the parent will see in the context of wait.

In my code I introduced a wid (wait id) for that purpose.

This makes it possible to manage a container using the usual unix
process semantics.  Which is very important.


Eric
