Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbRDQLVL>; Tue, 17 Apr 2001 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRDQLVB>; Tue, 17 Apr 2001 07:21:01 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:31236 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132118AbRDQLUt>;
	Tue, 17 Apr 2001 07:20:49 -0400
Message-ID: <20010417131631.A1102@bug.ucw.cz>
Date: Tue, 17 Apr 2001 13:16:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE843@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE843@orsmsx35.jf.intel.com>; from Grover, Andrew on Mon, Apr 16, 2001 at 04:32:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There are 32 signals, and signals can carry more information, if
> > required. I really think doing it way UPS-es are done is right
> > approach.
> 
> I would think that it would make sense to keep shutdown with all the other
> power management events. Perhaps it will makes more sense to handle UPS's
> through the power management code.

Yes, that would be another acceptable solution. Situation where half
of power managment (UPS) is done with init and half with acpid is not
acceptable. [I doubt UPS users will want to switch. Why invent new
daemon when init is doing perfect job?]

However, I believe that simple way of sending signal to init is best
solution. It will suffice in 99% cases, users already know how to
configure init, and it does not need another process in userspace. In
remaining 1% case, init can simply notify acpid that even came.

I believe that one-patch is still worth applying. *Maybe* signal
should be changed to SIGUSR1 (to make room for SIGUSR2 to be sleep
button).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
