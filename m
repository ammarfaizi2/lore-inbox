Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUDCERk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDCERk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:17:40 -0500
Received: from smtp2.fuse.net ([216.68.8.172]:5112 "EHLO smtp2.fuse.net")
	by vger.kernel.org with ESMTP id S261576AbUDCERe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:17:34 -0500
From: "Ivica Ico Bukvic" <ico@fuse.net>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: "'A list for linux audio users'" 
	<linux-audio-user@music.columbia.edu>,
       <alsa-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus=distortion -- the sagacontinues (cardbus driver=culprit?) MORE UPDATE
Date: Fri, 2 Apr 2004 23:17:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQWLSJrWd4H2l+vT7KET0lXWqUIVgAXb5tQAKea+jA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-Id: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've tinkered even further with the stuff and I do have my lspci and other
logs (will post them shortly). I've tried now runnning card with the
external Word Clock -- the results are the same (distortion persists).

At this point what I know for a fact:

1) Soundcard is distorted no matter what app/framework (i.e. direct Alsa
access vs. Jack) I use in Linux
2) Likely culprit is either PCMCIA cardbus driver or the audio driver itself
3) External Word clock does not fix the issue
4) Changing sample rate does not fix the issue
5) Apparently sound has gaps that are comparable in size to the sound data
buffers (apparently 32 points)
6) I've updated BIOS and that did not fix it (yet the DSDT table is still
trashed on my notebook but that should not affect the operability of the
PCMCIA card -- see next point)
7) Tried using the card without ACPI and APIC and the IRQ was 11 together
with the cardbus as well as with ACPI (patched 2.6.3 kernel) and APIC,
having IRQ 17 for both the cardbus and the soundcard. Both sounded the same
(distorted). Using only APIC without ACPI fails to allocate proper IRQ to
cardbus (IRQ 0) resulting in failed modprobing of the soundcard.
8) In Win32, the card works fine on the same hardware and using the same IRQ
17 like in Linux, however, upon suspending/hibernating and resuming, the
soundcard produces a similar but different kind of distortion than in Linux
except when using 32000Hz sampling rate (???).
9) The color of the distortion changes in Linux when changing sampling rates
of the card on-the-fly (Will post the link to the sound shortly). The sound
plays slower and slower in Win32 when the distortion is present and higher
sampling rates are being used
10) RME has officially ok-ed my cardbus ENE CB1410 for use in Win32 since
they tested it in their labs and it worked ok (so all they talked about its
problems before is not true any more)
11) The throughput is not the issue since I stressed the card in Win32 and
it worked ok (16 outputs at 44100Hz sampling rate at 3ms latency is flawless
using Directx and Cool Edit Pro/Adobe Audacity, as well as 8 outputs at
96000Hz at 6ms latency using ASIO in Max/MSP).
12) Even after resuming in Win32 DirectX and MME drivers still work ok, it's
only that ASIO drivers crap-out.
13) At least one more person reported similar behavior as mine on RME-audio
news server
14) At least one more person has the same problem in Linux like me
15) Once I resume from hibernate/standby in Win32, successive disconnects
eventually result in weird stuff, even a BSOD.

Here is the additional info regarding my notebook:

Boot log using ACPI&APIC on 2.6.3 patched kernel that fixes IRQ
misallocation and freezes when inserting PCMCIA card:
http://meowing.ccm.uc.edu/~ico/eMachines/boot-with-acpi&apic.log

Boot log without using ACPI&APIC on the same kernel:
http://meowing.ccm.uc.edu/~ico/eMachines/boot-without-acpi&apic.log

Detailed view of the "distorted" sound that reveals 32-points of sound
followed by 32-points of silence:
http://meowing.ccm.uc.edu/~ico/eMachines/Distortion.jpg

Simple lspci output:
http://meowing.ccm.uc.edu/~ico/eMachines/lspci-simple.log


Complex lspci output (lspci -vvv)
http://meowing.ccm.uc.edu/~ico/eMachines/lspi-complex.log

Recorded sound with the aforementioned distortion (towards the end of it,
namely last second I actually change the sampling rate on-the-fly using
hdspconf)(WARNING: the sound is normalized at 50% but was recorded clipping,
so there is some artifacts just from the clipping, but they are simply an
addon on top of what is already wrong):
http://meowing.ccm.uc.edu/~ico/eMachines/test.wav (1.7MB)

TODO:
1) Log the Jack -R output (likely to be ridden with xrun's)
2) You tell me :-)

Any help is greatly appreciated!

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/



