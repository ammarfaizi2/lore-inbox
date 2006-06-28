Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWF1EVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWF1EVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 00:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWF1EVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 00:21:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59575 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030324AbWF1EVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 00:21:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Savochkin <saw@swsoft.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 22:20:32 -0600
In-Reply-To: <20060627215859.A20679@castle.nmd.msu.ru> (Andrey Savochkin's
	message of "Tue, 27 Jun 2006 21:58:59 +0400")
Message-ID: <m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@swsoft.com> writes:

> Eric,
>
> On Tue, Jun 27, 2006 at 11:20:40AM -0600, Eric W. Biederman wrote:
>> 
>> Thinking about this I am going to suggest a slightly different direction
>> for get a patchset we can merge.
>> 
>> First we concentrate on the fundamentals.
>> - How we mark a device as belonging to a specific network namespace.
>> - How we mark a socket as belonging to a specific network namespace.
>
> I agree with the direction of your thoughts.
> I was trying to do a similar thing, define clear steps in network
> namespace merging.
>
> My first patchset covers devices but not sockets.
> The only difference from what you're suggesting is ipv4 routing.
> For me, it is not less important than devices and sockets.  May be even
> more important, since routing exposes design deficiencies less obvious at
> socket level.

I agree we need to do it.  I mostly want a base that allows us to 
not need to convert the whole network stack at once and still be able
to merge code all the way to the stable kernel.

The routing code is important for understanding design choices.  It
isn't important for merging if that makes sense.   

For everyone looking at routing choices the IPv6 routing table is
interesting because it does not use a hash table, and seems quite
possibly to be an equally fast structure that scales better.

There is something to think about there.

>> As part of the fundamentals we add a patch to the generic socket code
>> that by default will disable it for protocol families that do not indicate
>> support for handling network namespaces, on a non-default network namespace.
>
> Fine
>
> Can you summarize you objections against my way of handling devices, please?
> And what was the typo you referred to in your letter to Kirill Korotaev?

I have no fundamental objects to the content I have seen so far.

Please read the first email Kirill responded too.  I quoted a couple
of sections of code and described the bugs I saw with the patch.

All minor things.  The typo I was referring to was a section where the
original iteration was on an ifp variable and you called it dev
without changing the rest of the code in that section.  

The only big issue was that the patch too big, and should be split
into a patchset for better review.  One patch for the new functions,
and the an additional patch for each driver/subsystem hunk describing
why that chunk needed to be changed.

I'm still curious why many of those chunks can't use existing helper
functions, to be cleaned up.

Eric
