Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBOFcA>; Thu, 15 Feb 2001 00:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRBOFbu>; Thu, 15 Feb 2001 00:31:50 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:53522 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S129170AbRBOFbl>; Thu, 15 Feb 2001 00:31:41 -0500
Date: Thu, 15 Feb 2001 00:31:37 -0500 (EST)
From: Ivan Borissov Ganev <ganev@cc.gatech.edu>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Pavel Machek <pavel@suse.cz>,
        Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.[01] lockups
In-Reply-To: <20010212152339.A11083@niksula.cs.hut.fi>
Message-ID: <Pine.SOL.4.21.0102150022360.12309-100000@tuomotu.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, Pavel Machek wrote:

> Login via network or serial cable, and see if /proc/interrupts entry
> for keyboard/mouse changes as you type. Attempt to blink keyboard leds
> with setleds.
> 								Pavel

On Mon, 12 Feb 2001, Ville Herva wrote:

> Also, try killing gpm.
> -- v --

Hello,

Thanks for the suggestions. Due to lack of a terminal or second computer
I've had no chance still to try the above suggestions. However, I have
tried many different versions of the 2.4.X series to no avail. I tried to
compile out APIC/IO-APIC stuff, I tried Alan's ac9 patches, etc.

However, I recently noticed that most times the console freezes when I am
doing a filename completion (which involves a beep when the completion is
not unique in KDE). I have changed the beep to be much shorter and with
much less annoying pitch from the KDE control panel.

I have found out that going in the control panel and just clicking the
"Test" button to test out the beep would freeze the console in less than
10-15 tries.

I got the sources for "kcontrol" and it seems the beeping is done from
some function of the keyboard driver, although I do not understand KDE
much and have no idea how to continue tracing the bug further.

Currently I have set the pitch to 0 Hz (no beeping) and have not had a
lockup yet. I will continue testing, however, if someone can give me a
suggestion how to go about tracing the code that actually does the
beeping (be it in KDE or the kernel) I'd be very grateful.

Cheers,
--Ivan

P.S. The relevant code from kdebase-2.0.1/kcontrol/bell/bell.cpp is:

void KBellConfig::ringBell()
{
  // store the old state
  XKeyboardState old_state;
  XGetKeyboardControl(kapp->getDisplay(), &old_state);

  // switch to the test state
  XKeyboardControl kbd;
  kbd.bell_percent = m_volume->value();
  kbd.bell_pitch = m_pitch->value();
  if (m_volume->value() > 0)
    kbd.bell_duration = m_duration->value();
  else
    kbd.bell_duration = 0;
  XChangeKeyboardControl(kapp->getDisplay(),
                         KBBellPercent | KBBellPitch | KBBellDuration,
                         &kbd);
  // ring bell
  XBell(kapp->getDisplay(),100);

  // restore old state
  kbd.bell_percent = old_state.bell_percent;
  kbd.bell_pitch = old_state.bell_pitch;
  kbd.bell_duration = old_state.bell_duration;
  XChangeKeyboardControl(kapp->getDisplay(),
                         KBBellPercent | KBBellPitch | KBBellDuration,
                         &kbd);
}




------------------------------------------------------------------------------
        Ivan Ganev                           327236 Georgia Tech Station
   College of Computing                           Atlanta,  GA 30332
Georgia Institute of Technology                    1-(404)-365-8694
    ganev@cc.gatech.edu                     http://www.cc.gatech.edu/~ganev     
------------------------------------------------------------------------------
             Learning is not compulsory. Neither is survival.
                        -- W. Edwards Deming

