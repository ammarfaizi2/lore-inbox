Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRD3QN5>; Mon, 30 Apr 2001 12:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135413AbRD3QNs>; Mon, 30 Apr 2001 12:13:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:45369 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132959AbRD3QNd>; Mon, 30 Apr 2001 12:13:33 -0400
Date: Mon, 30 Apr 2001 18:13:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Message-ID: <20010430181304.B5917@athlon.random>
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef> <20010427155246.O16020@athlon.random> <m1k843qoc1.fsf@frodo.biederman.org> <20010430014653.C923@athlon.random> <m1g0erqbxh.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1g0erqbxh.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Apr 29, 2001 at 09:55:06PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 09:55:06PM -0600, Eric W. Biederman wrote:
> Hmm. I was having problems reproducible with
> CONFIG_ALPHA_LARGE_VMALLOC n.
> 
> Enabling the large vmalloc was my work around, because the large
> vmalloc whet back to the prelazy allocation code.

I don't have a clue about your problems but certainly the
CONFIG_ALPHA_LARGE_VMALLOC n is not racy while the
CONFIG_ALPHA_LARGE_VMALLOC y is racy.

> problem I had was entries failed to propagate across different tasks.

With CONFIG_ALPHA_LARGE_VMALLOC n the entry is propagated before
starting using the new pgd so it cannot race, there's no special page
fault case for that beacuse you will never get a page fault because of
an unmapped pgd entry in the vmalloc space in first place.

Andrea
