Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTAET2d>; Sun, 5 Jan 2003 14:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbTAET2c>; Sun, 5 Jan 2003 14:28:32 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:28732
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S265077AbTAET2b>; Sun, 5 Jan 2003 14:28:31 -0500
Message-ID: <3E188956.9090907@splentec.com>
Date: Sun, 05 Jan 2003 14:36:54 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: mdharm-kernel@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: inquiry in scsi_scan.c
References: <UTC200301051307.h05D7da08203.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200301051307.h05D7da08203.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.43.191.223] using ID <tluben@rogers.com> at Sun, 5 Jan 2003 14:36:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> The SCSI code has no means of knowing the actual length transferred,
> so has no choice but to believe the length byte in the reply.
> But the USB code does the transferring itself, and knows precisely
> how many bytes were transferred. If 36 bytes were transferred and
> the additional length byte is 0, indicating a length of 5, then the
> USB code can fix the response and change the additional length byte
> to 31, indicating a length of 36. That way the SCSI code knows that
> not 5 but 36 bytes are valid, and it gets actual vendor and model strings.
> 

And what if the transport is *not* USB? Or they used
a similar firmware of their device server in another
product which used another transport?

I suggest that this device is blacklisted in that
SCSI Core would know that the ADDITIONAL LENGTH field
in the INQURY response is incorrectly set (to 0).
I.e. leave it to the interpreter.

A transport is *not* supposed to peek and poke in the
data it transfers!

-- 
Luben


