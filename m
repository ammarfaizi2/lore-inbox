Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUFAKDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUFAKDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 06:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUFAKDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 06:03:13 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:15775 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264970AbUFAKDK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 06:03:10 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: BUG FIX: atkbd.c keyboard driver bug [Was: keyboard problem with 2.6.6]
References: <200406010904.i5194pSo010367@fire-2.osdl.org>
	<xb7iseb7gtv.fsf@savona.informatik.uni-freiburg.de>
	<20040601095518.GA1527@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 01 Jun 2004 12:03:09 +0200
In-Reply-To: <20040601095518.GA1527@ucw.cz>
Message-ID: <xb78yf77fz6.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    >>  Isn't the keyboard driver supposed to iron out such
    >> differences?

    Vojtech> The atkbd.c driver does exactly that. It hides the fact
    Vojtech> that there is a special scancode for the PrintScreen key,
    Vojtech> if you press it together with some other keys.

No,  it doesn't do  that.  I  press PrintScreen  (without Alt)  and it
tells the input system that it is a KEY_SYSRQ.



    Vojtech> It's a hack by IBM engineers, the PC/XT keyboard had a
    Vojtech> SysRq key, the PC/AT keyboard did not, yet some old DOS
    Vojtech> programs needed it, so they made the AT keyboard generate
    Vojtech> the keycode for alt-sysrq when running in XT
    Vojtech> compatibility mode.

It's a simple SysRq (0x54), not Alt-SysRq (0x38 0x54) in my notebook.


    Vojtech> Unfortunately, the XT compatibility mode stuck, and
    Vojtech> that's what we're using now.

I know this part of the history, and hence why PrintScreen is emulated
by Alt-KPAsterisk.


    Vojtech> The kernel works with real keys. There is no real sysrq
    Vojtech> key.

On my notebook, there IS a  real SysRq.  (The [Fn] part is not visible
to the kernel.  So, that's irrelevant.)



    Vojtech> Ok, it's probably a bad name for it, it should have been
    Vojtech> named KEY_PRTSCR, but it wasn't, and it'd only cause
    Vojtech> breakage now to change it.

Deprecate the old one.


    Vojtech> and is used for the PrtScr/SysRq key.
    >>  So, why not have seperate keycodes for the two?
 
    Vojtech> Because there is only one key.

On  some keyboards  (e.g.  my notebook),  they're  separate.  Is  that
enough a reason to have 2 different keycodes, then?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

