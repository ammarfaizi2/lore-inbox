Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWIWQgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWIWQgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWIWQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:36:50 -0400
Received: from mail.aknet.ru ([82.179.72.26]:56332 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751283AbWIWQgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:36:49 -0400
Message-ID: <451562F3.90103@aknet.ru>
Date: Sat, 23 Sep 2006 20:38:11 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com> <451555CB.5010006@aknet.ru> <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hugh Dickins wrote:
> nor with shm_open.  It's just that the kernel is not allowing
> mmap PROT_EXEC on a MNT_NOEXEC mount.  Which seems reasonable
Even for the MAP_PRIVATE mmaps? But what does that solve?
Even if you restrict mprotect() too, the malicious app will
simply read() the code in the anonymously mapped region,
while the properly-written code just breaks.
Is it documented in any spec or done in any other system?

> If that's a problem for something, don't mount "noexec"
Yes, I myself think "noexec" is rather useless and can always
be bypassed. But whether that particular handling is correct,
doesn't look obvious to me.

>> Thanks for the pointer, but that looks like the user-space
>> issue to me. Why ld.so can't figure out the "noexecness" and
>> do the right thing itself?
> That would be tiresome work.
>> Or does it figure out the "noexecness"
>> exactly by trying the PROT_EXEC mmap and see if it fails?
> Exactly.
So do you mean such a checks were added as a quick hack till
the proper solution is implemented? That may explain the issue,
at least partially...

