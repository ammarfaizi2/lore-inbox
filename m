Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285591AbRLRF7a>; Tue, 18 Dec 2001 00:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285604AbRLRF7V>; Tue, 18 Dec 2001 00:59:21 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31764 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S285591AbRLRF7N>; Tue, 18 Dec 2001 00:59:13 -0500
Date: Tue, 18 Dec 2001 11:29:33 +0530 (IST)
Message-Id: <200112180559.LAA17960@vxindia.veritas.com>
From: ganesh@vxindia.veritas.com (V Ganesh)
To: linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com
Subject: Re: Scheduler ( was: Just a second ) ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011217205547.C821@holomorphy.com> you wrote:
: On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
:> The most likely cause is simply waking up after each sound interrupt: you
:> also have a _lot_ of time handling interrupts. Quite frankly, web surfing
:> and mp3 playing simply shouldn't use any noticeable amounts of CPU.

: I think we have a winner:
: /proc/interrupts
: ------------------------------------------------
:            CPU0
:   0:   17321824          XT-PIC  timer
:   1:          4          XT-PIC  keyboard
:   2:          0          XT-PIC  cascade
:   5:   46490271          XT-PIC  soundblaster
:   9:     400232          XT-PIC  usb-ohci, eth0, eth1
:  11:     939150          XT-PIC  aic7xxx, aic7xxx
:  14:         13          XT-PIC  ide0

: Approximately 4 times more often than the timer interrupt.
: That's not nice...

a bit offtopic, but the reason why there are so many interrupts is
that there's probably something like esd running. I've observed that idle
esd manages to generate tons of interrupts, although an strace of esd
reveals it stuck in a select(). probably one of the ioctls it issued
earlier is causing the driver to continuously read/write to the device.
the interrupts stop as soon as you kill esd.

: SoundBlaster 16
: A change of hardware should help verify this.

it happens even with cs4232 (redhat 7.2, 2.4.7-10smp), so I doubt it's
a soundblaster issue.

ganesh
