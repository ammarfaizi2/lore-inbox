Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWA2WAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWA2WAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 17:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWA2WAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 17:00:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65511 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751190AbWA2WAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 17:00:02 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<20060129190539.GA26794@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 14:58:51 -0700
In-Reply-To: <20060129190539.GA26794@kroah.com> (Greg KH's message of "Sun,
 29 Jan 2006 11:05:39 -0800")
Message-ID: <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sun, Jan 29, 2006 at 12:22:34AM -0700, Eric W. Biederman wrote:
>> +struct task_ref
>> +{
>> +	atomic_t count;
>
> Please use a struct kref here, instead of your own atomic_t, as that's
> why it is in the kernel :)
>
>> +	enum pid_type type;
>> +	struct task_struct *task;
>> +};
>
> thanks,

I would rather not. Whenever I look at struct kref it seems to be an over
abstraction, and as such I find it confusing to work with.  I know
whenever I look at the sysfs code I have to actively remind myself
that the kref in the structure is not a pointer to a kref.

What does the kref abstraction buy?  How does it simplify things?
We already have equivalent functions in atomic_t on which it is built.

It is a funny piece of code to come up in this thread where the
argument has been don't over abstract.... (with reference to pids).

If I can see where struct kref buys something or helps in some way
I will be willing to consider it.

Eric
