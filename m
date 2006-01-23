Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWAWVbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWAWVbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWAWVbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:31:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32909 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964876AbWAWVbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:31:40 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
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
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<43D52592.8080709@watson.ibm.com>
	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	<1138050684.24808.29.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 23 Jan 2006 14:30:59 -0700
In-Reply-To: <1138050684.24808.29.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 23 Jan 2006 21:11:23 +0000")
Message-ID: <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2006-01-23 at 12:28 -0700, Eric W. Biederman wrote:
>> > Yes, that's possible.. In the current patch that is not a problem, because
>> > the internal pid (aka kpid) == <vpid,containerid>  mangeled together.
>> > So in those cases, the kernel would have to keep <pid, container_id>
>> 
>> Agreed, and for the internal implementation I think having them mangled
>> together make sense, so long as we never export that form to userspace.
>
> You have to refcount the container ids anyway or you may have stale
> container references and end up reusing them.

The short observation is currently we use at most 22bits of the pid
space, and we don't need a huge number of containers so combining them
into one integer makes sense for an efficient implementation, and it
is cheaper than comparing pointers.

Additional identifiers are really not necessary to user space and providing
them is one more thing that needs to be virtualized.  We can already
talk about them indirectly by referring to processes that use them.

And there will be at least one processes id assigned to the pid space
from the outside pid space unless we choose to break waitpid, and friends.

I just don't want a neat implementation trick to cause us maintenance grief.

Eric

