Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWJCTFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWJCTFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWJCTFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:05:41 -0400
Received: from mail.aknet.ru ([82.179.72.26]:2573 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1030476AbWJCTFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:05:41 -0400
Message-ID: <4522B4F9.8000301@aknet.ru>
Date: Tue, 03 Oct 2006 23:07:37 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru> <1159900934.2891.548.camel@laptopd505.fenrus.org>
In-Reply-To: <1159900934.2891.548.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Arjan van de Ven wrote:
> then don't put noexec on /dev/shm.
That's obviously possible, but I'd feel safer having
"noexec" on *every* user-writable partition. It used
to work in the past - that way an attacker had no place
to run his binary from.

> ld.so fix is phony. Really; I can always put an "unfixed" ld.so there
> and use it as user. 
See above. In the past it was possible to have "noexec"
on *all* user-writable mounts, so you couldn't run your
own ld.so that easily. Thats why I am reluctant to take
the "if it hurts, just remove noexec" argument.
And since you can run the scripts via binfmt-misc, I'd
also do "chmod 'o-x' perl", so that the direct invocation
of perl to not be possible for unwanted users. Or do not.
At least the approach I propose, allows to do this, so the
"script loader" problem can also be fixed that way.

