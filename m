Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269410AbUIYUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269410AbUIYUhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269411AbUIYUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 16:37:42 -0400
Received: from mail.aknet.ru ([217.67.122.194]:2568 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269410AbUIYUhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 16:37:36 -0400
Message-ID: <4155D7D2.8000705@aknet.ru>
Date: Sun, 26 Sep 2004 00:40:50 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz> <20040925080426.GB12901@iram.es> <415563C7.8000701@aknet.ru> <20040925191808.GA5901@iram.es>
In-Reply-To: <20040925191808.GA5901@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Gabriel Paubert wrote:
> Is ESP really properly restored for V86 bmode or is it that 
> it does not hit the case of a default 32 bit code segment with 
> a 16 bit stack?
It does not restore it in any case for the 16bit
stack (no matter whether the code is 16 or 32 in PM).
Petr says V86 is not affected, but I have not tested
that case because why to care? The problem is only for
the 32bit code. For 16bit code (PM or V86) it just
doesn't really matter I think (I don't think using
prefixes for ESP is sane).

> I'm absolutely amazed by the fact that this bug has been there
> since the beginning and only seems to hit users right now.
No, right now it just hits me:)
It used to hit the dosemu users always, but people just
blamed dosemu itself and that was it. Noone wanted
to spend weeks traceing the DOS programs under dosemu,
then traceing dosemu itself, then traceing kernel,
then looking through the docs to track the problem down
to something known, then writing to Intel's techsup for
clarifications, and then writing to LKML:) And if not
for the great help I got here, this will end up nowhere
again. So that's how it used to stay "unnoticed" for
years.
As for the other instances of that problem, here are some:

http://www.tenberry.com/dos4g/watcom/rn4gw.html
---
B ** Fixed the mouse32 handler to ignore a Microsoft Windows DOS box bug
     which mangles the high word of ESP.
---

http://clio.rice.edu/djgpp/r5bug04.txt
---
On VCPI servers which mode switch using ESP upper bits, CWSDPMI does not
clear those bits when swapping to it's own stack.
---

Searching google reveals quite a few implicit
instances of that problem.

> Anyway, I've just read again Intel's doc about mixing 16 and 32 bit 
> code and I have found the understament of the day:
> "For most efficient and trouble-free operation of the processor,
>                         ^^^^^^^^^^^^
What is to expect? They knew there are troubles,
yet decided to make it a part of the specs...

