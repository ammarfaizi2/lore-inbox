Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVIEQY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVIEQY3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVIEQY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:24:29 -0400
Received: from orb.pobox.com ([207.8.226.5]:40419 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932296AbVIEQY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:24:28 -0400
Message-ID: <431C7131.3030506@rtr.ca>
Date: Mon, 05 Sep 2005 12:24:17 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Oliver Tennert <O.Tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD+-R[W] regression in 2.6.12/13
References: <200509051533.01465.tennert@science-computing.de>
In-Reply-To: <200509051533.01465.tennert@science-computing.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Tennert wrote:
>
> "hdparm -I /dev/dvdrecorder" leads to the output:
> 
> /dev/dvdrecorder:
>  HDIO_DRIVE_CMD(identify) failed: Input/output error
> 
> The kernel tells me:
> 
> [4296893.262000] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> [4296893.262000] hdd: drive_cmd: error=0x04 { AbortedCommand }
> [4296893.262000] ide: failed opcode was: 0xec

Those messages are "normal" for an ATAPI drive.

hdparm first tries the IDENTIFY opcode (0xec), and if that fails (above)
it then tries the PACKET_IDENTIFY opcode (0xa1), which should work for ATAPI.

I'm not sure why the "failed: Input/output error" (-EIO) result is
being returned from the ATA layer in this case.  Driver bug, most likely.

Cheers
