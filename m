Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTHKB5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 21:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTHKB5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 21:57:10 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:7063 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270859AbTHKB5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 21:57:05 -0400
Date: Sun, 10 Aug 2003 18:56:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: dhruba@codewordt.co.uk
Subject: [Bug 1072] New: Laptop touchpad does not work; synaptics driver missing 
Message-ID: <63670000.1060566994@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1072

           Summary: Laptop touchpad does not work; synaptics driver missing
    Kernel Version: 2.6.0-test3
            Status: NEW
          Severity: high
             Owner: vojtech@suse.cz
         Submitter: dhruba@codewordt.co.uk


Distribution: Gentoo GNU/Linux
Hardware Environment: Dell Inspiron 8100
Software Environment: XFree 4.3.0
Problem Description: Laptop touchpad does not work; synaptics driver missing

Steps to reproduce: Configure kernel, compile and boot off kernel.  Touch pad
won't work.

Description:

If you configure the kernel by including all options necessary for your laptop
and boot off it the touchpad on your laptop will not work.  I had to do
additionally the following in order to get it to work.

(1) visit and read http://w1.894.telia.com/~u89404340/touchpad/
(2) wget http://w1.894.telia.com/~u89404340/touchpad/synaptics-0.11.3p11.tar.bz2
-P ~
(3) tar -xvjf ~/synaptics-0.11.3p11.tar.bz2
(4) cp synaptics/synaptics_drv.o /usr/X11R6/lib/modules/input/
(5) modify /etc/X11/XF86Config-4 to replace existing InputDevice section with
text below.

Section "InputDevice"
    Identifier  "Mouse0"
    Driver      "synaptics"
    Option      "Device"       "/dev/input/event0"
    Option      "Protocol"     "event"
    Option      "LeftEdge"     "1900"
    Option      "RightEdge"    "5400"
    Option      "BottomEdge"   "1800"
    Option      "TopEdge"      "3900"
    Option      "FingerLow"    "25"
    Option      "FingerHigh"   "30"
    Option      "MaxTapTime"   "180"
    Option      "MaxTapMove"   "220"
    Option      "VertScrollDelta" "100"
    Option      "MinSpeed"     "0.02"
    Option      "MaxSpeed"     "0.18"
    Option      "AccelFactor"  "0.0010"
# Option   "Emulate3Buttons"   "on"
# Option   "Repeater"          "/dev/ps2mouse"
# Option   "SHMConfig"         "on"
EndSection

(6) restart xfree server

Instead of this six step procedure can this be made into a one step procedure of
simply enabling an option in the kernel?  There are literally hundreds of users
who are experiencing this same problem in the Gentoo Linux community and as a
result one of them took the initiative to write a small how-to [1] summarised
above by myself.

[1] http://forums.gentoo.org/viewtopic.php?t=67852

I'd be very grateful if this could be incorporated into the kernel and automated
for ease and convenience.  If you require any further information or wish to
discuss this further please let me know.  Also, below are certain error messages
about synaptics found in dmesg.

$ dmesg | grep synaptics
synaptics reset failed
synaptics reset failed
synaptics reset failed

I will also attach the entire output of dmesg for reference.  Many thanks.


