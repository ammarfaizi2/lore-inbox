Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbTCIRU0>; Sun, 9 Mar 2003 12:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbTCIRUZ>; Sun, 9 Mar 2003 12:20:25 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:61100 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262549AbTCIRUW>; Sun, 9 Mar 2003 12:20:22 -0500
Date: Sun, 9 Mar 2003 18:30:39 +0100
From: Andi Kleen <ak@muc.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fast path context switch - microoptimize FPU reload
Message-ID: <20030309173039.GA3098@averell>
References: <3E6B769D.2040602@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6B769D.2040602@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 06:15:09PM +0100, Manfred Spraul wrote:

> What about moving TIF_USEDFPU from the thread_info into 
> task_struct->flags? This flag word is only accessed by "current", no 
> special atomicity requirements.

There is still a PF_USEDFPU defined there that can be used.
I'll change it to using that.

But it would be a good idea to completely split the flags that are
changed externally like signals from only process local bits. 

Then we could avoid the wasteful LOCK prefixes for everything local.

-Andi 
