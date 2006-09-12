Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWILSWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWILSWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWILSWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:22:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:19312 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030320AbWILSWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:22:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=VKjiZJA4qcUVtCDdIt+hebuWNDVl28AmhtZgDynQ43mAwiecUCO3gDAnEVtItIuV7RxYtzAIRhAPweKBeONX2ktBHQ2n9Mr/1UlG1dJNYf/wx6Iy0yeaMzEcZ1IAhxDdC6GotnC5MoVDMeHuXUEbATpGx2LnhQiw8Box7a5Z0uk=
Date: Tue, 12 Sep 2006 20:21:41 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjanv@infradead.org
Subject: Re: lockdep warning in check_flags()
Message-ID: <20060912202141.GA1539@slug>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060909083523.GG1121@slug> <20060911054335.GC11269@elte.hu> <20060912141335.GM3775@slug> <20060912165448.GA5751@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912165448.GA5751@elte.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 06:54:48PM +0200, Ingo Molnar wrote:
> 
> * Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > On Mon, Sep 11, 2006 at 07:43:35AM +0200, Ingo Molnar wrote:
> > > 
> > > * Frederik Deweerdt <deweerdt@free.fr> wrote:
> > > 
> > > > Lockdep issues the following warning:
> > > > 
> > > > [   16.835268] Freeing unused kernel memory: 260k freed
> > > > [   16.842715] Write protecting the kernel read-only data: 432k
> > > > [   17.796518] BUG: warning at kernel/lockdep.c:2359/check_flags()
> > > 
> > > this warning means that the "soft" and "hard" hardirqs-disabled state 
> > > got out of sync: the irqtrace tracking code thinks that hardirqs are 
> > > disabled, while in reality they are enabled. The thing to watch for are 
> > > new "stii" instructions in entry.S (and other assembly code), without a 
> > > matching TRACE_HARDIRQS_ON call. [Another, rarer possiblity is NMI code 
> > > saving/restoring interrupts - do you have NMIs enabled? (are there any 
> > > NMI counts in /proc/interrupts?)]
> > NMIs were disabled. But I've just booted -mm2 and the warning went away.
> > Could this be related to the recent pda changes?
> 
> yeah, it could be related to the fix below. Can you confirm that by 
> applying this to your -mm1 tree the message goes away?
> 
It does, thanks Ingo.
Frederik
