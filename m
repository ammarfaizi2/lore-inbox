Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVBASCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVBASCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVBASCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:02:17 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:59282 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262089AbVBASCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:02:06 -0500
Date: Tue, 1 Feb 2005 19:02:02 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] "biological parent" pid
In-Reply-To: <41FFA98B.2050800@tmr.com>
Message-ID: <Pine.LNX.4.53.0502011854540.26585@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
 <41FFA98B.2050800@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Bill Davidsen wrote:

> Tim Schmielau wrote:
> > The ppid of a process is not really helpful if I want to reconstruct the 
> > real history of processes on a machine, since it may become 1 when the
> > parent dies and the process is reparented to init.
> > 
> > I am not aware of concepts in Linux or other unices that apply to this
> > case. So I made up the "biological parent pid" bioppid (in contrast to the
> > adoptive parents pid) that just never changes.
> > Any user of it must of course remember that it doesn't need to be a valid 
> > pid anymore or might even belong to a different process that was forked in 
> > the meantime. bioppid only had to be a valid pid at time btime (it's
> > a (btime, pid) pair that unambiguously identifies a process).
> 
> I think you are not only using a hammer to swat a fly, buy the wrong 
> fly. Would it not do as well to log reparenting? You could even add that 
> as an option to init, although if you are being lazy about tracking the 
> original parent a kernel log saying something like
>    reparent PID1 from PID2 to PID3
> would be best. While I think all current reparenting is done to init, I 
> could certainly think of a use for a method to reparent back to the 
> grandparent, just to keep the accounting clean.

My idea of a hammer seems to be slightly different. After all, I just 
added _two_lines_ of code [*] to log useful information where useless info 
was logged before.

Any new logging mechanism would be orders of magnitude more expensive.

Tim


[*] or, in other word, 4 bytes per task_struct and one instruction 
to fill that.
