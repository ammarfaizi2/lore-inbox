Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbULVNu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbULVNu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULVNu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:50:29 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:7583 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261788AbULVNuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:50:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UhPsz2CfE8u+gqk44xavOioaltSJvB9GNXcT58sBPOdBTpmsn2JxS7iteMz6KAjsUg1z6nJFsYjrLNO9pX+9QU/M3lHe0Sn0Svr2cClWhH8QzKutj+o0835z3ehDeMa1TDIN4itCRGMeCRTKadRFWJJ+P6qh1J7H4fFJiHM70+Y=
Message-ID: <7d9243330412220550602b2691@mail.gmail.com>
Date: Wed, 22 Dec 2004 08:50:21 -0500
From: Dan Sturtevant <sturtx@gmail.com>
Reply-To: Dan Sturtevant <sturtx@gmail.com>
To: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: fork/clone external to a process?
In-Reply-To: <41C936AF.7060707@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7d92433304122107491b8b624a@mail.gmail.com>
	 <41C8B128.7010201@xs4all.nl>
	 <7d92433304122116361c2933fb@mail.gmail.com>
	 <41C936AF.7060707@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004 09:56:15 +0100, Pjotr Kourzanov
<peter.kourzanov@xs4all.nl> wrote:

> 
>    What exactly are you referring to by "checkpoint" and "revert"? Do
> you mean temporarily stop and then resume?
> 

Checkpoint is a terrible name for what I want to do to the process. 
The only thing I mean is that I want one of the "forked" processes
either wait() ing for the other one to end or SIGSTOPed so I can wake
it up when the other ends.  The sleeping one will be in the state that
the other was in at the time of the fork.


>    Well, the kernel AFAIK makes deep copies of task structs only on
> behalf of a process (would be a security hole otherwise). I suppose you
> could change that, but I am afraid there will be a lot of resistance to
> it on LKML...
> 

I would never suggest anyone else do this to a kernel they care deeply about.

> >
> > My problem is that I want this to happen on demand rather than
> > whenever the substituted shared library call is invoked inside the
> > executable.
> >
> 
>    Do you really need /that/ flexibility? Just strace vmware and see
> what calls it does and when. Then just pick one that's in libc.so or
> another shared library. Don't forget to pass the call down to the
> original function;-)

I guess LD_PRELOAD could work.  It would be especially nice if I could
get inside a signal handler.

Thanks Pjotr
