Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSGQXdr>; Wed, 17 Jul 2002 19:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSGQXdr>; Wed, 17 Jul 2002 19:33:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27396 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316840AbSGQXdq>; Wed, 17 Jul 2002 19:33:46 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Groups beyond 32
Date: 17 Jul 2002 16:36:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ah4v23$39o$1@cesium.transmeta.com>
References: <1026936556.25347.48.camel@UberGeek>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1026936556.25347.48.camel@UberGeek>
By author:    Austin Gonyou <austin@digitalroadkill.net>
In newsgroup: linux.dev.kernel
> 
> The problem now is more one of maintenance. Most distributions do not
> support groups > 32 AFAIK. So, it's lead me to ask the following
> questions:
> 
> 1. Why, in general, is the limit so low? 
>    For specific application, mainly auditing and such, this would be    
>    advantageous I think.
> 

Mostly to cap the amount of storage to maintain in kernel space, and
for historical reasons.

> 2. What is required to limit the dependence on groups to just GLIBC or
> just the kernel? Is that even possible?

The main problem is programs who do things like:

gid_t mygroups[NGROUPS];

Other than that, it should all be in kernel space.  According to
POSIX, the NGROUPS above really should be sysconf(_SC_NGROUPS_MAX) --
NGROUPS_MAX is defined as a *guaranteed minimum* of
sysconf(_SC_NGROUPS_MAX).  Obviously there needs to be a kernel ->
libc interface for the sysconf.

FWIW, POSIX specifies:

      Application writers should note that {NGROUPS_MAX} is not
      necessarily a constant on all implementations.

(glibc has #define NGROUPS NGROUPS_MAX).

> 3. Is there any true advantage to supporting more than 32 groups, or
> creating "meta-groups" to get around the problem? 

There probably is.

      -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
