Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWEBIEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWEBIEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWEBIEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:04:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33483 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932499AbWEBIEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:04:51 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	<20060501203907.XF1836@sergelap.austin.ibm.com>
	<p7364ko7w66.fsf@bragg.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 02:03:47 -0600
In-Reply-To: <p7364ko7w66.fsf@bragg.suse.de> (Andi Kleen's message of "02
 May 2006 08:55:29 +0200")
Message-ID: <m1lktk97ks.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>
>> Implement a CLONE_NEWUTS flag, and use it at clone and sys_unshare.
>
> I still think it's a design mistake to add zillions of pointers to task_struct
> for every possible kernel object. Going through a proxy datastructure to 
> merge common cases would be much better.

The design point is not every kernel object.  The target is one
per namespace.  Or more usefully one per logical chunk of the kernel.

The UTS namespace is by far the smallest of these pieces.

The kernel networking stack is probably the largest.

At last count there were about 7 of these, enough so that the few
remaining clone bits would be sufficient.

Do you disagree that to be able to implement this properly we
need to take small steps?

Are there any semantic differences between a clone bit and what you
are proposing?

If it is just an internal implementation detail do you have a clear
suggestion on how to implement this?  Possibly illustrated by the
thread flags that are already in this situation, and more likely
to always share everything.

Except for reducing reference counting I really don't see where
we could have a marked improvement.  I also don't see us closing
the door to that kind of implementation at this point, but instead
taking the simple path.

Eric
