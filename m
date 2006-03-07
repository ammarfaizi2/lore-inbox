Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWCGT4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWCGT4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWCGT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:56:11 -0500
Received: from flex.com ([206.126.0.13]:30981 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S1751588AbWCGT4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:56:10 -0500
From: Marr <marr@flex.com>
To: Linda Walsh <lkml@tlinx.org>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?)
Date: Tue, 7 Mar 2006 14:53:46 -0500
User-Agent: KMail/1.8.2
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Andrew Morton <akpm@osdl.org>, marr@flex.com
References: <200602241522.48725.marr@flex.com> <4403935A.3080503@tmr.com> <440B6E05.9010609@tlinx.org>
In-Reply-To: <440B6E05.9010609@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071453.46768.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 March 2006 6:02pm, Linda Walsh wrote:
> Does this happen with a seek call as well, or is this limited
> to fseek?
>
> if you look at "hdparm's" idea of read-ahead, what does it say
> for the device?.  I.e.:
>
> hdparm /dev/hda:
>
> There is a line entitled "readahead".  What does it say?

Linda,

I don't know (based on your email addressing) if you were directing this 
question at me, but since I'm the guy who originally reported this issue, 
here are my 'hdparm' results on my (standard Slackware 10.2) ReiserFS 
filesystem:

   2.6.13 (with 'nolargeio=1' for reiserfs mount): 
      readahead    = 256 (on)

   2.6.13 (without 'nolargeio=1' for reiserfs mount): 
      readahead    = 256 (on)

   2.4.31 ('nolargeio' option irrelevant/unavailable for 2.4.x): 
      readahead    = 8 (on)

*** Please CC: me on replies -- I'm not subscribed.

Regards,
Bill Marr

> I noticed that this seems to default to "256" sectors, or 128K
> in 2.6.
>
> This may be unrelated, but what does the kernel do with
> this number?  I seem to remember this being set to ~8-16 (4-8K)
> in 2.4.  I thought it was the number of sectors to read ahead, by
> default, when a read was done, but I haven't noticed a performance
> degradation like I would expect for such a large read-ahead value.
>
> On the other hand: you do seem to be experiencing something consistent
> with that setting.  I'm not sure under what circumstances the kernel
> uses the "readahead" value as a number of sectors to read ahead...
>
> Have the disk read routines changed with respect to this value?
>
> -linda
