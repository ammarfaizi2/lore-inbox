Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWE3L4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWE3L4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWE3L4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:56:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:42137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750928AbWE3L4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:56:32 -0400
X-Authenticated: #14349625
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060530111138.GA5078@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <20060530111138.GA5078@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:58:46 +0200
Message-Id: <1148990326.7599.4.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 13:11 +0200, Ingo Molnar wrote:
> Subject: lock validator, fix NULL type->name bug
> From: Ingo Molnar <mingo@elte.hu>
> 
> this should fix the bug reported Mike Galbraith: pass in a non-NULL 
> mutex name string even if DEBUG_MUTEXES is turned off.

Well, yes and no.  It cures the oops, and it almost boots.  It passes
all tests, and gets to where we start mounting things...

kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
mount/2545 is trying to acquire lock:
 (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa

...and deadlocks.

I'll try to find out what it hates.

	-Mike

