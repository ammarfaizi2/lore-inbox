Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVBAQFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVBAQFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVBAQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:05:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49818 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262056AbVBAQFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:05:06 -0500
Message-ID: <41FFA98B.2050800@tmr.com>
Date: Tue, 01 Feb 2005 11:08:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] "biological parent" pid
References: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> The ppid of a process is not really helpful if I want to reconstruct the 
> real history of processes on a machine, since it may become 1 when the
> parent dies and the process is reparented to init.
> 
> I am not aware of concepts in Linux or other unices that apply to this
> case. So I made up the "biological parent pid" bioppid (in contrast to the
> adoptive parents pid) that just never changes.
> Any user of it must of course remember that it doesn't need to be a valid 
> pid anymore or might even belong to a different process that was forked in 
> the meantime. bioppid only had to be a valid pid at time btime (it's
> a (btime, pid) pair that unambiguously identifies a process).

I think you are not only using a hammer to swat a fly, buy the wrong 
fly. Would it not do as well to log reparenting? You could even add that 
as an option to init, although if you are being lazy about tracking the 
original parent a kernel log saying something like
   reparent PID1 from PID2 to PID3
would be best. While I think all current reparenting is done to init, I 
could certainly think of a use for a method to reparent back to the 
grandparent, just to keep the accounting clean.

The init option would be unintrusive, but I doubt many people would feel 
the need for a kernel log feature. On the other hand it doesn't happen 
often, I looked at a system up 172 days and it had nothing but the 
daemons reparented (at the moment).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
