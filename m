Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVDEUet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVDEUet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVDEUdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:33:15 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:18950 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S261925AbVDEUND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:13:03 -0400
In-Reply-To: <200504052053.20078.blaisorblade@yahoo.it>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7aa6252d5a294282396836b1a27783e8@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: stable@kernel.org, Greg KH <gregkh@suse.de>, jdike@karaya.com,
       linux-kernel@vger.kernel.org
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Tue, 5 Apr 2005 22:18:26 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 5, 2005, at 8:53 PM, Blaisorblade wrote:

> On Tuesday 05 April 2005 20:47, Renate Meijer wrote:
>> On Apr 5, 2005, at 6:48 PM, Greg KH wrote:
>>> -stable review patch.  If anyone has any objections, please let us
>>> know.
>>>
>>> ------------------
>>>
>>> Uses __va_copy instead of va_copy since some old versions of gcc
>>> (2.95.4
>>> for instance) don't accept va_copy.
>>
>> Are there many kernels still being built with 2.95.4? It's quite
>> antiquated, as far as
>> i'm aware.
>>
>> The use of '__' violates compiler namespace.
> Why? The symbol is defined by the compiler itself.

If a function is prefixed with a double underscore, this implies the 
function is internal to
the compiler, and may change at any time, since it's not governed by 
some sort of standard.
Hence that code may start suffering from bitrot and complaining to the 
compiler guys won't help.

They'll just tell you to RTFM.

>> If 2.95.4 were not easily
>> replaced by
>> a much better version (3.3.x? 3.4.x) I would see a reason to disregard
>> this, but a fix
>> merely to satisfy an obsolete compiler?
>
> Let's not flame, Linus Torvalds said "we support GCC 2.95.3, because 
> the newer
> versions are worse compilers in most cases".

You make it sound as if you were reciting Ye Holy Scribings. When did 
Linus Thorvalds say this? In the Redhat-2.96 debacle? Before or after 
3.3? I have searched for that quote, but could not find it, and having
suffered under 3.1.1, I can well understand his wearyness for the 
earlier versions.

See

http://kerneltrap.org/node/4126, halfway down.

For the cold, hard facts...

http://www.suse.de/~aj/SPEC/

<snip>

> Consider me as having no opinion on this except not wanting to break 
> on purpose Debian users.

If Debian users are stuck with a pretty outdated compiler, i'd 
seriously suggest migrating to some
other distro which allows more freedom. If linux itself is holding them 
back, there's a need for some serious patching. If there are serious 
issues in the gcc compiler, which hinder migration to a more up-to-date 
version our efforts should be directed at solving them in that project, 
not this.

> If you want, submit a patch removing Gcc 2.95.3 from supported 
> versions, and get ready to fight
> for it (and probably loose).

I don't fight over things like that, i'm not interested in politics. I 
merely point out the problem. And yes.
I do think support for obsolete compiler should be dumped in favor of a 
more modern version. Especially if that compiler requires invasions of 
compiler-namespace. The patch, as presented, is not guaranteed to be 
portable over versions, and may thus introduce another problem with 
future versions of GCC.

> Also, that GCC has discovered some syscall table errors in UML - I 
> sent a
> separate patch, which was a bit big sadly (in the reduced version, 
> about 70
> lines + description).

I am not quite sure what is intended here... Please explain.

timeo hominem unius libri

Thomas van Aquino

