Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWDLGTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWDLGTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWDLGTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:19:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31702 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750939AbWDLGTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:19:31 -0400
Date: Wed, 12 Apr 2006 08:17:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Message-ID: <20060412061715.GA8499@elte.hu>
References: <200604061416.00741.Serge.Noiraud@bull.net> <200604061705.36303.Serge.Noiraud@bull.net> <200604101446.13610.Serge.Noiraud@bull.net> <200604111815.25494.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604111815.25494.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Hi,
> 
> 	It now works with all config parameters set to yes on 2.6.16-rt16.
> however, PERCPU_ENOUGH_ROOM is set to 384KB.
> I'm now trying to lower this value of PERCPU_ENOUGH_ROOM.
> With 256K and 2.6.16-rt16 : doesn't work.
> With 320K : OK
> So I need to use 320K for PERCPU_ENOUGH_ROOM to boot correctly.

great detective work! I've increased it to 512K in my tree, to be on the 
safe side. I'm not sure which parameter takes so much per-cpu space.  
There's certainly no problem with your config, this must be something 
caused by the -rt tree. The -rt tree introduces a new per-cpu concept 
(called PER_CPU_LOCKED) which is used in a couple of cases, but it 
shouldnt cause this drastic increase of the per-cpu area's size. Weird.

	Ingo
