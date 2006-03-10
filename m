Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752017AbWCJL4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbWCJL4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWCJL4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:56:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4755 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751818AbWCJL4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:56:23 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com
Subject: Re: sysctls inside containers
References: <43F9E411.1060305@sw.ru>
	<m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	<1141062132.8697.161.camel@localhost.localdomain>
	<m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
	<1141442246.9274.14.camel@localhost.localdomain>
	<441152C0.2030501@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 10 Mar 2006 04:55:34 -0700
In-Reply-To: <441152C0.2030501@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Mar 2006 13:19:44 +0300")
Message-ID: <m1d5guldjd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>> On another note, after messing with putting data in the init_task for
>> these things, I'm a little more convinced that we aren't going to want
>> to clutter up the task_struct with all kinds of containerized resources,
>> _plus_ make all of the interfaces to share or unshare each of those.
>> That global 'struct container' is looking a bit more attractive.
> BTW, Dave,
>
> have you noticed that ipc/mqueue.c uses netlink to send messages?
> This essentially means that they are tied as well...

Yes, netlink is something to be considered in the great untangling.

However for a sysvipc namespace ipc/mqueue.c is something that doesn't
need to be handled because that is the implementation of posix message
queues not sysv ipc.

I think I succeeded in untagling the worst of netlink in my proof of
concept implementation, but certainly there is more todo.

Eric
