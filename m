Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVLGOyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVLGOyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVLGOyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:54:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63425 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751095AbVLGOyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:54:08 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Hansen <haveblue@us.ibm.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115055107.GB3252@IBM-BWN8ZTBWAO1>
	<20051113152214.GC2193@spitz.ucw.cz>
	<9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
	<20051116203603.GA12505@elf.ucw.cz>
	<1132174090.5937.14.camel@localhost>
	<20051119233010.GA3361@spitz.ucw.cz>
	<20051120223829.GA9601@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Dec 2005 07:53:09 -0700
In-Reply-To: <20051120223829.GA9601@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Sun, 20 Nov 2005 16:38:29 -0600")
Message-ID: <m1oe3tc622.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Pavel Machek (pavel@ucw.cz):
>> Hi!
>> 
>> > > Hmm... it is hard to judge a patch without context. Anyway, can't we
>> > > get process snasphot/resume without virtualizing pids? Could we switch
>> > > to 128-bits so that pids are never reused or something like that?
>> > 
>> > That might work fine for a managed cluster, but it wouldn't be a good
>> > fit if you ever wanted to support something like a laptop in
>> > disconnected operation, or if you ever want to restore the same snapshot
>> > more than once.  There may also be some practical userspace issues
>> > making pids that large.
>> > 
>> > I also hate bloating types and making them sparse just for the hell of
>> > it.  It is seriously demoralizing to do a ps and see
>> > 7011827128432950176177290 staring back at you. :)
>> 
>> Well, doing cat /var/something/foo.pid, and seeing pid of unrelated process
>> is wrong, too... especially if you try to kill it....
>
> Good point.  However the foo.pid scheme is incompatible with
> checkpoint/restart and migration regardless.

Well if you look at the other uses vserver and bsd style jail
mechanisms the concept is not nearly so ridiculous.

The funny thing though is that this is a trivial thing to continue
to make be sensible.  Run the process in a chroot or a private
namespace and the /var/something/foo.pid works fine.

>
> So if you wanted to checkpoint and restart/migrate a process with a
> foo.pid type of file, you might need to start it with a private
> tmpfs in a private namespace.  That part is trivial to do as part
> of the management tools, though checkpointing a whole tmpfs per process
> could be unfortunate.

The way you describe it I bet that tmpfs will likely be a small
fraction of the size of the processes that you are thinking
about checkpointing.

Eric
