Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVDJPG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDJPG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVDJPG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:06:57 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:46548 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261508AbVDJPGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:06:50 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050410103134.GA6234@elte.hu>
References: <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
	 <1112290916.12543.19.camel@localhost.localdomain>
	 <20050331174927.GA11483@elte.hu>
	 <1112317173.28076.10.camel@localhost.localdomain>
	 <20050401044307.GB22753@elte.hu>
	 <1112332426.28076.21.camel@localhost.localdomain>
	 <20050401051947.GA23990@elte.hu>
	 <1112358445.28076.23.camel@localhost.localdomain>
	 <1112908910.22577.54.camel@localhost.localdomain>
	 <20050410103134.GA6234@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 10 Apr 2005 11:06:45 -0400
Message-Id: <1113145605.20980.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 12:31 +0200, Ingo Molnar wrote:

> looks much cleaner than earlier ones. Would it be possible to make the 
> locks per journal? [...]

I've already looked into doing this, but it would be much more intrusive
to implement.  The problem lies where these locks are called with only
the buffer head as a reference. The locks are used to attach or detach
the buffer head from a journal or just see if it is already attached.
So having the lock with the journal is difficult since you need to take
the lock sometimes before you know which journal is needed.  I'm sure
this is possible but it will need modifying the code where the locks are
called instead of just replacing the contents of the lock function.
Maybe with the help of Stephen Tweedie, this can be done. But what I
gave you was the cleanest and most reliable solution currently, without
changing anything but the functions to take the locks.

-- Steve


