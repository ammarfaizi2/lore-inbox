Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWDSHwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWDSHwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWDSHwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:52:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24195 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750732AbWDSHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:52:42 -0400
To: Sam Vilain <sam@vilain.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       Mishin Dmitry <dim@sw.ru>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	<1142967011.10906.185.camel@localhost.localdomain>
	<44206B58.5000404@vilain.net>
	<1142976756.10906.200.camel@localhost.localdomain>
	<4420885F.5070602@vilain.net>
	<m1bqvzq7de.fsf@ebiederm.dsl.xmission.com> <44241214.7090405@sw.ru>
	<20060327124517.GA16114@sergelap.austin.ibm.com>
	<442A7879.20802@sw.ru>
	<20060329134709.GC15745@sergelap.austin.ibm.com>
	<1143667844.9969.11.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 01:50:33 -0600
In-Reply-To: <1143667844.9969.11.camel@localhost.localdomain> (Sam Vilain's
 message of "Thu, 30 Mar 2006 09:30:44 +1200")
Message-ID: <m1hd4qovg6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> On Wed, 2006-03-29 at 07:47 -0600, Serge E. Hallyn wrote:
>> Alas, the spacing on the picture didn't quite work out :)  I think that
>> by nested containers, you mean overlapping nested containers.  In your
>> example, how are you suggesting that cont1 refers to items in
>> container1.1.2's shmem?  I assume, given your previous posts on openvz,
>> that you want every shmem id in all namespaces "nested" under cont1 to
>> be unique, and for cont1 to refer to any item in container1.1.2's
>> namespace just as it would any of cont1's own shmem?
>> 
>> In that case I am not sure of the actual usefulness.  Someone with
>> different use for containers (you? :)  will need to justify it.  For me,
>> pure isolation works just fine.  Clearly it will be most useful if we
>> want fine-grained administration, from parent namespaces, of the items
>> in a child namespace.
>
> The overlapping is important if you want to pretend that the
> namespace-able resources are allowed to be specified per-process, when
> really they are specified per-family.
>
> In this way, a process family is merely a grouping of processes with
> like namespaces, and depending on which way they overlap you get the
> same behaviour as when processes only have one resource different, and
> therefore remove the overhead on fork().


I missed this subthread originally.

I think it is important that we can have containers in containers
if at all possible.  This means large software collections can count
on them being present.

As for having some items inside a namespace show up in both
a parent and a child namespace I think the case is less clearly
defined.  If possible that is something we want to avoid as it
complicates the implementation.

For pids I will be surprised if we can avoid it.

For most other namespaces I think we can, and it is a good thing
to avoid.


Eric
