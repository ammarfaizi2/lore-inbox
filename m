Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWCMEiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWCMEiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCMEiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:38:24 -0500
Received: from flex.com ([206.126.0.13]:57872 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S932080AbWCMEiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:38:24 -0500
From: Marr <marr@flex.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?)
Date: Sun, 12 Mar 2006 23:36:55 -0500
User-Agent: KMail/1.8.2
Cc: Linda Walsh <lkml@tlinx.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Andrew Morton <akpm@osdl.org>, marr@flex.com
References: <200602241522.48725.marr@flex.com> <200603121653.30288.marr@flex.com> <44149D6A.7080005@rtr.ca>
In-Reply-To: <44149D6A.7080005@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603122336.55701.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 5:15pm, Mark Lord wrote:
> Marr wrote:
> > I tried turning 'readahead' off entirely ('hdparm -A0 /dev/hda') and,
> > although
>
> No, that should be "hdparm -a0 /dev/hda" (lowercase "-a").

Aha, you're right! Thanks for the clarification.

> And the same "-a" for all of your other test variants.
>
> If you did it all with "-A", then the results are invalid,
> and need to be redone.

Actually, that's impossible to do ('hdparm' won't take such settings with 
'-A'). And, as my original email stated:

   (Values shown for 'readahead' are set by 'hdparm -a## /dev/hda' command.)

In other words, the important tests were done correctly. Sorry I didn't make 
it clearer, but that last test with '-A0' was a complete afterthought (based 
on what I saw on a quick look at the 'man hdparm' page) and in no way negates 
the results from the first part of the tests.

> The hdparm manpage explains this, but in a nutshell, "-A" is the 
> low-level drive firmware "look-ahead" mechanism, whereas "-a" is
> the Linux kernel "read-ahead" scheme.

You are, of course, correct. Unfortunately, my 'man hdparm' page ("Version 6.1 
April 2005") doesn't make this as clear as it could be. The distinction is 
subtle. To quote the '-a'/'-A' part:

-a     Get/set sector count for filesystem read-ahead.  This is used to
              improve performance in  sequential  reads  of  large  files,  by
              prefetching  additional  blocks  in  anticipation  of them being
              needed by the running  task.   In  the  current  kernel  version
              (2.0.10)  this  has  a default setting of 8 sectors (4KB).  This
              value seems good for most purposes, but in a system  where  most
              file  accesses are random seeks, a smaller setting might provide
              better performance.  Also, many IDE drives also have a  separate
              built-in  read-ahead  function,  which alleviates the need for a
              filesystem read-ahead in many situations.

-A     Disable/enable the IDE drive's read-lookahead  feature  (usually
              ON by default).  Usage: -A0 (disable) or -A1 (enable).

A bad interpretation on my part. Thanks again for setting me straight.

Anyway, not that it really matters, but I re-did the testing with '-a0' and it 
didn't help one iota. The 2.6.13 kernel on ReiserFS (without using 
'nolargeio=1' as a mount option) still takes about 4m35s to fseek 200,000 
times on that 4MB file, even with 'hdparm -a0 /dev/hda' in effect.

*** Please CC: me on replies -- I'm not subscribed.
   
Regards,
Bill Marr
