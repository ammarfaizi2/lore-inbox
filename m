Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVEZDnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVEZDnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 23:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVEZDnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 23:43:49 -0400
Received: from relay3.usu.ru ([194.226.235.17]:15247 "EHLO relay3.usu.ru")
	by vger.kernel.org with ESMTP id S261172AbVEZDnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 23:43:31 -0400
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Date: Thu, 26 May 2005 09:45:01 +0600
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de,
       schilling@fokus.fraunhofer.de
References: <4847F-8q-23@gated-at.bofh.it> <4295005F.nail2KW319F89@burner> <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
In-Reply-To: <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505260945.01886.patrakov@ums.usu.ru>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.30.0.15; VDF: 6.30.0.202; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 05:31, Kyle Moffett wrote:

> Did you try submitting a list of important SCSI commands and their
> functions?
> I suspect that if you provide a clear, concise list of harmless
> commands,
> they would be included in the available command set.

That list would be device-dependent. See two examples below.

1) cdrecord uses some Sony proprietary commands instead of standard MMC ones 
if the drive seems to be made by Sony. What is the effect of those Sony 
commands on non-Sony drives?

2) I have the following DVD-ROM + CD-RW combo drive:

'PHILIPS ' 'CDD5301         ' 'P1.2'

Originally, I bought it with the 'B1.1' firmware revision. This drive with old 
firmware is a security hole by itself: if one calls cdrecord dev=/dev/hdd 
-dao some-image.iso, the drive will enter some strange mode at the end. In 
particular, it will flash its light randomly, will never give the CD back 
(waited 15 minutes), and will prevent communication with /dev/hdc until I 
power off the computer (pressing Reset is not enough). Burning CDs with -raw 
switch instead of -dao works. With newer firmware, -dao doesn't lock up the 
drive, but still results in damaged CDs.

Also this drive always silently produces CDs with a lot of wrong bits (but a 
useless and broken image can still be read with dd or readcd) when BurnFree 
is off.

So this filter, if it is in the kernel, should forbid commands specific to SAO 
burning for this drive _and_ also return a modified list of capabilities for 
this drive (i.e. say that this drive _cannot_ burn in SAO mode).

Isn't this too much knowledge for the kernel?

-- 
Alexander E. Patrakov
P.S. I know that the proper solution would be to replace the drive. I tried 
returning it to the shop, they said "no, it is in order because it works with 
Nero in Windows" and fined me for $25 for their "expertize".
