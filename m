Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUJIMkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUJIMkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJIMkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 08:40:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:48032 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266768AbUJIMkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 08:40:22 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 9 Oct 2004 14:18:45 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Geng <linux@MichaelGeng.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041009121845.GE3482@bytesex>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org> <20041009092801.GC3482@bytesex> <20041009112839.GA2908@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041009112839.GA2908@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would prefer redefining them with respect
> to the arguments passed to the IOCTLs.

Thats possible as well.

> Nevertheless there is one big disadvantage: The userspace programs 
> have to be recompiled because they of course have to use the same IOCTL 
> definitions. 

You can just keep the old ones and map them, so both old and new ones
will work (and internally only the new ones are used).
video_fix_command() does that for a number of v4l2 ioctls which
initially got a _IO* define with wrong read/write bits.  You can either
just add the videotext ones there or translate them in the drivers right
before calling video_usercopy().

  Gerd

-- 
return -ENOSIG;
