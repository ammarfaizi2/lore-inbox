Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWA2JTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWA2JTo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 04:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWA2JTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 04:19:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37088 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750766AbWA2JTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 04:19:43 -0500
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 5/5] file: Modify struct fown_struct to contain a tref
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3na3ma.fsf_-_@ebiederm.dsl.xmission.com>
	<43DC804B.4060900@FreeBSD.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 02:18:28 -0700
In-Reply-To: <43DC804B.4060900@FreeBSD.org> (Suleiman Souhlal's message of
 "Sun, 29 Jan 2006 00:43:55 -0800")
Message-ID: <m1u0bn8k9n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suleiman Souhlal <ssouhlal@FreeBSD.org> writes:

> Eric W. Biederman wrote:
>
>> @@ -317,7 +326,9 @@ static long do_fcntl(int fd, unsigned in
>>  		 * current syscall conventions, the only way
>>  		 * to fix this will be in libc.
>>  		 */
>> -		err = filp->f_owner.pid;
>> +		err = 0;
>> +		if (filp->f_owner.tref->task)
>> +			err = filp->f_owner.pid;
>
> Probably not very important, but why don't you use
> filp->f_owner.tref->task->pid? This way you could completely get rid of the pid
> field in fown_struct.

Two reasons.
One because task->pid is not the proper value for a thread group.
And because task might be NULL.

Basically using filp->f_owner.tref->task->pid as my source is a much
more complicated expression.

Eric
