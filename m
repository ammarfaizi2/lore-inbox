Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUKBUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUKBUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUKBUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:43:26 -0500
Received: from lax-gate7.raytheon.com ([199.46.200.238]:55130 "EHLO
	lax-gate7.raytheon.com") by vger.kernel.org with ESMTP
	id S261369AbUKBUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:43:18 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Tue, 2 Nov 2004 14:42:10 -0600
Message-ID: <OF8F6308EA.F9FADA81-ON86256F40.0071B981-86256F40.0071B9A6@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/02/2004 02:42:21 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hm, this one is an extremely weird deadlock - the NMI watchdog detected
>a _user-space_ deadlock - i.e. the "cpu_burn" user-space code disabled
>interrupts for more than ~5 seconds? Sounds quite unlikely and the
>EFLAGS register also directly contradicts it, it has 0x200 set so
>interrupts are enabled!

Very unlikely - cpu_burn.c (all of it...)

int main() {
  while (1) {  }
  return 1;
}

No - it did not disable interrupts.

>The only other way for the NMI watchdog to
>trigger is if for whatever reason the local APIC timer interrupts are
>not getting through and the NMI ticks (which come via a different
>interrupt pin) get through.

The other symptoms I was seeing appeared to be timer related
 - never returned from "sleep 1s" in the shell script
 - "ps -fe" worked fine, but "top" did not
You may be on to something here.

  --Mark

