Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTE2X7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTE2X7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:59:04 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:58375 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263202AbTE2X7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:59:03 -0400
Message-ID: <3ED6A19B.4000809@interlog.com>
Date: Fri, 30 May 2003 10:11:07 +1000
From: Douglas Gilbert <dgilbert@interlog.com>
Reply-To: dgilbert@interlog.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: appro@fy.chalmers.se
Subject: Re: readcd with 2.5 kernels and ide-cd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Polyakov wrote:

 > Nothing fishy, nothing at all... It's as simple as
 > driver/block/scsi_ioctl.c doesn't accepts requestes
 > larger than 64KB, while readcd asks for 256KB.

Yes, that 64KB should be increased. The sg driver
allows up to 255 * 32 KB (just less than 8MB). From
memory cdparanoia uses a 128 KB packet size.
cdrecord uses 63 KB so it gets through.

 > > 0x2285 is the SG_IO ioctl.

 > sg_io returns EINVAL (line 163), but driver/block/ioctl.c
 > transforms it to ENOTTY (see last 8 lines).

That is unhelpful. Is there a good reason for that?

I plan to get working on the SG_IO ioctl in the block
layer shortly. Andy has a patch to address the units
of the command timeout. sg's iovec may map simply as
well (maybe it won't either).

Doug Gilbert

