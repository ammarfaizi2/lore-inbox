Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUIZSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUIZSBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUIZSBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 14:01:34 -0400
Received: from mail.aknet.ru ([217.67.122.194]:64785 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261405AbUIZSB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 14:01:26 -0400
Message-ID: <415704C7.60704@aknet.ru>
Date: Sun, 26 Sep 2004 22:04:55 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz> <20040925080426.GB12901@iram.es> <415563C7.8000701@aknet.ru> <20040925191808.GA5901@iram.es> <4155D7D2.8000705@aknet.ru> <20040925234214.GA10603@iram.es>
In-Reply-To: <20040925234214.GA10603@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Gabriel Paubert wrote:
>> the 32bit code. For 16bit code (PM or V86) it just
>> doesn't really matter I think (I don't think using
>> prefixes for ESP is sane).
> Well, thrashing a register at any time under the user
> just because an interrupt happened is even less sane ;-)
OK, I agree, so I tested that: wrote some value
to the higher word of ESP in the struct that
dosemu passes to vm86() syscall, let the prog
to run for a while, and the value was still there.
It is not 100% reliable test because I can't
guarantee the vm86() was interrupted during the
period I was waiting (because vm86() is executed
for the short durations, then exits on fault or
signal), but it looks OK and why not to beleive
Petr that v86 is not affected.

>> http://www.tenberry.com/dos4g/watcom/rn4gw.html
>> ---
>> B ** Fixed the mouse32 handler to ignore a Microsoft Windows DOS box bug
>>     which mangles the high word of ESP.
> But if the bug is also affects Windows DOS box, it means that
> V86 is affected too, no? 
No. This URL is about dos4gw, so that's about a
prot. mode either.

> I'd like to know what OS/2 did.
AFAIK also WinNT is not affected. Not sure though.

> The DOS boxes and 16 bit mode
> DPMI applications ran very well and it was very stable, despite
Hey. It is not about 16bit DPMI mode, it is
about the 32bit DPMI mode. That's the whole
problem. Be it only about the 16bit DPMI mode,
the problem may not ever harm anything at all.
But for 32bit mode that's quite a problem.

