Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTBTQjQ>; Thu, 20 Feb 2003 11:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTBTQjQ>; Thu, 20 Feb 2003 11:39:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32712 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265998AbTBTQjO>;
	Thu, 20 Feb 2003 11:39:14 -0500
Date: Thu, 20 Feb 2003 17:49:01 +0100
From: Jens Axboe <axboe@suse.de>
To: "Paul E. Erkkila" <pee@erkkila.org>
Cc: linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vcdxrip , CDROM_SEND_PACKET, and 2.5.42->2.5.43 ide-cd changes
Message-ID: <20030220164901.GZ31031@suse.de>
References: <3E5500BF.2000706@erkkila.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5500BF.2000706@erkkila.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20 2003, Paul E. Erkkila wrote:
> 
> 
> Hi,
> 
>  I often use vcdxrip to pull mpeg data off of
> old vcd's/svcds to archive to tape/dvd. This
> worked fine in the 2.5 kernel series up to
> 2.5.42 where it worked after running the app
> more then once ( i assumed it was an initialization
> error someplace). After kernel 2.5.43 it no longer
> works. I've sent mail to the authors and they
> suggested switching it from using ioctl(CDROM_SEND_PACKET)
> to ioctl(CDROMREADMODE2) , which does work only
> a little slower.
> 
> I've traced it down to cdrom_queue_packet_command() in ide-cd.c
> returning a 0 error status from ide_do_drive_cmd(), and
> req.data_len is 0, and there doesn't appear to be any sense
> available.

Hmm interesting, nothing comes to mind right now. I'll try vcdxrip
myself, please tell me how you typically invoke it to produce the bug.

The best approach for 2.5.x and later is to use the SG_IO ioctl. It's
similar in spirit to CDROM_SEND_PACKET, but much faster. CDROMREADMODE2
should work too, of course.

-- 
Jens Axboe

