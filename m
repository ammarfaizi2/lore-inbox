Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVDKWTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVDKWTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDKWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:18:44 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:21778 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261964AbVDKWQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:16:59 -0400
Date: Mon, 11 Apr 2005 15:17:23 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050411221723.GB11685@nietzsche.lynx.com>
References: <F989B1573A3A644BAB3920FBECA4D25A02F64C65@orsmsx407> <20050411085737.GA11109@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411085737.GA11109@elte.hu>
User-Agent: Mutt/1.5.8i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:57:37AM +0200, Ingo Molnar wrote:
> 
> * Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
> 
> > Let me re-phrase then: it is a must have only on PI, to make sure you 
> > don't have a loop when doing it. Maybe is a consequence of the 
> > algorithm I chose. -However- it should be possible to disable it in 
> > cases where you are reasonably sure it won't happen (such as kernel 
> > code). In any case, AFAIR, I still did not implement it.
> 
> are there cases where userspace wants to disable deadlock-detection for 
> its own locks?

I'd disable it for userspace locks. There might be folks that want to
implement userspace drivers, but I can't imagine it being 'ok' to have
the kernel call out to userspace and have it block correctly. I would
expect them to do something else that's less drastic.
 
> the deadlock detector in PREEMPT_RT is pretty much specialized for 
> debugging (it does all sorts of weird locking tricks to get the first 
> deadlock out, and to really report it on the console), but it ought to 
> be possible to make it usable for userspace-controlled locks as well.

If I understand things correctly, I'd let that be an RT app issue and
the app folks should decided what is appropriate for their setup. If
they need a deadlock detector they should decide on their own protocol.
The kernel debugging issues are completely different.

That's my two cents.

bill

