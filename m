Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRCPXFT>; Fri, 16 Mar 2001 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRCPXFK>; Fri, 16 Mar 2001 18:05:10 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:64923 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S130733AbRCPXEu>; Fri, 16 Mar 2001 18:04:50 -0500
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "Sane, Purushottam" <Sane_Purushottam@emc.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: fork and pthreads
Date: Fri, 16 Mar 2001 23:11:14 -0000
Message-ID: <JKEGJJAJPOLNIFPAEDHLGEBJCKAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <93F527C91A6ED411AFE10050040665D0560667@corpusmx1.us.dg.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nitin Sane Wrote:
> > On Fri, Mar 16, 2001 at 06:52:26PM +0100, Richard Guenther wrote:
> > > Well, using pthreads and forking in them seems to trigger libc
> > > bugs (read: SIGSEGvs) here under certain conditions (happens,
> > > after I introduced signal handlers and using pthread_sigmask,
> > > I think), so hangs should be definitely possible, too...
> > 
> > You must pretty much avoid using signal handlers with pthreads.
> > In stead, you need to carefully setup things such that most signals
> > are blocked in most threads and a single thread (or selected set
> > of threads) does a sigwait for signals of interest.  Most good
> > pthreads books talk about this issue, as does the DCE documentation.
> 
> I am not using any signals. All the signals are blocked with SIG_IGN
> 

You know, I have been running into that exact same problem, except that
I don't fork at all.  I start up my process and nearly immediately try
and spawn a few threads.  The calling thread blocks indefinately in
a __sigsuspend(), but is apparently delivered an unknown signal.
The spawned thread executes normally.

It appears to be fixed when I compile with -D_REENTRANT, but I am not
certain...

Laramie

