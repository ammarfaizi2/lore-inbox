Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWBIBiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWBIBiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWBIBiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:38:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30115 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422766AbWBIBiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:38:20 -0500
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru>
	<m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
	<20060208235348.GC26035@ms2.inr.ac.ru>
	<m11wyd5pv8.fsf@ebiederm.dsl.xmission.com>
	<20060209011126.GB5417@ms2.inr.ac.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 18:36:33 -0700
In-Reply-To: <20060209011126.GB5417@ms2.inr.ac.ru> (Alexey Kuznetsov's
 message of "Thu, 9 Feb 2006 04:11:26 +0300")
Message-ID: <m1slqt48ke.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:

> Hello!
>
>> In capability.c it does for_each_thread or something like that.  It is
>> very similar to cap_set_pg.  But in a virtual context all != all :)
>
> Do you mean that VPID patch does not include this? Absolutely.
> VPIDs are not to limit access, the patch virtualizes pids, rather
> than deals with access policy.
>
> Take the whole openvz. Make patch -R < vpid_patch. The result is perfectly
> working openvz. Only pids are not virtual, which does not matter. Capisco?

Not quite.

sys_kill knows about three kinds of things referred to by pid.
- individual processes (positive pid)
- process groups (pid < -1 or pid == 0)
- The group of all processes.

When you have multiple instances of the same pid on the box
The group of all processes becomes the group of all processes I
can see.  At least that was my impression.

>> I think for people doing migration a private pid space in some form is
>> necessary, 
>
> Not "private", but "virtual". VPIDs are made only for migration, not for fun.
>
> And word "private" is critical, f.e. for us preserving some form of pid
> space is critical. It is very sad, but we cannot do anything with this,
> customers will not allow to change status quo.

Ok. I'm not quite certain what the difference is.  In OpenVZ it appears
to be something significant.  In most conversations it is not.

>> My problem with the vpid case and it's translate at the kernel
>> boundary is that boundary is huge
>
> Believe me, it is surprizingly small.

Well the number of places you need to translate may be small.
But the number of lines of code is certainly large.
Every driver, every ioctl, every other function that could
be abused ioctl.

And if the values are ever stored instead of used immediately
you can get a context mismatch.

Eric

