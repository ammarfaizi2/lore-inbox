Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVGGLq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVGGLq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVGGLo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:44:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46239 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261227AbVGGLmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:42:31 -0400
Date: Thu, 7 Jul 2005 13:42:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050707114223.GA29825@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071221.47946.s0348365@sms.ed.ac.uk> <20050707112936.GA26335@elte.hu> <200507071237.42470.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071237.42470.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > do you have DEBUG_STACKOVERFLOW and latency tracing still enabled?  The
> > combination of those two options is pretty good at detecting stack
> > overflows. Also, you might want to enable CONFIG_4KSTACKS, that too
> > disturbs the stack layout enough so that the error message may make it
> > to the console.
> 
> I already have 4KSTACKS on. Latency tracing is enabled, but 
> STACKOVERFLOW isn't; I'll just reenable everything again until we fix 
> this. Do you think if I removed the printk() line I might get some 
> useful information, before it does the stack trace?

usually such loops happen if the stack has been overflown and critical 
information that lies on the bottom of the stack (struct thread_info) is 
overwritten. Then we often cannot even perform simple printks. Stack 
overflow debugging wont prevent the crash, but might give a better 
traceback.

	Ingo
