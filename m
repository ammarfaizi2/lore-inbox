Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265292AbUE0VbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUE0VbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265313AbUE0VbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:31:23 -0400
Received: from zero.aec.at ([193.170.194.10]:17926 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265292AbUE0VbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:31:22 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
References: <20pwP-55v-5@gated-at.bofh.it> <20suK-7C5-11@gated-at.bofh.it>
	<20tAB-5c-31@gated-at.bofh.it> <20AiB-69m-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 May 2004 23:31:17 +0200
In-Reply-To: <20AiB-69m-17@gated-at.bofh.it> (Ingo Molnar's message of "Thu,
 27 May 2004 23:10:09 +0200")
Message-ID: <m34qq1v9p6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> yeah, this is arguably the biggest (and i think only) conceptual item
> that needs to be solved before this can be integrated.

I would think netdump is more important than this though
(so if anything should be integrated i would start with netdump) 

> it would also be easier to enable diskdump in a driver if this was
> handled in add_timer()/del_timer()/mod_timer()/tasklet_schedule().

I don't think it's a good idea to add this to these fast paths.
Timers are critical for lots of things, tasklet_schedule too.

How about a standard wrapper that does the check and everybody
who may need that uses the wrappers ?

-Andi

