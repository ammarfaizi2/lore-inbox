Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTISUaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTISUaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:30:07 -0400
Received: from screech.rychter.com ([212.87.11.114]:16028 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S261711AbTISUaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:30:02 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
References: <m2znh1pj5z.fsf@tnuctip.rychter.com>
	<20030919190628.GI6624@kroah.com> <m2d6dwr3k8.fsf@tnuctip.rychter.com>
	<20030919201751.GA7101@kroah.com>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Fri, 19 Sep 2003 13:29:55 -0700
In-Reply-To: <20030919201751.GA7101@kroah.com> (Greg KH's message of "Fri,
 19 Sep 2003 13:17:52 -0700")
Message-ID: <m28yokr070.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
 Greg> On Fri, Sep 19, 2003 at 12:17:11PM -0700, Jan Rychter wrote:
 > "Greg" == Greg KH <greg@kroah.com> writes:
 Greg> On Thu, Sep 18, 2003 at 08:10:48PM -0700, Jan Rychter wrote:
 > Upon disconnecting an USB mouse from a 2.4.22, I get
 >
 > uhci.c: efe0: host controller halted. very bad
 >
 > and subsequently, the machine keeps on spinning in ACPI C2 state,
 > never going into C3, as it should (since the mouse is the only USB
 > device).
 >
 > If afterwards I do 'rmmod uhci; modprobe uhci', then the machine
 > starts using the C3 state again.
 >>
 Greg> If you use the usb-uhci driver, does it also do this?
 >>
 >> If you mean strange messages, no, it doesn't. Using usb-uhci it just
 >> says "USB disconnect..." and everything looks fine.
 >>
 >> As to C-states, usb-uhci prevents Linux from *ever* entering C3,
 >> being effectively unusable on some laptops -- so there is no way I
 >> can see the same symptoms with it.

 Greg> If you want to suspend using 2.4, unload the usb drivers
 Greg> entirely.  That's the only safe way.

I wasn't talking about suspending, but about processor C-states. These
are power states that the mobile processors enter dynamically, many
times a second. In my case:

[10:52] tnuctip:/usr/src/linux#cat /proc/acpi/processor/CPU0/power 
active state:            C3
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000520]
    C2:                  promotion[C3] demotion[C1] latency[001] usage[00159073]
   *C3:                  promotion[--] demotion[C2] latency[100] usage[02297764]
[13:28] tnuctip:/usr/src/linux#

As you can see, C3 (lowest power) is being used a lot. This makes my
laptop run cool. If I use usb-uhci, the processor is never able to go
into C3 because of DMA activity. uhci is better, because it at least
permits me to use C3 when there are no devices plugged in.

And going back to the uhci problem... ?

--J.
