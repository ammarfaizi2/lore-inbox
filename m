Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUBWNYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUBWNXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:23:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61110 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261848AbUBWNXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:23:13 -0500
Date: Mon, 23 Feb 2004 11:59:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040223105953.GA2992@openzaurus.ucw.cz>
References: <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu> <20040221075853.GA828@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221075853.GA828@elte.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> generation counters are problematic if they are not persistent. But
> there's a pretty natural persistent 'generation counter' which could be
> used for Samba's purpose: the mtime of the directory. The problem right
> now is that it doesnt have enough resolution to be a true unique
> generation counter. But having high-resolution mtime is a goal anyway.
> 
> XFS is one filesystem that has high-resolution mtime:
> 
>  typedef struct xfs_timestamp {
>          __int32_t       t_sec;          /* timestamp seconds */
>          __int32_t       t_nsec;         /* timestamp nanoseconds */
>  } xfs_timestamp_t;
> 
> monotonity is important: two successive directory operations to not be
> possible within the same nanosecond. This is not possible with current
> hardware - but how about future hardware? Can we make an assumption like
> this?

Does not ndelay(1) if samba notices mtime is too young in the samba code
fix that?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

