Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbTGPIUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270329AbTGPIUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:20:06 -0400
Received: from mailb.telia.com ([194.22.194.6]:65514 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S266622AbTGPIUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:20:03 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad 2.6.0-test1 problem
References: <Pine.LNX.4.44.0307151809380.31633-100000@mooru.gurulabs.com>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jul 2003 09:16:54 +0200
In-Reply-To: <Pine.LNX.4.44.0307151809380.31633-100000@mooru.gurulabs.com>
Message-ID: <m2wuejvt3t.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> writes:

> I'm using XFree86-4.3.0-17, I have the synaptics XF86 0.11.3p6 driver 
> installed.
> 
> I have input, evdev, mousedev, psmouse in the kernel.
> 
> I get happy dmesg output when psmouse loads.
> 
> When X starts the cursor sits in the middle of the screen and won't move 
> when I touch the touchpad or the buttons.

Are you using the correct eventX device node? Look at
/proc/bus/input/devices to make sure. Verify from the console that you
get data from the device. Type

        cat /dev/input/eventX | od -x

access the touchpad and verify that some data is produced.

Your XF86Config file should have a section that looks something like
this:

Section "InputDevice"
	Identifier	"TouchPad"
	Driver	"synaptics"
	Option	"Device"	"/dev/input/event3"
	Option	"Protocol"	"event"
	Option	"SHMConfig"	"on"
EndSection

P.S. Auto-detection of the correct eventX device is under
construction, so pretty soon it will be much easier to set things up.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
