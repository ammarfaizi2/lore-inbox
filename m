Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312536AbSCYUN4>; Mon, 25 Mar 2002 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312540AbSCYUNr>; Mon, 25 Mar 2002 15:13:47 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:53165 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S312536AbSCYUN3>;
	Mon, 25 Mar 2002 15:13:29 -0500
Message-ID: <003301c1d439$97a26030$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Kevin Pedretti" <ktpedre@sandia.gov>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: do_exit() and lock_kernel() semantics
Date: Mon, 25 Mar 2002 21:13:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thus, for each receive we have to convert the virt address of the
> user-land receive buffer to a physical address (in the kernel region)
> before doing the memcpy (copy_to_user doesn't work from interrupt
> context).

Why do you want to do that at interrupt time?
I'd call map_user_kiobuf() when the user-land buffer is set up, and then
write directly (i.e. with kmap_atomic()) into the pages stored in
iobuf->maplist[]. It avoids the page table scan at interrupt time.

Which platform do you use? map_user_kiobuf() doesn't enforce cache
coherency internally, outside of i386 you might need additional
flush_cache_whatever (see Documentation/cachetlb.txt)

--
    Manfred

