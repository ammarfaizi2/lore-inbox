Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUBWQpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUBWQpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:45:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47309 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261953AbUBWQo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:44:29 -0500
Date: Mon, 23 Feb 2004 17:45:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040223164529.GA5085@elte.hu>
References: <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu> <20040221075853.GA828@elte.hu> <20040223105953.GA2992@openzaurus.ucw.cz> <20040223135520.GA30321@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223135520.GA30321@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jamie Lokier <jamie@shareable.org> wrote:

> Another issue is that most machines don't have nanosecond resolution
> clocks (e.g. m68k is limited to timer interrupt resolution, and some
> x86 machines cannot use the cycle counter), [...]

this is not an issue, with the monotonicity solution i suggested: if
prev_time == curr_time then curr_time.tv_nsec++.

> [...] and most filesystems don't store them either.

their problem. There's at least one filesystem that does it right (XFS),
the rest will be handled via natural selection.

> The right place to put the delay is in the kernel, when mtime is set
> or when it is read, or both.

no need to delay anything - just do the tv_nsec++ thing!

	Ingo
