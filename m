Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290665AbSBLBJL>; Mon, 11 Feb 2002 20:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290684AbSBLBJB>; Mon, 11 Feb 2002 20:09:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25734 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290665AbSBLBIx>;
	Mon, 11 Feb 2002 20:08:53 -0500
Date: Mon, 11 Feb 2002 17:07:09 -0800 (PST)
Message-Id: <20020211.170709.118972278.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200202120101.g1C11OJZ010115@napali.hpl.hp.com>
In-Reply-To: <20020211.164617.39155905.davem@redhat.com>
	<200202120101.g1C11OJZ010115@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 17:01:24 -0800
   
   I hope you don't consider this a good argument to force all the other
   platforms to throw away their perfectly good low-core code.

I didn't have to change any of my locore code, what the heck
are you talking about? :-)  All of the changes to _ANY_ assembly
on sparc64 looked like this:

-	lduw	[%g6 + AOFF_task_thread + AOFF_thread_flags], %l0
+	lduw	[%g6 + TI_FLAGS], %l0

It actually cleaned up my locore code :-)

I think, in fact, the everything people have right now in
thread_struct should move to thread_info and we should kill
off thread_struct entirely.  It has no reason to exist anymore.
