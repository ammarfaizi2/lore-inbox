Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUDLH2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 03:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDLH2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 03:28:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11539 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261252AbUDLH2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 03:28:08 -0400
Date: Mon, 12 Apr 2004 08:28:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: daniel.ritz@gmx.ch, "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Message-ID: <20040412082801.A3972@flint.arm.linux.org.uk>
Mail-Followup-To: Ivica Ico Bukvic <ico@fuse.net>, daniel.ritz@gmx.ch,
	'Tim Blechmann' <TimBlechmann@gmx.net>,
	'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org,
	linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200404120145.22679.daniel.ritz@gmx.ch> <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>; from ico@fuse.net on Sun, Apr 11, 2004 at 09:39:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 09:39:43PM -0400, Ivica Ico Bukvic wrote:
> Hi all! Great news! I managed to fix the issue in Linux. As I suspected it
> was the same problem like in Windows after suspend as the distortion was
> similar.

Don't think the problem is 100% solved just yet - there's still work
to do.

You haven't said which kernel version you're using to test this out
on; 2.6.5 contains some fixes for the CB1410 in these areas, and it
would be useful to know if these are working.

So, as per my previous mail and at risk of sounding like a stuck
record^wCD, which kernel version are you using for this test?

Have you also tried only changing a limited subset of these
registers?  The reason this is important is that just immitating
the working scenario out right doesn't really tell us very much.

You should be able to tweak these while the card is playing, so
you could try setting them all to the "working" state, play back
the audio, and then try undoing each change individually.

> 2) PREFERRED: hdsp driver needs to adjust the cardbus controller latency

No.  Drivers should not fiddle with other parts of the system they
don't own, and the HDSP driver does not own the cardbus controller.
I suspect that the CB1410 quirk needs to force the latency timer at
startup.

> 3) FOR FURTHER INVESTIGATION: Does linux hdsp driver force the f0 value upon
> the 0x81 register or is it that in Linux one simply cannot select d0 value
> for whatever reason

I suspect it may be caused by using a byte access to a longword-sized
register.  0x81 is supposed to be accessed via:

setpci -s a.0 0x80.l

which of course means its bits 8 to 15.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
