Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbTEKKvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTEKKvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:51:48 -0400
Received: from pat.uio.no ([129.240.130.16]:17113 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261388AbTEKKvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:51:40 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: arjanv@redhat.com
Cc: Ahmed Masud <masud@googgun.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
References: <Pine.LNX.4.33.0305100957100.23680-100000@marauder.googgun.com>
	<1052585430.1367.6.camel@laptop.fenrus.com>
MIME-Version: 1.0
Message-Id: <E19EoaN-0000OJ-00@aqualene.uio.no>
Date: Sun, 11 May 2003 13:01:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Arjan van de Ven]
> On Sat, 2003-05-10 at 16:38, Ahmed Masud wrote:
>> Case in point, I wrote a security module for Linux that overrides _all_
>> 237 systemcalls to audit and control the use of the system calls on a per
>> uid basis.  (i.e. if the user was actually allowed to make the system call
>> or not) and return -EPERM or jump to system call proper.

> I'm pretty sure that auditing by your module can easily be avoided.

> examle: pseudocode for the unlink syscall

> long your_wrapped_syscall(char *userfilename)
> {
>     char kernelpointer[something];
>     copy_from_user(kernelpointer, usefilename, ...);
>     audit_log(kernelpointer);
>     return original_syscall(userfilename);
> }

> now.... the original syscall does ANOTHER copy_from_user().
> Eg I can easily fool your logging by having a second thread change the
> filename between the time your code copies it and the time the original
> syscall copies it again. The chances of getting the timing right are 50%
> at least (been there done that ;)

> The only solution for this is to check/audit/log things after the ONE
> copy. Eg not by overriding the syscall but inside the syscall.

just replace 
     return original_syscall(userfilename);
with
     return original_syscall(kernelpointer);

-- 
 - Terje
tm@basefarm.no
