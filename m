Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWGQN7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWGQN7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWGQN7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 09:59:51 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:31187 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750780AbWGQN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 09:59:50 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1153137181.24228.16.camel@idefix.homelinux.org>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
	 <1152975857.6374.65.camel@idefix.homelinux.org>
	 <1152978284.16617.7.camel@mindpipe>
	 <1153009392.6374.77.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
	 <1153044864.6374.135.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161254260.9870@localhost.localdomain>
	 <1153137181.24228.16.camel@idefix.homelinux.org>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 09:59:13 -0400
Message-Id: <1153144753.652.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 21:53 +1000, Jean-Marc Valin wrote:

> 
> Why not? It could be nice as well if someone wants to implement that.
> I'd already be quite happy to just have basic control on the CPU time.
> 

Have you thought about using something like Xen?  Have a virtual machine
that you can even give root access to users, and still have control of
the actual physical machine.

> As I mentioned earlier, it's not about total lock-up, but having things
> run relatively smoothly and (if possible?) even fairly.

One issue I think you might have is what exactly is a CPU limit?  If the
system is idle, and you have an app that goes into a busy loop, do you
kill it after it hits the limit, even if it isn't RT?  Or do you just
force it to schedule?  Or do you consider idle a special case?  Do you
want just the apps to be limited, or all the apps that belong to a
specific user.

>From this thread, it seems your goal is to have a single console that
users can log into and run a RT thread for audio but still not be able
to lock up the entire system. Right?  So having an RT limit for this use
might actually be beneficial.  But this is a very rare case, and if you
are the only one needing this type of feature, then it will likely not
make it into the kernel.  But it if turns out that lots of people like
this feature, and want it, then it might have a chance, if there is no
other way to accomplish it.

Currently, it looks like you can use either Xen or just stick to one of
the patches you mentioned earlier.

-- Steve

