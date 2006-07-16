Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWGPAW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWGPAW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWGPAW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:22:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51652 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964815AbWGPAWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:22:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Tilman Schmidt <tilman@imap.cc>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2: process `showconsole' used the removed sysctl system call
References: <44B8FE64.6040700@imap.cc> <20060715154200.e9138a6b.akpm@osdl.org>
	<44B97ADD.5000302@gmail.com>
Date: Sat, 15 Jul 2006 18:21:34 -0600
In-Reply-To: <44B97ADD.5000302@gmail.com> (Michal Piotrowski's message of
	"Sun, 16 Jul 2006 01:31:41 +0200")
Message-ID: <m1odvqpfg1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> writes:

> Hi Andrew,
>
> Andrew Morton wrote:
>> On Sat, 15 Jul 2006 16:40:36 +0200
>> Tilman Schmidt <tilman@imap.cc> wrote:
>> 
>>> After installing a 2.6.18-rc1-mm2 kernel without sysctl syscall support
>>> on a standard SuSE 10.0 system, I find the following in my dmesg:
>>>
>>>> [ 36.955720] warning: process `showconsole' used the removed sysctl system
> call
>>>> [ 39.656410] warning: process `showconsole' used the removed sysctl system
> call
>>>> [ 43.304401] warning: process `showconsole' used the removed sysctl system
> call
>>>> [   45.717220] warning: process `ls' used the removed sysctl system call
>>>> [   45.789845] warning: process `touch' used the removed sysctl system call
>>> which at face value seems to contradict the statement in the help text
>>> for the CONFIG_SYSCTL_SYSCALL option that "Nothing has been using the
>>> binary sysctl interface for some time time now". (sic)
>>>
>>> Meanwhile, the second part of that sentence that "nothing should break"
>>> by disabling it seems to hold true anyway. The system runs fine, and
>>> activating CONFIG_SYSCTL_SYSCALL in the kernel doesn't seem to have any
>>> effect apart from changing the word "removed" to "obsolete" in the above
>>> messages.
>> 
>> Thanks.
>> 
>
> date and salsa also use sysctl.
>
> warning: process `date' used the removed sysctl system call
> warning: process `salsa' used the removed sysctl system call
>
>> Eric, that tends to make the whole idea inviable, doesn't it?
>
> How about _very_ long term to remove sysctl (i.e. January 2010)?

That may be reasonable.  However please confirm that everything
that you have complaints from is using libpthreads.

As there is one use of libpthreads that is using sysctl
in a very non-serious way.

With libptrheads modified to use uname and not sysctl I am not seeing that
message.  I thought I had broken my test setup by forgetting to compile
glibc with --with-tls but I managed but I managed to get things working
again using LD_ASSUME_KERNEL=2.4.1

Still not the best data point but a very interesting one.

Eric
