Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbTCQRPv>; Mon, 17 Mar 2003 12:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbTCQRPv>; Mon, 17 Mar 2003 12:15:51 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:11697 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261773AbTCQRPu>; Mon, 17 Mar 2003 12:15:50 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: jakub@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Why is get_current() not const function?
From: Andi Kleen <ak@muc.de>
Date: Mon, 17 Mar 2003 18:26:05 +0100
In-Reply-To: <b53pqi$ud9$1@penguin.transmeta.com.suse.lists.linux.kernel> (torvalds@transmeta.com's
 message of "17 Mar 2003 07:29:40 +0100")
Message-ID: <m3u1e1ykeq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030313061926.S3910@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<b53pqi$ud9$1@penguin.transmeta.com.suse.lists.linux.kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

>>					 and why on x86-64
>>the movq %%gs:0, %0 inline asm is volatile with "memory" clobber?
>
> Can't help you on that one, but it looks like it uses various helper
> functions for doing the x86-64 per-processor data structures, and I bet
> those helper functions are shared by _other_ users who definitely want
> to have their data properly re-read. Ie "current()" may be constant in
> process context, but that sure isn't true about a lot of other things in
> the per-processor data structures.

Yes, that's the big issue. const current requires non volatile read_pda()
and making read_pda non volatile breaks lots of code currently and probably
needs an audit over all users.

-Andi
