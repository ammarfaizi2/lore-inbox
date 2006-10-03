Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWJCTiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWJCTiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWJCTiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:38:51 -0400
Received: from mail.aknet.ru ([82.179.72.26]:16136 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750893AbWJCTiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:38:51 -0400
Message-ID: <4522BCBF.2050508@aknet.ru>
Date: Tue, 03 Oct 2006 23:40:47 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org>  <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <45229C8E.6080503@redhat.com> <4522A691.7070700@aknet.ru> <4522B7CD.4040206@redhat.com>
In-Reply-To: <4522B7CD.4040206@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ulrich Drepper wrote:
> You really don't get it, do you.
Yes, sorry. :)

> The way ld.so works can be implemented
> in many other forms with other programs.
Having "noexec" (in its older form) on *every* user-writable
mount makes it harder for an attacker to run his own loaders,
so implementing it in other forms was useless in the past.

> With some time and energy you
> likely can write a perl or python script to do it.
This is solvable the same way too - "chmod 'o-x' perl"
and run the scripts via binfmt-misc (not sure if this is
really suitable though). You need a trivial kernel patch
to make that possible.

>> And allow an attacker to store his files on that partition,
>> and then execute them.
> They can do it anyway.
With having "noexec" (in its older form) on every user-writable
partition - how they can do it?

>> I have already proposed another solution for ld.so problem
>> 3 times.
> And for obvious reasons I ignored it.
Some explanation could do better, but oh well.

> noexec mounts the way _you_ want them are completely, utterly useless.
But I used them. And having them on _every_ user-writable
mounts at least used to give some results.

> nonexec mounts as they are today plus an upcoming mprotect patch give
As was pointed out by Hugh, such a patch is unlikely.

> fine grained control.
Control of what? The malicious loader will always work - it is
unaffected by both mmap and mprotect changes. So what you can
control is only how many apps you break.

> You have to use additional mechanism like SELinux
> to fill in all the holes but that's OK.
Yes, selinux is the only solution here.

> nonexec mounts give a great
> deal more of flexibility.
Any real-life examples of what problem does this solve?
(except of the already discussed partially-solved ld.so problem)

