Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVAERES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVAERES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVAERES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:04:18 -0500
Received: from math.ut.ee ([193.40.5.125]:30870 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261827AbVAEREP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:04:15 -0500
Date: Wed, 5 Jan 2005 19:04:13 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.9+ keyboard LED problem
Message-ID: <Pine.SOC.4.61.0501051856090.9146@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The input changes in 2.6.9 made keyboard LED setting unreliable. 2.6.8 
is OK, 2.6.9, 2.6.10 and todays BK are buggy.

The problem is that setting the LEDs now interferes with keyboard and 
ps/2 mouse input and makes the kernel lose key press and key release 
events.

Short demonstation:
#!/bin/sh
while :; do xset led 3; xset -led 3; sleep 0.01; done

This script works from X but the same effect can be seen on the console 
using setleds. The problem was found with ledcontrol package but is 
easyly reproduced with the script above.

Key press and release events are lost, mouse movement is lost or 
movement is converted into clicks or mouse loses sync (by dmesg info). 
There are also messages like
atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
in dmesg.

Don't try the script without the sleep command unless you have a network 
connection to log in and kill the script ;)

-- 
Meelis Roos (mroos@linux.ee)
