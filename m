Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUBJSK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266090AbUBJSHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:07:51 -0500
Received: from ausadmmsrr504.aus.amer.dell.com ([143.166.83.91]:52240 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S266072AbUBJSGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:06:22 -0500
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F020E5F21@ausx2kmpc106.aus.amer.dell.com>
From: Stuart_Hayes@Dell.com
To: axboe@suse.de
cc: linux-kernel@vger.kernel.org
Subject: RE: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct
Date: Tue, 10 Feb 2004 12:06:03 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C37C2121349082-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At risk of sounding stupid, how can a user space program check the type of
media (DVD vs. CD) that's in the drive?  I think that's what magicdev is
trying to do.
Thanks
Stuart


-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Tuesday, February 10, 2004 11:12 AM
To: Hayes, Stuart
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct


On Tue, Feb 10 2004, Stuart Hayes wrote:
> The attached patch will make the "dvd_read_struct" function in cdrom.c 
> check that the DVD drive can currently do the DVD read structure command 
> before sending the command to the drive.  It does this by checking the 
> "dvd read" feature using the "get configuration" command.
> 
> Currently, cdrom.c only checks that the drive is a DVD drive before 
> allowing the dvd read structure command to go to the drive--it does not 
> make sure that the DVD drive has a DVD in it.  Without this patch, if CD 
> medium is in a DVD drive, and the DVD_READ_STRUCT ioctl is used, the drive
> will spew an ugly "illegal request" error (magicdev does this).

I'm rather anxious about applying anything like this, in my experience
it's much much safer to simply let the command fail. I don't see
anything technically wrong with your approach, I'd just like it tested
on 100 different dvd drives :)

magicdev should be checking the media type itself first.

-- 
Jens Axboe

