Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270396AbUJUHs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270396AbUJUHs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270333AbUJUHsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:48:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64657 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270409AbUJUHly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:41:54 -0400
Date: Thu, 21 Oct 2004 09:42:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: replace sleep_on_timeout()
Message-ID: <20041021074245.GB20573@elte.hu>
References: <1098300093.20821.58.camel@thomas> <1098343597.28394.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098343597.28394.10.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > -		sleep_on_timeout(&destroy_wait, 1*HZ);
> > +		wait_event_timeout(destroy_wait,
> > +			atomic_read(&clnt->cl_users) > 0, 1*HZ);
> >  	}
> >  
> 
> No. The above is incorrect, and has the potential for a pretty
> catastrophic hang due to the enclosing loop. Please replace with
> 
> 	wait_event_timeout(destroy_wait, atomic_read(&clnt->cl_users) == 0,
> 1*HZ);

ah, indeed. Do you in principle agree with these sleep_on() =>
wait_event*() conversions in the NFS code? (as long as they are
correct). sleep_on() is really becoming an architectural wart these
days.

	Ingo
