Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTJ0Xrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTJ0Xrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:47:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32019 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263766AbTJ0Xrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:47:51 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test9
Date: 27 Oct 2003 23:37:37 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnka81$m2n$1@gatekeeper.tmr.com>
References: <UTC200310261059.h9QAxBS13289.aeb@smtp.cwi.nl>
X-Trace: gatekeeper.tmr.com 1067297857 22615 192.168.12.62 (27 Oct 2003 23:37:37 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <UTC200310261059.h9QAxBS13289.aeb@smtp.cwi.nl>,
 <Andries.Brouwer@cwi.nl> wrote:
| > Pls forward.
| 
| Below a keyboard patch I sent to l-k 12 days ago.
| Discussion:
| 
| Petr Vandrovec reported
| 
| > got (twice, but yesterday I rebooted box hard, as I thought that it is dead)
| > strange lockup, where box stopped reacting on keyboard.
| 
| and
| 
| > Oct 14 19:59:18 ppc kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115341]
| > Oct 14 19:59:18 ppc kernel: i8042.c: ed -> i8042 (kbd-data) [30115342]
| > Oct 14 19:59:18 ppc kernel: i8042.c: fa <- i8042 (interrupt, kbd, 1) [30115346]
| > Oct 14 19:59:18 ppc kernel: atkbd.c: Unknown key released (translated set 2, code 0x165, data 0xfa, on isa0060/serio0).
| 
| What happens is that the kernel code does an untranslate on the 0xfa
| that is the ACK for 0xed (set LEDs) when 0xe0 preceded. Now the ACK
| is never seen and we hang waiting for it.
| 
| Now 0xfa can be a key scancode or it can be a protocol scancode.
| Only few keyboards use it as a key scancode, and if we always
| interpret it as a protocol scancode then these rare keyboards
| will have a dead key. If we interpret it as a key scancode then
| we have a dead keyboard in case it was protocol.
| 
| The below patch moves the test for ACK and NAK up, so that they
| are always seen as protocol.
| 
| This is just a minimal patch. What I did in 1.1.54 was to keep track of
| commands sent with a flag reply_expected, so that 0xfa could be taken
| as ACK when a reply is expected and as key scancode otherwise.
| That is the better solution, but requires larger surgery.

I would think that knowing when a reply was coming was very desirable, a
keyboard with dead keys is kind of useless if an application uses them
(like any editor which allows function to keystroke binding).

Since you have done the full fix already, is it practical to do it
quickly now? And how does any fix for this map into "really major
bugs?" If the fix is just going to be queued anyway, it might as well
be done really right, assuming that you have the time and inclination,
of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
