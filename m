Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUDLOll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUDLOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:41:41 -0400
Received: from smtp1.fuse.net ([216.68.8.171]:51091 "EHLO smtp1.fuse.net")
	by vger.kernel.org with ESMTP id S262956AbUDLOlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:41:05 -0400
From: "Ivica Ico Bukvic" <ico@fuse.net>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: <daniel.ritz@gmx.ch>, "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, <ccheney@debian.org>,
       <linux-pcmcia@lists.infradead.org>, <alsa-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 10:40:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQgX7TEqHS57mLtSqe5Euc4Om7fGAAPGFww
In-Reply-To: <20040412082801.A3972@flint.arm.linux.org.uk>
Message-Id: <20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't think the problem is 100% solved just yet - there's still work
> to do.
> 
> You haven't said which kernel version you're using to test this out
> on; 2.6.5 contains some fixes for the CB1410 in these areas, and it
> would be useful to know if these are working.
> 
> So, as per my previous mail and at risk of sounding like a stuck
> record^wCD, which kernel version are you using for this test?

Sorry :-) Mandrake Community 10.0 using the 2.6.3 kernel with a patch to fix
the freezing when probing for the pcmcia card on this particular notebook
(see: http://www.muru.com/linux/amd64/).
 
> Have you also tried only changing a limited subset of these
> registers?  The reason this is important is that just immitating
> the working scenario out right doesn't really tell us very much.

Tried various combinations in Windows and only using the 2 in combination
worked. I will test further in Linux if you like when I get the chance. But
as of right now I have a hunch that the same behavior will be observed in
Linux as one value enables burst stuff, while the other value when changed
also introduced distortion (micro-silence between buffers) in Windows if any
other value was used than 0x04.

> You should be able to tweak these while the card is playing, so
> you could try setting them all to the "working" state, play back
> the audio, and then try undoing each change individually.

Will do. I did that with the latency and it still worked for the
before-mentioned reasons but the preferred behavior would be having it at
0xff as that is how the Win driver behaves. However, changing the latency
on-the-fly while JACK audio server and audio is running results in corrupted
audio and JACK needs to be restarted (this is most likely issue with the
fact I was using JACK).

> > 2) PREFERRED: hdsp driver needs to adjust the cardbus controller latency
> 
> No.  Drivers should not fiddle with other parts of the system they
> don't own, and the HDSP driver does not own the cardbus controller.
> I suspect that the CB1410 quirk needs to force the latency timer at
> startup.

Well, in Windows the latency on the controller is 0x20 and then when the
cardbus soundcard (RME) is inserted it is changed into 0xFF. Matthias, the
support guy from RME also confirmed this behavior (that their driver is
changing the value upon connection).
 
> > 3) FOR FURTHER INVESTIGATION: Does linux hdsp driver force the f0 value
> upon
> > the 0x81 register or is it that in Linux one simply cannot select d0
> value
> > for whatever reason
> 
> I suspect it may be caused by using a byte access to a longword-sized
> register.  0x81 is supposed to be accessed via:
> 
> setpci -s a.0 0x80.l
> 
> which of course means its bits 8 to 15.

Sounds like that was most likely it. I will test it as soon as I get the
chance to do so.

Thank you very much for all your help!

Best wishes,

Ico



