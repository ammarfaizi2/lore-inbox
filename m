Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWA2Vcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWA2Vcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWA2Vcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:32:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41191 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751142AbWA2Vcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:32:53 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
	<20060129003606.7887ecd9.akpm@osdl.org>
	<m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
	<20060129024831.4474142f.akpm@osdl.org>
	<20060129152451.GD1764@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 14:32:19 -0700
In-Reply-To: <20060129152451.GD1764@elf.ucw.cz> (Pavel Machek's message of
 "Sun, 29 Jan 2006 16:24:53 +0100")
Message-ID: <m18xsy90v0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> On Ne 29-01-06 02:48:31, Andrew Morton wrote:
>> ebiederm@xmission.com (Eric W. Biederman) wrote:
>> >
>> >  If process id namespaces become a reality init stops being
>> >  terribly special, and becomes something you may have several
>> >  of running at any one time.  If one of those inits is compromised
>> >  by a hostile user I having the whole system go down so we can
>> >  avoid executing a cheap test sounds terribly wrong.  That is
>> >  why I really care.
>> 
>> Wouldn't it be better to do nothing until/unless there's some code in the
>> kernel or init which actually needs the change?

Well I think deliberate kernel bugs should at least be accompanied by
a big fat warning in the code, and an explanation of what is happening
and why.

> It is common to do init=/bin/bash, and I guess people are doing it
> with all kinds of wonderful apps....

So it is just a matter of time before someone actually hits this.

I went back through and tested and the actual symptoms are weird.
The thread calling exec just hangs forever, waiting for pid == 1 to
exit.  Anyway I found a simple fix so it is probably better to fix
it than to paper over the problem anyway.

Patch follows in a minute.

Eric



