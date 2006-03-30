Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWC3DCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWC3DCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWC3DCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:02:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61102 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751226AbWC3DCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:02:32 -0500
To: Sam Vilain <sam@vilain.net>
Cc: Chris Wright <chrisw@sous-sol.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>
	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>
	<4428FB29.8020402@yahoo.com.au>
	<20060328142639.GE14576@MAIL.13thfloor.at>
	<44294BE4.2030409@yahoo.com.au>
	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<442B4168.6070806@vilain.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 29 Mar 2006 20:01:20 -0700
In-Reply-To: <442B4168.6070806@vilain.net> (Sam Vilain's message of "Thu, 30
 Mar 2006 14:24:40 +1200")
Message-ID: <m1wteceiv3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

>
> We could even end up making security modules to implement standard unix
> security. ie, which processes can send any signal to other processes.
> Why hardcode the (!sender.user_id || (sender.user_id == target.user_id)
> ) rule at all? That rule should be the default rule in a security module
> chain.
>
> I just think that doing it this way is the wrong way around, but I guess
> I'm hardly qualified to speak on this. Aren't security modules supposed
> to be for custom security policy, not standard system semantics ?

It is simply my contention that you into at least a semi custom
configuration when you have multiple users with the same uid.
Especially when that uid == 0.

For guests you have to change the rule about what permissions
a setuid root executable gets or else it will have CAP_SYS_MKNOD,
and CAP_RAW_IO.  (Unless I didn't read that code right).

Plus all of the /proc and sysfs issues.

Now perhaps we can sit down and figure out how to get completely
isolated and only allow a new uid namespace when that is
the case, but that doesn't sound to interesting.

So at least until I can imagine what the semantics of a new uid
namespace are when we don't have perfect isolation that feels
like a job for a security module.

Eric
