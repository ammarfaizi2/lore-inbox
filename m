Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWJFTGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWJFTGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWJFTGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:06:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43714 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932203AbWJFTGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:06:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: caszonyi@rdslink.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<Pine.LNX.4.62.0610062041440.1966@grinch.ro>
	<Pine.LNX.4.64.0610061110050.3952@g5.osdl.org>
Date: Fri, 06 Oct 2006 13:05:14 -0600
In-Reply-To: <Pine.LNX.4.64.0610061110050.3952@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 6 Oct 2006 11:12:10 -0700 (PDT)")
Message-ID: <m1irixz2mt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 6 Oct 2006, caszonyi@rdslink.ro wrote:
>> 
>> In dmesg:
>> warning: process `sleep' used the removed sysctl system call
>> warning: process `alsactl' used the removed sysctl system call
>> warning: process `nscd' used the removed sysctl system call
>> warning: process `tail' used the removed sysctl system call
>
> You need to compile with CONFIG_SYSCLT set to 'y' rather than 'n'.
>
> Alternatively, you can probably fix it by just upgrading user-land, but 
> the SYSCLT thing _does_ still exist, it's just deprecated and defaults to 
> off by default..
>
> (Or you can possibly even choose to just ignore the warnings, they 
> probably won't affect any actual behaviour)

I'm tempted to submit a patch that just kills the warning.

The only known user is lipthreads from glibc performing.
if ! uname -v | grep "SMP" ; then
	....
fi

That code if it gets -ENOSYS reads /proc/sys/kernel/version,
and it has worked this way since the day it was written.

I have been looking for other uses of sys_sysctl but I haven't
found any.  Why glibc doesn't call uname like any normal
program when it wants to uname information is beyond me.

Eric
