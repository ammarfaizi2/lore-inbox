Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWGMFno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWGMFno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWGMFno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:43:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49056 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751203AbWGMFno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XLdsfjBUynAcw8H4RhUnCQYkSm51qjDLkO3W/0jJt9kEgXqI5C5uO0z0TLI+0pMNp6GtgVdei2l/g0yLhn+0N50BbKWoTO04Kb0SRx5Av255iFC7IJe2fJySQNKw2i4pkvPP9zSCu1nROVc6ddZv77mjsfvNKuRJ4O8XmZs/4Ls=
Message-ID: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
Date: Thu, 13 Jul 2006 01:43:42 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: torvalds@osdl.org, andrea@suse.de, ak@suse.de, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, bunk@stusta.de,
       akpm@osdl.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] let CONFIG_SECCOMP default to n
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I don't think SECCOMP is wrong per se, but I do believe that
> if other approaches become more popular, and the only user of
> SECCOMP is not GPL'd and uses some patented stuff, then we should
> seriously look at the other interfaces (eg the extended ptrace).
>
> Does anybody actually really _use_ SECCOMP outside of the
> patented stuff?

I write debugger code. I can not possibly express how broken
the ptrace interface is. There are numerous corner conditions
that it gets terribly wrong. If you single step over any
"interesting" instructions, if the target plays funny games
with signals or the trap flag...

The utrace stuff offers some hope for eventually fixing this
mess. Please accept that or something similar.

As for SECCOMP... non-root users need high-performance ways
to sandbox things. I do not believe that one solution fits all.
Perhaps SE Linux could be extended to let users sub-divide
their accounts, and certainly ptrace could be made better.

SECCOMP is a good idea, but currently a tad too limiting.
There are a few dozen system calls that would be safe and useful,
particularly those related to signals, memory, and synchronization.

I see no reason to have a config option outside of
CONFIG_EMBEDDED. Ditch the TSC stuff though.
