Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWHOTB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWHOTB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWHOTB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:01:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27876 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030455AbWHOTB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:01:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 5/7] pid: Implement pid_nr
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193751-git-send-email-ebiederm@xmission.com>
	<1155667063.12700.56.camel@localhost.localdomain>
Date: Tue, 15 Aug 2006 13:00:52 -0600
In-Reply-To: <1155667063.12700.56.camel@localhost.localdomain> (Dave Hansen's
	message of "Tue, 15 Aug 2006 11:37:43 -0700")
Message-ID: <m1psf17riz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
>> +static inline pid_t pid_nr(struct pid *pid)
>> +{
>> +       pid_t nr = 0;
>> +       if (pid)
>> +               nr = pid->nr;
>> +       return nr;
>> +} 
>
> When is it valid to be passing around a NULL 'struct pid *'?

When you don't have one at all.  Look at the fcntl case a few
patches later, or even the spawnpid case.  It simplifies things to
just cope with the fact that sometimes the users just have a NULL
pointers.

Then of course there is the later chaos when we get to pid spaces
where depending on the pid namespace you are in when you call this
on a given struct pid sometimes you will get a pid value and sometimes
you won't.

Eric
