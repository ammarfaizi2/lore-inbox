Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVBUXO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVBUXO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 18:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVBUXO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 18:14:26 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:57860 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262174AbVBUXOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 18:14:11 -0500
Message-ID: <421A6B42.2070108@superbug.demon.co.uk>
Date: Mon, 21 Feb 2005 23:14:10 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, mhf@berlios.de,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.11-rc[234] setfont fails on i810 after resume from
 ACPI-S3
References: <20050215122233.22605728.akpm@osdl.org> <20050215202212.GK7338@elf.ucw.cz>
In-Reply-To: <20050215202212.GK7338@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>Any thoughts on this one?  We should come back from resume in 30-row mode,
>>shouldn't we?
> 
> 
> Well, current state of video resume is "we are happy to see anything
> at all". 
> 
> 
>>HW info
>>
>>Using vga=0xf07, default8x16 font, display has 30 lines
>>
>>On powerup from S3 console has only 25 lines but still scrolls 
>>at 30 lines. Setfont historically fixes it. 
>>
>>Tested with 2.6.10, 2.6.11-rc1: OK
>>
>>Tested with 2.6.11-rc2-Vanilla and 2.6.11-rc[234]+swsusp2.
>>When using setfont, screen goes blank. Power up after S3
>>returns console in 25 lines mode with 30 lines scroll. 
>>Several attempts - same result.
> 
> 
> So... screen goes blank even when suspend is not involved, right?
> Sounds like a bug to me ;-).
> 
> 
>>Another bug I see only on this HW and only with 2.6 is that
>>when - and only when - using gentoo emerge --usepackage in
>>text console, scroll area resets to _25_ when portage 
>>"dumps" the (binary) package contents which scrolls pretty
>>fast. I was unable to reproduce this in any other way. 
>>Tried also echo loop in bash but perhaps it is too slow
>>or not random enough. Note that 2.4.2[789] no problem.
> 
> 
> Well, dumping random stuff to console can produce funny results. I'd
> call that normal. Try cat /dev/urandom, that should be "enough
> random".
> 
> 								Pavel

I am also getting strange effects. I boot into  2.6.11-rc4 and the
console fonts looks fine. Come back a day later and the console font has
  corrupt characters. E.g. Displays a "D" instead of an "L" and stuff
like that. It is mostly readable, except for a few characters.
It is only the local console that is corrupted. ssh into the box
displays correct characters, so all I can assume is that the VGA console
is being programmed with different characters. The bad characters also
survive a soft reboot( During BIOS boot up), until the linux kernel
starts booting, and then it switches to a good font.

