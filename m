Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbTCJUxR>; Mon, 10 Mar 2003 15:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCJUxR>; Mon, 10 Mar 2003 15:53:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29920 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261464AbTCJUxQ>;
	Mon, 10 Mar 2003 15:53:16 -0500
Date: Mon, 10 Mar 2003 12:45:02 -0800 (PST)
Message-Id: <20030310.124502.115944935.davem@redhat.com>
To: ak@suse.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic
 thread_info->status field.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p737kb7542q.fsf@amdsimf.suse.de>
References: <20030310.105659.57012503.davem@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com.suse.lists.linux.kernel>
	<p737kb7542q.fsf@amdsimf.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 10 Mar 2003 22:01:17 +0100
   
   Turned out the 32bit ptrace unlazy FPU path shared two lines too many
   with with the 32bit signal FPU saving path and was resetting the
   used_fpu flag. Result was that the FPU state of the child could be
   reinitialized in some circumstances on ptrace accesses.

So what it depended upon was the FP control register state,
not the state of the individual FPU registers, across fork()
right?
