Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWGKV2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWGKV2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWGKV2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:28:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30699 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751313AbWGKV2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:28:40 -0400
Message-ID: <44B41803.8040900@fr.ibm.com>
Date: Tue, 11 Jul 2006 23:28:35 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain> <m164i3gad1.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164i3gad1.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello eric,

Eric W. Biederman wrote:

>> The following patchset adds the user namespace and a new syscall execns.
>>
>> The user namespace will allow a process to unshare its user_struct table,
>> resetting at the same time its own user_struct and all the associated
>> accounting.
>>
>> The purpose of execns is to make sure that a process unsharing a namespace
>> is free from any reference in the previous namespace. the execve() semantic
>> seems to be the best candidate as it already flushes the previous process
>> context.
>>
>> Thanks for reviewing, sharing, flaming !
> 
> 
> I haven't had a chance to do a thorough review yet but why is
> this needed?
> 
> What can be left shared by switching to a new namespace and then
> execing an executable?
> 
> Is it not possible to ensure what you are trying to ensure with
> a good user space executable?

unshare() is unsafe for some namespaces because namespaces can reference
each other. For the ipc namespace, example are shm ids vs. vma, sem ids vs.
semundos, msq vs. netlink sockets. for the user namespace, open files. So
it seems reasonable to provide a way to unshare namespaces from a clean
process context.

Now, if you try to do that from user space, you will call unshare() then
execve(), which leaves plenty of room and time for nasty things to happen
in between the 2 calls.

C.

