Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbTGIORV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbTGIORV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:17:21 -0400
Received: from CPE00e02915899a-CM.cpe.net.cable.rogers.com ([24.157.227.104]:40591
	"EHLO mokona.furryterror.org") by vger.kernel.org with ESMTP
	id S268282AbTGIORT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:17:19 -0400
From: Zygo Blaxell <uixjjji1@umail.furryterror.org>
Subject: Re: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
Date: Wed, 09 Jul 2003 10:31:53 -0400
Organization: Furry Cats and Hungry Terrors
Message-ID: <pan.2003.07.09.10.31.46.883501.10062@umail.hungrycats.org>
References: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org> <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org> <1057743274.506.4.camel@gaston>
User-Agent: Pan/0.11.2 (Unix)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Comment-To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
NNTP-Posting-Host: 10.215.3.77
X-Header-Mangling: Original "From:" was <zblaxell@umail.hungrycats.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jul 2003 05:34:34 -0400, Benjamin Herrenschmidt wrote:

> Whatever happens, you shouldn't let the machine suspend while ongoing
> disk IOs are in progress. A lot of bad things could result from that.

This is unavoidable, without some really draconian measures that will be
highly visible to user-space (killing or stopping processes, umounting
filesystems...).  There will always be a risk that something in user-space
will want to read or write data at the exact moment of suspend.  The apmd
process itself comes to mind.

Bad things haven't happened to me in the 1100+ successful suspend/resume
cycles on this laptop prior to the installation of 2.4.21.  On 2.4.18-20 I
have typical laptop uptimes of 60+ days, including about 80 suspend/resume
cycles.  At conferences I may do 50 suspend/resume cycles within in a
single week, and continue running without rebooting for two months
following.  Most of those suspends occur under some kind of I/O load,
often a quite heavy one.  It is very rare that I can choose the time when
I have to suspend the machine--generally I have to go
somewhere--quickly--and the laptop runs most of the /etc/apm/event.d
scripts from inside its carrying case.  Up to and including 2.4.20, I
could simply expect this to work.

Every month I do a full md5sum-based check of the 800,000-or-so files on
the 48G internal disk and review the files that have changed so that I can
be absolutely _certain_ bad things are not happening (although the check
is designed to handle malicious software, not hardware problems, it will
detect both).

By contrast, 2.4.21 crashes on most resumes.  That's just broken.

> Actually, the proper fix is to implement some working suspend/resume
> handlers in the IDE layer like we did in 2.5, though the problem here is
> that 2.4 lacks proper infrastructure for doing that in a properly
> ordered way.

Um, yes.  That's all very nice, but kernels from 2.4.10 through 2.4.20
were capable of handling this sort of thing all by themselves.  They did
so more by cleaning up after the fact rather than by preventing the mess
from appearing in the first place, but whatever the mechanism was, it did
work in kernels prior to 2.4.21.

If that robustness is due to a bug, then that bug should be reproduced
exactly until a proper solution is ready to replace it.
