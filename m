Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWIKFC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWIKFC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWIKFC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:02:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34211 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932108AbWIKFC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:02:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com>
	<20060910142942.GA7384@oleg>
	<m18xkreb42.fsf@ebiederm.dsl.xmission.com> <20060910203324.GA121@oleg>
	<m1slizcouy.fsf@ebiederm.dsl.xmission.com> <20060911010534.GA108@oleg>
	<m17j0bcehu.fsf@ebiederm.dsl.xmission.com>
	<20060911025940.GA7216@oleg>
Date: Sun, 10 Sep 2006 23:01:58 -0600
In-Reply-To: <20060911025940.GA7216@oleg> (Oleg Nesterov's message of "Mon, 11
	Sep 2006 06:59:40 +0400")
Message-ID: <m1lkoratdl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 09/10, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@tv-sign.ru> writes:
>> 
>> > On 09/10, Eric W. Biederman wrote:
>> >>
>> >> Updating this old code is painful.
>> >
>> > No, no, we shouldn't change the old code, it is fine.
>> >
>> So what happens when:
>> cpu0:                         cpu1:
>> kill_pid(vt_pid,....)  fn_SAK()->vc_reset()->put_pid(xchg(&vt_pid, NULL))
>> 
>> Can't kill_pid dereference vt_pid after put_pid is called?
>
> Ah, I didn't consider that patch as 'old code', sorry :)

What I meant was that updating code that predates SMP support is painful.
When you said everything was ok. I was confused.

> I don't understand drivers/char/vt*, but surely put_pid(xchg()) can't work.
> Again, unless we have a lock to serialize access to ->vt_pid, but in that
> case we don't need xchg().

Ok.  So we are in violent agreement then, my patch was wrong.

The xchg half works.  For taking and putting a reference it is fine, you
just can't use that reference for anything safely.

So I need to come up with a new patch that gets it's locking correct,
in the fn_SAK case.

Eric
