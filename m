Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbTHQMqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbTHQMqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:46:46 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:55780
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S269583AbTHQMqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:46:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [BUG]  Serious scheduler starvation
Date: Sun, 17 Aug 2003 22:52:52 +1000
User-Agent: KMail/1.5.3
References: <yw1xekzkv5yv.fsf@users.sourceforge.net>
In-Reply-To: <yw1xekzkv5yv.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308172252.52464.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 22:11, Måns Rullgård wrote:
> I'm reposting this, since I got no response last time.
>
> First the machine details.  It's a Pentium4 running at 2 GHz.  Linux
> version 2.6.0-test3 + O16int + softrr.

Softrr ? Which patch? Davide's? Noone has tried to make them compatible 
(yet?). Even so, this may be unrelated to softrr.

> I just experienced something that might be a scheduler problem.  I was

Almost certainly is.

> working in XEmacs, when suddenly the machine became very
> unresponsive.  The mouse pointer in X moved sporadically.  I could
> switch to a text console and log in, though typing lagged tens of
> seconds.  Switching between text consoles was fast, though.  I killed
> xemacs, and the system was back to normal.  Further investigation
> showed that xemacs was stuck in a nasty regexp match.  If I was quick
> enough, I could interrupt it with C-g.
>
> With X and the window manager reniced to -10, they seem to be able to
> get their job done.  This leads me to believe that maybe xemacs is
> considered interactive, and given too high priority when it suddenly
> starts burning the cpu.
>
> I'll try it later with other kernel versions, but right now I don't
> want to reboot.
>
> What can I do to collect more information about the problem?

Run top in batch mode as root reniced to -11 so it doesn't get preempted and 
capture it happening before you kill XEmacs. Then try running XEmacs niced 
+10 and see if it doesn't happen there. Also if it was lucky enough that you 
booted with profiling enabled you could profile it, but top will tell if it's 
a simple scheduler starvation error. 

Con

