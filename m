Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTCJTFL>; Mon, 10 Mar 2003 14:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbTCJTFK>; Mon, 10 Mar 2003 14:05:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42975 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261413AbTCJTFJ>;
	Mon, 10 Mar 2003 14:05:09 -0500
Date: Mon, 10 Mar 2003 10:56:59 -0800 (PST)
Message-Id: <20030310.105659.57012503.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic
 thread_info->status field.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303101905.h2AJ56P00946@hera.kernel.org>
References: <200303101905.h2AJ56P00946@hera.kernel.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
   Date: Mon, 10 Mar 2003 18:20:35 +0000
   	
Linus said, in a recent BK changelog:

   	Also, fix x86 FP state after fork() by making sure the FP is unlazied
   	_before_ we copy the state information. Otherwise, if a process did a
   	fork() while holding the FP state lazily in the registers, the child
   	would incorrectly unlazy bogus state.
   
At least on sparc{32,64}, we consider FPU state to be clobbered coming
into system calls, this eliminates a lot of hair wrt. FPU state
restoring in cases such as fork().

Are you preserving FPU state across fork() on x86?  If so, what do you
think might rely on this?
