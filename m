Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVGHJtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVGHJtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVGHJtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:49:42 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:13454 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262431AbVGHJrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:47:02 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Fri, 8 Jul 2005 10:47:07 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071237.42470.s0348365@sms.ed.ac.uk> <20050707114223.GA29825@elte.hu>
In-Reply-To: <20050707114223.GA29825@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081047.07643.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jul 2005 12:42, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > do you have DEBUG_STACKOVERFLOW and latency tracing still enabled?  The
> > > combination of those two options is pretty good at detecting stack
> > > overflows. Also, you might want to enable CONFIG_4KSTACKS, that too
> > > disturbs the stack layout enough so that the error message may make it
> > > to the console.
> >
> > I already have 4KSTACKS on. Latency tracing is enabled, but
> > STACKOVERFLOW isn't; I'll just reenable everything again until we fix
> > this. Do you think if I removed the printk() line I might get some
> > useful information, before it does the stack trace?
>
> usually such loops happen if the stack has been overflown and critical
> information that lies on the bottom of the stack (struct thread_info) is
> overwritten. Then we often cannot even perform simple printks. Stack
> overflow debugging wont prevent the crash, but might give a better
> traceback.

Well, just to let others who have this problem know, it's clear that Ingo's 
rt-preempt patches increase stack pressure on systems (like mine) where stack 
is borderline under 4K by default.

If you disable CONFIG_4KSTACKS the stack overflows seem to disappear. As a 
result, until we isolate the problem, it'd probably be better if Ingo 
maintained an 8K stacks option in the rt-preempt patches assuming Adrian 
Bunk's "kill !4KSTACKS" patch gets into mainline..

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
