Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUIPJBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUIPJBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUIPJBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:01:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:40578 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267773AbUIPJBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:01:20 -0400
Date: Thu, 16 Sep 2004 11:01:18 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916090117.GA23621@wotan.suse.de>
References: <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de> <20040916065805.GA12244@elte.hu> <20040916070902.GF12915@wotan.suse.de> <20040916071931.GA12876@elte.hu> <20040916072959.GH12915@wotan.suse.de> <20040916074431.GA13713@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916074431.GA13713@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:44:31AM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Something is mixed up here:
> > 
> > The whole problem only happens on kernels using frame pointer. I never
> > saw it, simply because I don't use frame pointers.
> >
> > On a frame pointer less kernel profiling works just fine, and with
> > this fix it should work the same on a FP kernel.
> 
> it only works on pointer less kernels because the spinlock profile 
> unwinding is _conditional_ on an FP kernel right now:

Actually my idea doesn't work  because there is a one instruction
race where rbp is not set up on the stack yet. I think I give up and just save
%rbp in this case.

-Andi
