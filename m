Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135171AbRDRNIq>; Wed, 18 Apr 2001 09:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133119AbRDRNIi>; Wed, 18 Apr 2001 09:08:38 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59329 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S133120AbRDRNI1>; Wed, 18 Apr 2001 09:08:27 -0400
From: Christoph Rohland <cr@sap.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NEED TESTERS] remove swapin_readahead Re: shmem_getpage_locked() / swapin_readahead() race in 2.4.4-pre3
In-Reply-To: <Pine.LNX.4.33.0104141625200.9455-100000@duckman.distro.conectiva>
	<Pine.LNX.4.21.0104142007320.1866-100000@freak.distro.conectiva>
	<20010417212352.D2505@redhat.com>
Organisation: SAP LinuxLab
Date: 18 Apr 2001 14:50:37 +0200
In-Reply-To: <20010417212352.D2505@redhat.com>
Message-ID: <m3g0f6pe1u.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 17 Apr 2001, Stephen C. Tweedie wrote:
> I don't see the problem.  shmem_getpage_locked appears to back off
> correctly if it encounters a swap-cached page already existing if
> swapin_readahead has installed the page first, at least with the
> code in 2.4.3-ac5.

But the swap count can be increased by anybody without having the page
lock. So the check triggers and is bogus. See my old patch.

> There *does* appear to be a race, but it's swapin_readahead racing
> with shmem_writepage.  That code does not search for an existing
> entry in the swap cache when it decides to move a shmem page to
> swap, so we can install the page twice and end up doing a lookup on
> the wrong physical page if there is swap readahead going on.

I cannot follow you here. How can we have a swap cache entry if there
is no swap entry. . . . Oh stop you mean swapin_readahead does swap in
some totally bogus page into the swap cache after we did
__get_swap_page? I never thought about that!

> To fix that, shmem_writepage needs to do a swap cache lookup and
> lock before installing the new page --- it should probably just copy
> the new page into the old one if it finds one already there.

OK I will look into that.

Greetings
		Christoph


