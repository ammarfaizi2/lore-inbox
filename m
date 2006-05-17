Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWEQIcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWEQIcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWEQIcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:32:12 -0400
Received: from smtp-3.hut.fi ([130.233.228.93]:54471 "EHLO smtp-3.hut.fi")
	by vger.kernel.org with ESMTP id S1750724AbWEQIcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:32:11 -0400
Date: Wed, 17 May 2006 11:30:55 +0300 (EEST)
From: Jan Wagner <jwagner@kurp.hut.fi>
To: Tejun Heo <htejun@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
In-Reply-To: <4466D6FB.1040603@gmail.com>
Message-ID: <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi>
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-TKK-Virus-Scanned: by amavisd-new-2.1.2-hutcc at putosiko.hut.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and thanks for your response,

On Sun, 14 May 2006, Tejun Heo wrote:
> > anyone know if the now already somewhat old Streaming Feature Set of
> > ATA/ATAPI 7 is going to be implemented in the kernel ata functions?
> >
> > According to one web site that contains hdreg.h
> > http://www.koders.com/c/fidCD7293464D782E48F93EEF8A71192F1BF28FC205.aspx
> > there's at least some kind of mention in that include file about streaming
> > feature set, kernel 2.6.10. However in 2.6.16 it seems to be gone again.
> > Any ideas if this will be implemented, or how to use it with e.g. hdparm
> > right now?
>
> I don't think streaming feature set is something to be supported at
> kernel driver level.  The usage model doesn't fit with block interface.

I'm definitely not a kernel guru or into its internals, but IMHO ATA/ATAPI
specifications should all also be supported in the kernel or kernel
module, for compliance, or?

The block device's ioctl could have a "data reliability setting"
extension, specifying either the error recovery time limits or for
enabling continuous read/write control (used to return/use partially
correct data) which are part of the ATA Streaming Feature Set.

I.e. an adjustable minimum acceptable data reliability level for block
devices, which can e.g. be relaxed down from a default 100%.

>   If you want to use it, the best way would be issuing commands directly
> using sg.

Maybe yes, that, or hdparm, but it seems like a horrible hack :) And sg
being for generic SCSI, I'm not sure how well ATA-7 fits in. At least,
the current debian sg-tools, and commands like 'sg_opcodes /dev/sda'
return "Fixed format, current;  Sense key: Illegal Request", "Additional
sense: Invalid command operation code" for those SATA disks I tried.
Doesn't look good for sg useability, AFAICT.

> What are you gonna use it for?

To record or play back real-time continuous streamed data that is not
error-critical but delay critical, from/to a bidirectional data
aquisition card at ~1Gbit/s over longer time spans.

Direct kernel device support for the feature set could also be very useful
for linux projects like the Digital Video Recorder and Video Disk
Recorder. And seek/stutter free video playback from DVD/ATAPI (scratched
disks, for example) or video editing. Etc.

 - Jan
