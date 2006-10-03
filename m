Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWJCVA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWJCVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWJCVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:00:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030538AbWJCVA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:00:57 -0400
Date: Tue, 3 Oct 2006 17:00:37 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Message-ID: <20061003210037.GO20982@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <1159899820.2891.542.camel@laptopd505.fenrus.org> <4522AEA1.5060304@aknet.ru> <1159900934.2891.548.camel@laptopd505.fenrus.org> <4522B4F9.8000301@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522B4F9.8000301@aknet.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:07:37PM +0400, Stas Sergeev wrote:
> Arjan van de Ven wrote:
> >then don't put noexec on /dev/shm.
> That's obviously possible, but I'd feel safer having
> "noexec" on *every* user-writable partition. It used
> to work in the past - that way an attacker had no place
> to run his binary from.

Even assuming ld.so would be hacked up so that it parses /proc/mounts
to see if you are trying to run an executable via ld.so from
noexec mount (which isn't going to happen), if mmap with PROT_EXEC
is allowed on noexec mounts, you can always put there a shared
library instead of a binary and put some interesting stuff in its
constructors and then just LD_PRELOAD=/dev/shm/libmyhack.so /bin/true
Really, if noexec is supposed to make any sense at all, it needs
to prevent PROT_EXEC mapping/mprotect, otherwise it is completely
useless.

	Jakub
