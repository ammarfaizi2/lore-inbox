Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbUL3S0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUL3S0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUL3S0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 13:26:11 -0500
Received: from mail.aknet.ru ([217.67.122.194]:21259 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261690AbUL3S0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 13:26:06 -0500
Message-ID: <41D4483C.9030005@aknet.ru>
Date: Thu, 30 Dec 2004 21:26:04 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Alexander Kern <alex.kern@gmx.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: bug: cd-rom autoclose no longer works (fix attempt)
References: <200412301853.48677.alex.kern@gmx.de>
In-Reply-To: <200412301853.48677.alex.kern@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alexander Kern wrote:
>> The ide-cd.c change is as per 2.4.20
>> which works. For some reasons
>> sense.ascq == 0 for me when the tray
>> is opened.
> ascq = 0 is legal.
> According to mmc3r10g
> asc 3a
> ascq 0 is MEDIUM NOT PRESENT
> ascq 1 is MEDIUM NOT PRESENT - TRAY CLOSED
> ascq 2 is MEDIUM NOT PRESENT - TRAY OPEN
> What in my eyes means, your drive is impossible to determine is tray open or 
> closed.
I think so too, this is the problem most
likely. However, my cd-roms are not that
ancient, I expect there are millions of
the like ones around. Breaking autoclose
for all of them after it worked for ages,
is no good IMO.

> Linux assumes if not known tray is closed. That is better default, it 
> avoids infinate trying to close.
I don't think so. It is safe to assume the
tray is opened, at least it worked in the
past (or were there the real problems with
this?) You can always try to close it only
once, and if that still returns 0, then
bail out. One extra closing attempt should
not do any harm I suppose. That's exactly
what my patch does (I hope). And that's most
likely how it used to work before. I'll be
disappointed if autoclose will remain broken -
it was the very usefull feature, it will be
missed. Unless there are the real technical
reasons against the old behaviour, of course.

