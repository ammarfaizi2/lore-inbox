Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVDBWM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVDBWM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVDBWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:12:47 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:54433 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261296AbVDBWKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:10:03 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1112474659.27149.39.camel@localhost.localdomain>
References: <20050325145908.GA7146@elte.hu>
	 <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com>
	 <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
	 <1112472372.27149.23.camel@localhost.localdomain>
	 <20050402203550.GB16230@elte.hu>
	 <1112474659.27149.39.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 02 Apr 2005 17:09:32 -0500
Message-Id: <1112479772.27149.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 15:44 -0500, Steven Rostedt wrote:
> On Sat, 2005-04-02 at 22:35 +0200, Ingo Molnar wrote:

> > > 
> > > FYI
> > > 
> > > For kicks I ran this on 2.6.11-rc2-RT-V0.7.36-02 (I still had it as a 
> > > Grub option), and the system just locked up hard.  I just was curious 
> > > if this was from a different change. But at least in the latest it 
> > > shows output, and not just a hard lockup.
> > > 
> > > Oh, the bug report was running kernel 2.6.12-rc1-RT-V0.7.43-06.
> > 
> > ok, so it's not the recent NFS changes.
> > 
> 
> I may need to take this back. I forgot to open the serial, so it wasn't
> accepting input. So it would just appear dead. And the console was
> fighting against the RT tasks, so it too would seem to be dead.  I've
> reran the test on the latest, but this time I didn't have the NFS
> mounted, and it's still running.
> 

I tried the 2.6.12-rc1-RT-V0.7.43-06 kernel again, and I still have the
serial, to do sysrq. The console is using X which locks (even all the
ctrl-alt-X functions) and the ssh session that I run the test stops
after the processes try to grab the locks. It doesn't reply to ping. But
the sysrq from the serial shows constantly:

s        test3_rt: 2269 [cf304690,  89] (not blocked)
s        test3_rt: 2270 [cf304050,  88] (not blocked)
s        test3_rt: 2271 [cef86cb0,  87] (not blocked)
s        test3_rt: 2272 [cef86670,  86] (not blocked)
R        test3_rt: 2273 [cf28a050,  85] (not blocked)


So it seems that it's in a deadlock somewhere. Since the 43-06 gets much
further, this seems to be another problem. I'm not going to look at this
problem anymore, since it doesn't show up in the lastest.

I'll run a few more tests to see if I can narrow things down on 43-06.

-- Steve

