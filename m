Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbUANOzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUANOzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:55:25 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:47111 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S266346AbUANOzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:55:16 -0500
Message-ID: <1074092127.4005585fbe41d@imp.gcu.info>
Date: Wed, 14 Jan 2004 15:55:27 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH 2.4] i2c cleanups, third wave
References: <20040111144214.7a6a4e59.khali@linux-fr.org> <Pine.LNX.4.58L.0401141052590.6737@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0401141052590.6737@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

> From what I understand all patches are cleanups except the bus
> scanning removal (which fixes a problem on ThinkPad?).
> 
> I want to merge only bug fixes or practical corrections.
> 
> Please correct me if I overlooked the patches and they contain bug
> fixes.

Here is a summary of what each patch does (with the focus set on bug
fix
vs. cleanups), so that you can decide what you want to merge.

(1/8) One dependency fixed (problem was reported at least once), one
typo fixed. The rest is about layout and can be ignored.

(2/8) Can't be called a bug fix because the code is commented for now,
but it would not compile if it were restored. You decide.

(3/8) Bus scanning is known to be possibly harmful, although no problem
was reported with these specific modules. Long story short, the
Thinkpad syndrom is that bus scanning PIIX4 busses where 24RF08
chipsets live (which is the case of many Thinkpads) with our
sensors-detect script used to break them until we could find a subtle
fix. As a consequence, our policy and recommendation is that bus
scanning should be avoided. But there was no problem reported so far
with these specific modules. So, once again you decide.

(4/8) Two makefile bug fixes and one bad include fix. The part that
affects i2c-old.h and a large part that affects Makefile are cleanups
that you can ignore.

(5/8) This one is more about code readability/maintainability, but
still fixes a bogus error message, and, more importantly, a potential
buffer overrun. At least the potential buffer overrun should be fixed.

(6/8) Cleanups only, can be discarded.

(7/8) Cleanups only, can be discarded.

(8/8) Missing spaces in an error message. You decide.

Now, a few personal comments:

1* I can submit "light" versions of the patches that only contain the
parts you want, just tell me what they are.

2* There is nothing in these patches that I would consider dangerous,
which admitedly wasn't the case with the previous wave. With a bit more
experience, I wouldn't have submitted patch (3/5) (locks) in the
previous wave. For this wave, If I were to decide, according to your
"nothing dangerous" concerns, I'd discard patches 6 and 7, keep only
the fixes from 4 and 5, and keep 1, 2, 3 and 8. If you really insist so
that only bugs are fixed, this mean one item in 1, a few in 4 and one
in 5. Again, you decide.

3* This was obviously the last wave of patches I submitted, since we're
reaching (or more likely have already reached) the point of
maintainance only for the 2.4 kernel. I'll of course continue to do my
job as the i2c subsystem maintainer and provide fixes to any critial
bug that would be discovered.

Hopefully this will let you decide what you want to be done.

Thanks,
Jean

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

