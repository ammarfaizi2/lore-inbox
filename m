Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbTLCUAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbTLCUAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:00:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55006 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265126AbTLCT76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:59:58 -0500
Date: Wed, 3 Dec 2003 20:59:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <20031203182319.D14999@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0312032059040.4438@earth>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Srivatsa Vaddagiri wrote:

> > maybe i am wrong, but wouldnt a 'break' in the do-while suffice rather 
> > than a goto ?
> 
> I was not sure if the pid_alive check inside the do-while loop is for
> leader_task only or for non-leader tasks also.  If that check is for
> non-leader tasks also, then we would like to retain it still ..

only the starting point should be checked. If the starting point is wrong
then we have no access to the 'thread list' anymore. If the starting point
is alive then all the thread-list walking within the tasklist_lock is
safe.

	Ingo
