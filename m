Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWI1Eue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWI1Eue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWI1Eue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:50:34 -0400
Received: from mail.aknet.ru ([82.179.72.26]:3340 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751556AbWI1Eud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:50:33 -0400
Message-ID: <451B54FA.9040908@aknet.ru>
Date: Thu, 28 Sep 2006 08:52:10 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1159396436.3086.51.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Arjan van de Ven wrote:
> but really again you are degrading what noexec means.
I actually want to return some of the former use of it.
Right now it is not usefull at all. Previously it was a
good idea to put "noexec" on every user-writable partition.
That was a guarantee that at least until someone wrote a
loader *script*, the attacker can't execute his binaries.
Such a script is AFAIK not written up to now, so that worked.
Right now the policy is: don't put "noexec" to /dev/shm tmpfs
or the apps will break. Don't put it on the non-native
partitions or the emulators (like Wine) will became slow
and memory-hungry (using read()) or will break.
Basically, there now seem to be no use for "noexec" at all.
And leaving at least a single fs (/dev/shm) without "noexec"
is almost as bad as not using it completely, as there is
already a space to execute the malicious binaries.

> It now starts to mean "only don't execute a little bit"
It means "don't execute the binaries with the exec call".
That used to work and I think this is what the other OSes
have.

> rather than
> "deny execute requests"....
Please, explain me, what exactly you can deny? File-backed
MAP_PRIVATE mmap is only a more effective way of doing the
MAP_PRIVATE|MAP_ANONYMOUS mmap and read(), which is not affected.
So you force the normal progs to fall-back to the less effective
methods, while the malicious ones are not affected at all.
What is that magic value in denying the fast and memory-efficient
method of doing something, and to force people to use the slow
one? How can it be related to security at all?
Making a problem to an attacker up to forcing him to write a
loader script, is good. Making him no problems at all by
forcing people to not use "noexec" on /dev/shm and friends,
or, at best, forcing him to replace file-backed mmap with the
anonymous mmap in his malicious loader, is IMHO not security-
wise at all.

