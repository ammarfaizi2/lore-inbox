Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWAWT2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWAWT2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWAWT2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:28:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:908 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964904AbWAWT2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:28:49 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 23 Jan 2006 12:28:14 -0700
In-Reply-To: <43D52592.8080709@watson.ibm.com> (Hubertus Franke's message of
 "Mon, 23 Jan 2006 13:50:58 -0500")
Message-ID: <m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> Eric W. Biederman wrote:
>> Hubertus Franke <frankeh@watson.ibm.com> writes:
>> Any place the kernel saves a pid and then proceeds to signal it later.
>> At that later point in time it is possibly you will be in the wrong
>> context.
>>
>
> Yes, that's possible.. In the current patch that is not a problem, because
> the internal pid (aka kpid) == <vpid,containerid>  mangeled together.
> So in those cases, the kernel would have to keep <pid, container_id>

Agreed, and for the internal implementation I think having them mangled
together make sense, so long as we never export that form to userspace.

>> This probably justifies having a kpid_t that has both the process
>> space id and the pid in it.  For when the kernel is storing pids to
>> use as weak references, for signal purposes etc.
>>
>
> An that's what the current patch does. Only thing is we did not rename
> everything to kpid_t!

Yep. But because of that you couldn't detect mixing of pid and kpid.

>> At least tty_io.c and fcntl.c have examples where you the caller
>> may not have the proper context.
>
> Can you point those out directly .. thanks..

Short version.  tty's send signals on hangup and f_setown can trigger signals
being sent.

Eric



