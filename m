Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUHJJJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUHJJJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUHJJIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:08:40 -0400
Received: from holomorphy.com ([207.189.100.168]:23015 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263640AbUHJJGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:06:51 -0400
Date: Tue, 10 Aug 2004 02:06:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810090633.GL11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080206.GF11200@holomorphy.com> <20040810083018.GA27270@elte.hu> <20040810085639.GJ11200@holomorphy.com> <20040810090051.GA28403@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810090051.GA28403@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> Actually, what I just narrowed it down to was *only* the printk change
>> fixes it.

On Tue, Aug 10, 2004 at 11:00:51AM +0200, Ingo Molnar wrote:
> when i've seen such things on x86 it was usually some race with
> interrupts on the other CPU. Where do all the ia64 interrupts go to
> during bootup?
> the other possibility is messed up completion logic - some stuff is
> still on this CPU's kernel stack and the printk delays its
> corruption/destruction.

printk() seems to only have a few possible effects. I just tried mdelay()
for the delay effect and not much appears to have happened. I'll probably
try fiddling with schedule(), yield(), and local_irq_enable() and so on
next. Your advice is very much like what I have in mind for possibilities,
except I consider the messed up completion logic ruled out since backing
out the completion removal part of the printk() "fix"  didn't break it.


-- wli
