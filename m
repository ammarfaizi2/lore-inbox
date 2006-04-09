Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDITKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDITKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWDITKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:10:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8668 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750830AbWDITKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:10:31 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
References: <20060407095132.455784000@sergelap>
	<p73hd549o5u.fsf@bragg.suse.de>
	<20060408202840.GB26403@sergelap.austin.ibm.com>
	<200604090800.57814.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 09 Apr 2006 13:08:36 -0600
In-Reply-To: <200604090800.57814.ak@suse.de> (Andi Kleen's message of "Sun,
 9 Apr 2006 08:00:57 +0200")
Message-ID: <m1slomin2j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Saturday 08 April 2006 22:28, Serge E. Hallyn wrote:
>
>> The consensus so far has been to start putting things into task_struct
>> and move if needed.  At least the performance numbers show that so far
>> there is no impact.
>
> Performance is not the only consider consideration here. Overall 
> memory consumption is important too.
>
> Sure for a single namespace like utsname it won't make much difference,
> but it likely will if you have 10-20 of these things.

The highest estimate I have seen is 10, including the current
mount namespace.

Basically it looks like: mounts, uts, sysvipc, net, pid, uid. 
Not very many.

Even in your worst cast estimate of 20.  That puts
us at.  8*20 = 160.  160 vs 10K. or about a 1% size increase.
Not terribly noticeable.

And I think 20 - 40 bytes of increase not 160 is a lot
closer to where we will be in the short term.

>> iirc container patches have been sent before.  Should those be resent,
>> then, and perhaps this patchset rebased on those?
>
> I think so.

That is premature optimization, and it ties the implementations
together.  Which makes implementing this that much harder,
and we do want separate sharing of these things.

Once we have something working I don't have a problem going back
and revisiting what it takes to optimize the size of the
implementation.  But while we still have correctness issues
to worry about such a small optimization before we can
even measure the benefit or have a good feel of the users
does not make sense.

If you really think this is a beneficial approach to reducing
size you can already apply it to all of the thread pointers.
Where the gain is immediately noticeable, and the count is
similar.

We will be happy to follow the best current practices.

Eric
