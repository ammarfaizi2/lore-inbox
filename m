Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWBFIlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWBFIlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWBFIlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:41:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8422 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750771AbWBFIlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:41:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>
	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
	<43E3915A.2080000@sw.ru>
	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 01:39:03 -0700
In-Reply-To: <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> (Linus
 Torvalds's message of "Fri, 3 Feb 2006 09:49:56 -0800 (PST)")
Message-ID: <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 3 Feb 2006, Kirill Korotaev wrote:
>> 
>> Do you have any other ideas/comments on this?
>> I will send additional IPC/filesystems virtualization patches a bit later.
>
> I think that a patch like this - particularly just the 1/5 part - makes 
> total sense, because regardless of any other details of virtualization, 
> every single scheme is going to need this.

I strongly disagree with this approach.  I think Al Viro got it
right when he created a separate namespace for filesystems.  

First this presumes an all or nothing interface.  But that is not
what people are doing.  Different people want different subsets
of the functionality.   For the migration work I am doing having
multiple meanings for the same uid isn't interesting.

Secondly by implementing this in one big chunk there is no
migration path when you want to isolate an additional part of the
kernel interface.

So I really think an approach that allows for incremental progress
that allows for different subsets of this functionality to
be used is a better approach.  In clone we already have
a perfectly serviceable interface for that and I have
seen no one refute that.  I'm not sure I have seen anyone
get it though.



My apologies for the late reply I didn't see this thread until
just a couple of minutes ago.  linux-kernel can be hard to
follow when you aren't cc'd.


Patches hopefully sometime in the next 24hours.   So hopefully
conversation can be carried forward in a productive manner.

Eric

