Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVEGUX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVEGUX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVEGUX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 16:23:26 -0400
Received: from open.hands.com ([195.224.53.39]:18070 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S262751AbVEGUXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 16:23:19 -0400
Date: Sat, 7 May 2005 21:32:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: disabling "double-calling" of level-driven interrupts
Message-ID: <20050507203212.GG17194@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, please respond cc direct, thank you.

a kind response from alan alerted me to investigate some issues
that we are having with the skyminder (arm 720 cirrus logic
"maverick" EDB7134 whatever).

something he said made me go "twitch" - the infrastructure involving
interrupts in the 2.6 kernel - that they can be called TWICE.

well, that's exactly what i am seeing happen - even when the
relevant INTSR1 bit is clear.

at the top of the interrupt service routine, i double-check the
bit of INTSR1 that caused the interrupt.

i find it to be clear.

doing an immediate return IRQ_HANDLED results in working code,
whereas before, the behaviour of our LCD was utterly unreliable.

[we have a communications protocol to a PIC, over the 8-bit port,
indicating where and what the PIC is to blop onto the LCD screen.
the protocol is variable-length-encoded: if it gets screwed,
for example by a double-interrupt adding in an extra character...]

so.

i have some questions.

1) _why_ am i getting double-interrupts, even under circumstances
   where i double-check the relevant INTSR1 bit and ONLY drop out
   of the interrupt service routine once that bit is cleared?

2) is there something i am supposed to do, some function i
   am supposed to call, which stops the interrupt handler from
   being double-called?

3) could i have got something wrong, is there some interrupt
   function i am supposed to write, which is _supposed_ to check
   for this condition?

4) could there be something missing from the CLPS711x irq.c which
   is supposed to be there?

5) other

many thanks for any assistance.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
