Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVBSCwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVBSCwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 21:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBSCwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 21:52:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:20682 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261611AbVBSCwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 21:52:16 -0500
Subject: Re: I wrote a kernel tool for monitoring / web page
From: Lee Revell <rlrevell@joe-job.com>
To: sylvanino b <sylvanino@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d14685de05021817333c563cc9@mail.gmail.com>
References: <d14685de050218164127828b06@mail.gmail.com>
	 <1108774916.6040.4.camel@krustophenia.net>
	 <d14685de05021817333c563cc9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 21:52:14 -0500
Message-Id: <1108781534.6040.36.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 02:33 +0100, sylvanino b wrote:
> Sorry, it's meant to run on linux.
> Actually, patch provided is for linux 2.6.9 + kdb 4.4
> 

Cool program.  It has an annoying bug where every time you go to "Open
Log File", it starts you in your home directory again.  Otherwise it's a
nice utility.

I actually have a problem that this might help with.  The issue is that
the scheduler seems to treat Evolution as a CPU bound rather than an
event driven, I/O bound process.  The most obvious symptom is that a
real CPU bound activity like a kernel compile will cause navigating the
message list in Evolution to slow to a crawl.  Evolution is perfectly
usable when no other CPU hogs are running, or when the CPU hogs are
niced, so it's definitely a scheduler issue.

My understanding of Unix schedulers is that the basic idea is to
penalize CPU bound and reward I/O bound processes by giving the former
lower dynamic priority with longer timeslice and the latter high
priority with shorter timeslice.  I suspect the scheduler does not
handle interactive, event driven apps that also consume a lot of CPU due
to bloat very well.  These would seem to need high priority and long
timeslices, which would require the scheduler to distinguish a process
like a kernel compile that will continually exhaust its timeslice no
matter how long, and a process like evolution that if given a long
enough timeslice will finish rendering the message and go back to sleep.

Anyway, that's my hypothesis, I'll let you know what I find out.

Lee


