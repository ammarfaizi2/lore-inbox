Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVCVTLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVCVTLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVCVTLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:11:39 -0500
Received: from av5-1-sn3.vrr.skanova.net ([81.228.9.113]:4323 "EHLO
	av5-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261661AbVCVTLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:11:16 -0500
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: touchpad dragging problem
References: <422618F0.3020508@telefonica.net>
	<20050321141049.5d804609.akpm@osdl.org>
	<423FE7C5.8080402@telefonica.net>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Mar 2005 20:11:10 +0100
In-Reply-To: <423FE7C5.8080402@telefonica.net>
Message-ID: <m3acovzeb5.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net> writes:

> Andrew Morton wrote:
> 
> >Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net> wrote:
> >
> >> I just compiled 2.6.11 from a 2.6.10 configuration for a desktop
> >> machine (with kernel preemption activated).
...
> >> Apart from the ALPS touchpad thing (see "2.6.11: touchpad
> >> unresponsive"), the new kernel keeps:
> >
> >You appear to have about five bugs here.  Do any of them remain in
> >2.6.12-rc1?
> >
> Well, one thing outstands: the synaptic touchpad is now really
> comfortable to use. Almost everything works, including simple and
> double clicks, and scrolling. Dragging is still broken. I must note
> I'm now using a synaptic Xinput driver, as suggested.

What parameter settings do you use in the X driver? If you have
SHMConfig enabled, you can run "synclient -l" to find out. Does
increasing MaxTapTime help?

> As for dragging, it was ok in 2.6.10 and previous, but currently
> broken.

Probably because 2.6.10 didn't have the kernel ALPS driver, so you got
whatever features the firmware emulates in its PS/2 compatibility
mode. With the kernel ALPS driver, the touchpad is put into "raw"
mode, so you instead get whatever features the kernel or the X driver
implements.

Andrew Morton <akpm@osdl.org> writes:
> Also, I'd consider it a regression that you had to go and find new X
> drivers due to a kernel change.  We shouldn't do that.

The problem is that mousedev.c doesn't implement "tap and drag"
emulation, so all Synaptics and ALPS touchpads that have firmware
support for dragging have seen a regression compared to a 2.4 kernel.
(For synaptics, the regression happened at ~2.5.7x, for ALPS it
happened at 2.6.11.)

The situation is the same with scroll emulation that some touchpads do
in firmware.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
