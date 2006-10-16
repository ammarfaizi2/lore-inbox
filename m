Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWJPOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWJPOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJPOg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:36:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19175 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750751AbWJPOg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:36:56 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Date: Mon, 16 Oct 2006 16:36:52 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610161208.13628.ak@suse.de> <20061016141342.GF15540@frankl.hpl.hp.com>
In-Reply-To: <20061016141342.GF15540@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161636.52721.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With the original code, the number of callbacks you see for IDLE_START and
> IDLE_STOP is not too obvious.
> 
> On an idle system Opteron 250 with HZ=250, one would expect to see for a 10s duration:
> 	- for CPU0      : IDLE_START = IDLE_STOP = about 5000 calls
> 	- for other CPUs: IDLE_START = IDLE_STOP = about 2500  calls

Yes.

> With the original code, you get the following number of calls:
> 
> CPU0.IDLE_START = 44 (enter_idle)
> CPU0.IDLE_STOP  = 5206 (exit_idle)
> 
> CPU1.IDLE_START = 27 (enter_idle)
> CPU1.IDLE_STOP  = 2528 (exit_idle)
> 
> Now, of course, you may get "batched" interrupts where you do not return to idle
> before you process the next interrupt. But the difference seems quite high here.

Shouldn't happen for timer interrupts.
> 
> Do you have an explanation for this?

Hmm, the last time I fixed this when you complained (post .18) i added a counter for 
entry/exit and verified that it was balanced. I haven't rechecked since then.
I don't know why your numbers are off. You're using the latest git tree, right?
 
-Andi

