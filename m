Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWIXUGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWIXUGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWIXUGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:06:06 -0400
Received: from mail.aknet.ru ([82.179.72.26]:6154 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751354AbWIXUGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:06:03 -0400
Message-ID: <4516E581.4070404@aknet.ru>
Date: Mon, 25 Sep 2006 00:07:29 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ulrich Drepper <drepper@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <1159127978.11049.35.camel@localhost.localdomain>
In-Reply-To: <1159127978.11049.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
>> 2. Do the anonymous mmap with PROT_EXEC set, then simply read()
>> the code there, then execute. This you *can not* restrict!
> Its a non-finite turing machine, you can also execute an interpreter.
Exactly. So the question is: what does the current checks
prevent from working if the above is always possible? Answer -
the properly-written apps. Or am I missing something?

>> Now, the breakage of the properly-written programs forces people
>> to stop using "noexec" on /dev/shm-mounted tmpfs. As far as I
> But you've already just argued that this isn't useful anyway ?
Until the malicious loader *script* is written, there is at least
the use. You can easily write the malicious non-script loader,
but you'll have problems invoking it from the noexeced partition.
Most of the current security techniques makes the attack more
difficult but not eliminate it entirely. Without such a magic
script, noexec does its work rather effectively I think (provided
that ld.so is fixed too).
The point is: adding such a checks for mmap() does *not* make
that work of noexec any more effective, but instead breaks the
existing apps or configurations, forcing people to resort to the
weaker configurations. Except for the very suspicious help for
ld.so, noone so far mentioned a *single* advantage of such a
checks, or I might have been blind. :)

>> understand, having the single writeable and executable mountpoint
>> is almost as bad as having all of them. The attacker will now simply
>> put his binary into /dev/shm.
> SELinux
... while before, the "noexec" could do the trick quite right.
That's what I was saying: "noexec" is becoming useless after
such a change, the one now needs SELinux to achieve the same
goal without breaking the existing apps.
I am not at all in favour of noexec. But before, it did one simple
task (fail exec calls) and it was clear where to use it and
where not. Now it pretends to do something more, but in fact,
compared to the older behaviour, the only difference is that now
it breaks apps where before it could be used safely. There are
no other differences, or at least I haven't seen them.

