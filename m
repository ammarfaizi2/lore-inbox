Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUCCBvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 20:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUCCBvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 20:51:38 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:40862
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262319AbUCCBvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 20:51:36 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-Id: <E1AyLZM-0001nT-00@penngrove.fdns.net>
Date: Tue, 02 Mar 2004 17:53:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    USB UHCI driver could be a fine example of a regression -- it could survive
    suspend in 2.4 under certain conditions, this is no longer true for 2.6.

I would agree with you about the UHCI for 2.6.0, but i've seen improvement 
since then.  At this point (vanilla 2.6.3), the non-module version of the 
UHCI is not only able to suspend, but it can even resume a digital camera'
('usb-storage'), which was something that i didn't expect.  I tried to make 
the module version work under 2.6.1-rc1, but i didn't get very far.  I could
get it to come up without major complaints, but could not get it to retain 
any connections.  That may be fine for an HID device, but not much good for 
a file-oriented device.  It really isn't much better than rmmod'ing just
before suspending (as the effect is the same).

Surprisingly enough, under 2.6.3, even the PCMCIA IDE card came back up
after hibernation, albeit with a few minor complaints.  So in some ways,
the current version may be better if one doesn't need certain modules to 
work.

As far as CONFIG_PM_DISK vs. CONFIG_SOFTWARE_SUSPEND, i'm not sure what to
say, except that 'echo 4b > /proc/acpi/sleep' mostly works for me, while
'echo -n disk > /sys/power/state' returns without successfully hibernating
(and has done that for the last several kernel versions i've tried).

I have not had much luck with X, as the only thing that manages to survive
suspend is VESA running 256 colors (and the version under 2.6.3 doesn't end
up with enough left over to run a web browser effectively).  With a 2.4.22
kernel and recent software suspend patch (2.0-rc2), the native driver for 
a Sony R505EL almost works, but again, only if i use 256 colors and switch
away to suspend (and then i still need to restart 'gpm' after suspending).
I need to have it suspend when it's running on batteries and i've left the
room (or otherwise forgotten about things), so this isn't very acceptable.

So software suspend under 2.4 might be better, it doesn't really answer my
problems.  So i still feel stuck with Windows when i'm not at home.

				-- JM
