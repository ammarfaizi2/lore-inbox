Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318301AbSGSDDG>; Thu, 18 Jul 2002 23:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318429AbSGSDDG>; Thu, 18 Jul 2002 23:03:06 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2830 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318301AbSGSDDG>;
	Thu, 18 Jul 2002 23:03:06 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207190306.g6J366956014@saturn.cs.uml.edu>
Subject: Re: more thoughts on a new jail() system call
To: daw@mozart.cs.berkeley.edu (David Wagner)
Date: Thu, 18 Jul 2002 23:06:06 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ah7m2r$3cr$1@abraham.cs.berkeley.edu> from "David Wagner" at Jul 19, 2002 12:21:47 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> sys_olduname) - P
>
> I'd argue that this should be restricted, on general
> principles.  (General principle: A jailed process shouldn't
> be able to learn anything about the host it's running on.)

Learning this info is easy enough without a syscall.
You only cause trouble for legit usage.

>> sys_getcwd) C
>> sys_ustat) J - Do we want a jailed process getting this info?
>> sys_statfs) NOT SURE - should a jail process be able to get info on system?
>> sys_fstatfs) same as statfs
>> sys_sysfs) J - info on local system?
>
> It's probably not critical, but I'd argue that these should
> be denied, on general principles, unless there is some
> reason to think it will be very useful.  getcwd() is probably
> the most critical to deny, as it can give away detailed
> information in some cases.
>
> (General principle: If you're in a jail, you shouldn't be
> able to learn any information about where that jail resides
> on the filesystem.)

No, sys_getcwd will return info based on your current root.
After chroot and all, your "/" is the top of your jail.

>> sys_setsid) NOT SURE - no clue what this really does
>
> I think it's probably ok, but I'm not 100% sure, either.

Yes it's OK. It's needed for job control.

>> sys_syslog) NOT SURE (probably jailed away)
>
> sys_syslog touches a global shared resource, hence
> should probably be denied to jailed processes.

It's got to be redirected.

>> sys_vhangup) NOT SURE -  Should be fine, right?
>
> Seems ok to me.

Have fun with devpts.

>> sys_getsid) NOT SURE - whats it for?
>
> You shouldn't be able to call getsid() on some other
> process outside the jail.  Also, calling getsid() on
> yourself might reveal information about your parent,
> like getppid() or getpgid() (minor).

Your parent ought to be 1.
