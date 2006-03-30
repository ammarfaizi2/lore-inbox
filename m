Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWC3V2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWC3V2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWC3V2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:28:43 -0500
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:26513 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1750973AbWC3V2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:28:42 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>, "'Ram Gupta'" <ram.gupta5@gmail.com>
Cc: "'linux mailing-list'" <linux-kernel@vger.kernel.org>
Subject: RE: RSS Limit implementation issue
Date: Thu, 30 Mar 2006 15:41:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <442AEB3A.9030503@tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcZUN4sVgvhwtuMhRXm5q+O5RNjKWAACRE9Q
Message-ID: <EXCHG2003g3Sv0YKpDS000000d0@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 30 Mar 2006 21:21:02.0378 (UTC) FILETIME=[D8CF60A0:01C6543F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> 
> A process has no control over its RSS size, only its virtual 
> size. I'm not sure you're clear on that, or just not saying 
> it clearly. Therefore the same process, say a largish perl 
> run, may be 175mB in vsize, and during the day have rss of 
> perhaps half that. At night, with next to no load on the 
> machine, the rss is 175mB because there is a bunch of free 
> memory available.
> 
> If you want to make rss a hard limit the result should be 
> swapping, not failure to run. I'm not sure the limit in that 
> form is a good idea, and before someone reminds me, I do 
> remember liking it better a few years ago.

working_set_size limits sucked on VMS.  The OS would limit a process to
its working set size and casue the entire machine to swap
even though there was adequate free memory.   I believe they
had a normalworkingset size variable, and a maxworkingsetsize
one indicated how much ram you could get on a memory limited 
system, the other indicated the most it would ever let you get even if
there was plenty of free ram.   The maxworkingsetsize caused
a lot of issues, as the default appeared to be defined for
much smaller systems that we were using at the time, and so
were much too low, and cause unnecessary swapping.  Part of the
issue would be that the admin would need to know what he was
doing to use the feature, and most don't.

The argument from the admins at the time was that this limited
the damage to other processes by preventing certain processes
from getting too much memory, they ignored the fact that
anything swapping (even only the one process) unnecessarly 
*KILLED* performance for the entire machine, since swapping
is rather expensive on the os.

                       Roger

