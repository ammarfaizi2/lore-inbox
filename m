Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVGHUtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVGHUtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVGHUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:47:18 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:7831 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262873AbVGHUo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:44:59 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Fri, 8 Jul 2005 21:45:08 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu>
In-Reply-To: <20050708194827.GA22536@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507082145.08877.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jul 2005 20:48, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Unfortunately I see nothing like this when the machine crashes. Find
> > attached my config, which has CONFIG_4KSTACKS and the options you
> > specified. Are you sure this is sufficient to enable it?
>
> i have booted your .config, and stack overflow debugging is active and
> working. So it probably wasnt a straight (detectable) stack recursion /
> stack footprint issue.
>

Okay, I disabled IO-APIC and Local APIC, recompiled with (an otherwise 
identical) config.

Got this (slightly better) oops. Figured out how to use my camera :-)

http://devzero.co.uk/~alistair/oops6.jpeg

Onto your stack-footprint metric. I don't know what the number means, but at a 
guess it's the size of the stack. Unfortunately, if this is the case, it's 
unlikely to be an overflow causing the crash. Here's a grep of dmesg just 
before the crash.

[root] 21:39 [~] dmesg | grep new\ stack
| new stack-footprint maximum: swapper/1, 1760 bytes.
| new stack-footprint maximum: mount/471, 1716 bytes.
| new stack-footprint maximum: cupsd/2623, 1564 bytes.
| new stack-footprint maximum: kdm_greet/2845, 1528 bytes.
| new stack-footprint maximum: krootimage/2846, 1204 bytes.
| new stack-footprint maximum: konqueror/2938, 836 bytes.

The complete traces are a bit long to include here, but I've uploaded the 
entire dmesg:

http://devzero.co.uk/~alistair/dmesg.gz

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
