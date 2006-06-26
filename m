Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933035AbWFZVEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbWFZVEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933034AbWFZVEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:04:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33230 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933029AbWFZVEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:04:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Savochkin <saw@swsoft.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 1/4] Network namespaces: cleanup of dev_base list use
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m1odwguez3.fsf@ebiederm.dsl.xmission.com>
	<20060626194205.C989@castle.nmd.msu.ru>
	<m1u067ubm8.fsf@ebiederm.dsl.xmission.com>
	<20060627001437.A5285@castle.nmd.msu.ru>
Date: Mon, 26 Jun 2006 15:02:49 -0600
In-Reply-To: <20060627001437.A5285@castle.nmd.msu.ru> (Andrey Savochkin's
	message of "Tue, 27 Jun 2006 00:14:37 +0400")
Message-ID: <m1irmnpr46.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@swsoft.com> writes:

> Eric,
>
> On Mon, Jun 26, 2006 at 10:26:23AM -0600, Eric W. Biederman wrote:
>> 
>> 
> [snip]
>> It is a big enough problem that I don't think we want to gate on
>> that development but we need to be ready to take advantage of it when
>> it happens.
>
> Well, ok, implicit namespace reference will take advantage of it
> if it happens.

And if fact in that case we don't have to do anything special because
the process pointer will always be correct.

>> >> However short of always having code always execute in the proper
>> >> context I'm not comfortable with implicit parameters to functions.
>> >> Not that this the contents of this patch should address this but the
>> >> later patches should.
>> >
>> > We just have too many layers in networking code, and FIB/routing
>> > illustrates it well.
>> 
>> I don't follow this comment.  How does a lot of layers affect
>> the choice of implicit or explicit parameters?  If you are maintaining
>> a patch outside the kernel I could see how there could be a win for
>> touching the least amount of code possible but for merged code that
>> you only have to go through once I don't see how the number of layers
>> affects things.
>
> I agree that implicit vs explicit parameters is a topic for discussion.
> From what you see from my patch, I vote for implicit ones in this case :)

Yes.  I tend to be against implicit namespaces references mostly because
the explicit ones tend to make the code clearer.

> I was talking about layers because they imply changing more code,
> and usually imply adding more parameters to functions and passing these
> additional parameters to next layers.
> In "routing" code it goes from routing entry points, to routing cache, to
> general FIB functions, to table-specific code (FIB hash).

Yes.  Although as I recall you don't have to pass anything down very far.
Because most functions once you have done the table lookup operate
on just a subset of the table, when they are getting the real work done.

> These additional parameters bloat the code to some extent.
> Sometimes it's possible to save here and there by fetching the parameter
> (namespace pointer) indirectly from structures you already have at hand,
> but it can't be done universally.
>
> One of the properties of implicit argument which I especially like
> is that both input and output paths are absolutely symmetric in how
> the namespace pointer is extracted.

There is an element of that.  In the output path for the most part everything
works implicitly because you are in the proper context.

I need to dig out my code and start comparing to what you have done.

Eric
