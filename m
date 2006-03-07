Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWCGWHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWCGWHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWCGWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:07:36 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55484 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751581AbWCGWHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:07:34 -0500
Date: Tue, 7 Mar 2006 23:06:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Message-ID: <20060307220628.GA27536@elte.hu>
References: <1141769000.5565.21.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141769000.5565.21.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> The symptoms are as follows:
>   - start jack using qjackctl
>   - start qsynth (gui front end for fluidsynth, a synth)
>   - start rosegarden (midi sequencer and audio recorder)
>   - load a midi file into rosegarden
>   - midi file plays successfully
>   - close rosegarden
> at this point one of the threads of rosegarden fails to exit and stays
> forever in the process list, in a ps axuw it shows as:
> 
> nando 5484 0.0 0.0 0 0 pts/1    D    13:32   0:00 [rosegardenseque]
> 
> Anything else that I try to stop that touches the alsa sequencer never
> dies (qjackctl, vkeybd, qsynth, etc). Anything I try to start that tries
> to use it does not start. This happened with two widely different

could you get a tasklist-dump? It's either SysRq-T, or:

	echo t > /proc/sysrq-trigger

that should dump all tasks and their backtraces - including the hung 
rosegardensequencer task.

	Ingo
