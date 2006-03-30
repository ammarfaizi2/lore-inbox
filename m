Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWC3BEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWC3BEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWC3BEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:04:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40621 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751330AbWC3BEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:04:48 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 29 Mar 2006 18:02:41 -0700
In-Reply-To: <20060329225241.GO15997@sorel.sous-sol.org> (Chris Wright's
 message of "Wed, 29 Mar 2006 14:52:41 -0800")
Message-ID: <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Sam Vilain (sam@vilain.net) wrote:
>> extern struct security_operations *security_ops; in
>> include/linux/security.h is the global I refer to.
>
> OK, I figured that's what you meant.  The top-level ops are similar in
> nature to inode_ops in that there's not a real compelling reason to make
> them per process.  The process context is (usually) available, and more
> importantly, the object whose access is being mediated is readily
> available with its security label.
>
>> There is likely to be some contention there between the security folk
>> who probably won't like the idea that your security module can be
>> different for different processes, and the people who want to provide
>> access to security modules on the systems they want to host or consolidate.
>
> I think the current setup would work fine.  It's less likely that we'd
> want a separate security module for each container than simply policy
> that is container aware.

I think what we really want are stacked security modules.

I have not yet fully digested all of the requirements for multiple servers
on the same machine but increasingly the security aspects look
like a job for a security module.

Enforcing policies like container A cannot send signals to processes
in container B or something like that.

Then inside of each container we could have the code that implements
a containers internal security policy.

At least one implementation Linux Jails by Serge E. Hallyn was done completely
with security modules, and the code was pretty minimal.


Eric
