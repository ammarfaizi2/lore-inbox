Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSKMXqt>; Wed, 13 Nov 2002 18:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbSKMXqt>; Wed, 13 Nov 2002 18:46:49 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:211
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S264630AbSKMXqr>; Wed, 13 Nov 2002 18:46:47 -0500
Message-ID: <3DD2E5F9.A5594DCB@splentec.com>
Date: Wed, 13 Nov 2002 18:53:29 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Radford <aradford@3WARE.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3w-xxxx: additional ata->sense codes, avoid driver lockup
References: <A1964EDB64C8094DA12D2271C04B812672C86A@tabby>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.43.247.56] using ID <tluben@rogers.com> at Wed, 13 Nov 2002 18:53:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Radford wrote:
> 
> While there may need to be a fix so you don't loop on status=c1,flags=0x11,
> you should know that:
>
> command_packet->status is not a scsi or ATA register value at all.
> 
> (0xC1 == BSY|DRDY|ERR).
> ^^^^^^^^^^^^^^^^^^^^^^^^ this is not true.

Really? Last time I checked the ATA spec, C1h comes
out to BSY=80h | DRDY=40h | ERR=1h.

I was *merely* trying to fix the loop on status=C1h, flags=11h.

By the use of flags (error register) and status's bits, I concluded
that while status is not *the* ATA status register, it's bits
are pretty close. For this reason I used the C1h *mask* to make
everyone happy.

Yes, I did assume that it is massaged by the controller,
but with a closed hardware spec and a bug, I had to start
somewhere.

-- 
Luben
