Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbULFXbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbULFXbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbULFXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:31:20 -0500
Received: from mail.aei.ca ([206.123.6.14]:11717 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261700AbULFXan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:30:43 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Time sliced CFQ #3
Date: Mon, 6 Dec 2004 18:30:33 -0500
User-Agent: KMail/1.7.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041204104921.GC10449@suse.de> <41B45134.4040005@gmx.de> <20041206132749.GX10498@suse.de>
In-Reply-To: <20041206132749.GX10498@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412061830.33418.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

This works here.  Hope you keep patching against mainline.  I`ve 
decided to track it till 2.6.10 comes out...

Thanks,

Ed

On Monday 06 December 2004 08:27, Jens Axboe wrote:
> On Mon, Dec 06 2004, Prakash K. Cheemplavam wrote:
> > Jens Axboe schrieb:
> > >On Mon, Dec 06 2004, Prakash K. Cheemplavam wrote:
> > >
> > >>Hi,
> > >>
> > >>this one crapped out on me, while having heavy disk activity. (updating 
> > >>gentoo portage tree - rebuilding metadata of it). Unfortunately I 
> > >>couldn't save the oops, as I had no hd access anymore and X would freeze 
> > >>a little later...(and I don't want to risk my data a second time...)
> > >
> > >
> > >Did you save anything at all? Just the function of the EIP would be
> > >better than nothing.
> > 
> > Nope, sorry. I hoped it would be in the logs, but it seems as new cfq 
> > went havoc, hd access went dead. And I was a bit too nervous about my 
> > data so that I didn't write it down by hand...
> 
> It is really rare for the io scheduler to cause serious data screwups,
> thankfully. Often what will happen is that it will crash, but with
> everything written fine up to that point. So it's similar to a power
> loss, but the drive should get it's cache out on its own.
> 
> > >Well hard to say anything qualified without an oops :/
> > >
> > >I'll try with PREEMPT here.
> > 
> > If you are not able to reproduce, I will try it again on a spare 
> > partition... Should access to zip drive stil be possible if hd's 
> > io-scheduler is dead?
> 
> Depends on where it died, really. But the chances are probably slim.
> 
> If you feel like giving it another go, I've uploaded a new patch here:
> 
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-6.gz
> 
> Changes:
> 
> - Increase async_rq slice significantly (from 8 to 128)
> 
> - Fix accounting bug that prevented non-fs requests from working
>   correctly. Things like cdrecord and cdda rippers would hang.
> 
> - Add logic to check whether a given process is potentially runnable or
>   not. We don't arm the slice idle timer if the process has exited or is
>   not either running or about to be running.
> 
> - TCQ fix: don't idle drive until last request comes in.
> 
> - Fix a stall with exiting task holding the active queue. This should
>   fix Helges problems, I hope.
> 
> - Restore ->nr_requests on io scheduler switch
> 
> - Kill ->pid from io_context, this seems to have been added with 'as'
>   but never used by anyone.
> 
> 
