Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268356AbUHQR46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268356AbUHQR46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUHQR46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:56:58 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:64687 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S268365AbUHQR4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:56:24 -0400
Date: Tue, 17 Aug 2004 19:56:11 +0200
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] list of SCSI commands
Message-ID: <20040817175611.GA4192@proton-satura-home>
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton> <20040817155927.GA19546@proton-satura-home> <20040817192748.120a87fc.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040817192748.120a87fc.Ballarin.Marc@gmx.de>
User-Agent: Mutt/1.5.6+20040722i
From: Andreas Messer <andreas.messer@gmx.de>
X-ID: bRAP9QZ6we2MviBcSrTbMn3+FlSwINKj65-YibMlPhopVs84kIX1EL@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 17, 2004 at 07:27:48PM +0200, Marc Ballarin wrote:
> Hi,
> I think the filtering mechanism needs to be refined before we can do
> useful patches. I think it will be necessary to base filtering on
> scsi_type from struct sg_scsi_id (in sg.h and scsi.h). Otherwise it will
> be impossible to get functionality and safety for all devices.

Yes, but some people want to use 2.6.8.1 instead of 2.6.7 (NFS security 
problem) and i only want to provide a short patch to get the old behavior.
Like You, i think  there should be device-class depend accesscontrol-lists. 
But this will need more performance. As there are not that many device 
classes, i would suggest to make one verify-function per device class and 
put a pointer in the file-struct, which will point to the suggested function

> 
> I have compiled a long list of various SCSI commands and tried to
> categorize them. This list is focused on mmc devices (CD-RW, DVD+R).
> Many commands that are only relevant for discs are not included.
> 
> =UNCLEAR=
> MODE SELECT should be safe for mmc devices (sometimes even required).
> However, it often is *not* safe for other devices. This is a case,
> were filtering needs to honor device types.
> 0x15	MODE_SELECT
> 0x55	MODE_SELECT_10
> 0x01	REZERO_UNIT

Yes, this is really a problem.

> I haven't found further information on the following commands. Some are
> probably vendor specific. Annotations are from cdrecord.

Hmm, perhaps i should compare them against the mmc4-spec? They might do 
nothing with mmc-drives?

> =WRITE=
> 0x04	FORMAT_UNIT	// is this safe for disks?

No, according to sbc2-spec it will format the entire harddisc.

> =RAWIO=
> Some modes of WRITE_BUFFER are safe even for read, others
> overwrite firmware. Misdesign.
> 0x3B	WRITE_BUFFER

According to spc3-spec (mentioned in sbc2) it will only used 
to check performance of the device or programm the firmware


-- 
gnuPG keyid: 0xE94F63B7 
fingerprint: D189 D5E3 FF4B 7E24 E49D 7638 07C5 924C E94F 63B7
