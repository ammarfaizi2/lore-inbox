Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263948AbTDNVlM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTDNVko (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:40:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48099 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263940AbTDNVjB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:39:01 -0400
Date: Mon, 14 Apr 2003 14:47:02 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Christian Staudenmayer <the_sithlord@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic (2.5.67-ac1)
Message-ID: <20030414144702.A18565@beaverton.ibm.com>
References: <20030414192548.48370.qmail@web12108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030414192548.48370.qmail@web12108.mail.yahoo.com>; from the_sithlord@yahoo.com on Mon, Apr 14, 2003 at 12:25:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 12:25:48PM -0700, Christian Staudenmayer wrote:
> hello,
> 
> (i've posted a similar message before but i've been told to add the whole error
> message, so here it is. sorry about that, but typing screenfulls of hex numbers
> makes me feel like a geek but it also makes my head hurt ;)
> 
> the 2.5.67 kernel boots fine here, but the -ac1 patch to it ends up in 
> a kernel panic.
> here are the last 25 lines of the error, i don't know if there is more above of it,
> scrolling up didn't work... (btw there can be typos in it ;)

This stack looks very much like the problem with scsi queue plugging
behaviour and the removal of blk_empty_queue. It is not always hit, there
could easily be something in ac that changed the timing.

[If so] this is not a problem in the ac kernel, even though you only hit
it after adding the ac patch.

James B sent in a fix, it's included in the current bk tree, the changelog
says:

  fix scsi queue plugging behaviour
  
  Following recent changes removing blk_queue_empty(), we were
  incorrectly plugging the queue some times (most often as part of
  the SCSI scan process).  This was causing a non-deterministic panic
  in the scan code because a destroyed queue was sometimes being
  unplugged and run.

Or see this for log and patch:

http://linux.bkbits.net:8080/linux-2.5/cset@1.971.103.27?nav=index.html|ChangeSet@-2d

The patch won't apply cleanly on top of 2.5.67.

-- Patrick Mansfield
