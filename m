Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWBHWao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWBHWao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWBHWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:30:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23457 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965205AbWBHWan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:30:43 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<43E92EDC.8040603@watson.ibm.com>
	<m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com>
	<43EA02D6.30208@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 15:28:12 -0700
In-Reply-To: <43EA02D6.30208@watson.ibm.com> (Hubertus Franke's message of
 "Wed, 08 Feb 2006 09:40:22 -0500")
Message-ID: <m1irrp5vur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> Eric W. Biederman wrote:
>> Hubertus Franke <frankeh@watson.ibm.com> writes:
>>
>>>Eric W. Biederman wrote:
>>>
>>
>>>>3) How do we refer to namespaces and containers when we are not members?
>>>>   - Do we refer to them indirectly by processes or other objects that
>>>>     we can see and are members?
>>>>   - Do we assign some kind of unique id to the containers?
>>>
>>>
>> What I have done which seems easier than creating new names is to refer
>> to the process which has the namespace I want to manipulate.
>
> Is then the idea to only allow the container->init to manipulate
> or is there need to allow other priviliged processes to perform namespace
> manipulation?
> Also after thinking about it.. why is there a need to have an external name
> for a namespace ?

There are several cases.

Passing network devices to a childs namespace, as usually
the loopback interface is not enough.

Monitoring the namespace from outside, so among other things
you aren't required to checkpoint and migrate your monitoring
daemon.

There are several other control and monitoring operations
that I am not quite as familiar.  One of them is the
vserver idea of entering a guest.

To expand on things a little bit.  If we have interfaces
that take strings we can refer to an arbitrary child process
as pid/pid/pid/....  So we should not be limited to what
is at the init of the container.  If that proves desirable.

Permissions checks for most of these operations require some
serious thinking before they are merged.

Eric
