Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270624AbTHEUIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTHEUIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:08:15 -0400
Received: from colin2.muc.de ([193.149.48.15]:42760 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S270624AbTHEUIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:08:14 -0400
Date: 5 Aug 2003 22:08:10 +0200
Date: Tue, 5 Aug 2003 22:08:10 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805200810.GA31598@colin2.muc.de>
References: <20030805192908.GA19867@averell> <20030805123811.1fe61585.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805123811.1fe61585.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 12:38:11PM -0700, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > Sometimes drivers do long things with interrupt off and the NMI watchdog
> >  triggers quickly. This mostly happens in error handling. It would be 
> >  better to fix the drivers to sleep in this case, but it's not always
> >  possible or too much work.
> 
> yup.
> 
> Do we need an mdelay_while_touching_nmi_watchdog() variant?

Maybe that would be too encoraging for broken code. 

Admittedly I did that by hand for the MPT fusion driver (which currently 
triggers the watchdog when it gets into any error handling situation) 
This especially hurts on x86-64 which runs the watchdog by default. 
But it's strictly a bad hack, not a good interface.

-Andi
