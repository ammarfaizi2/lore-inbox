Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTJ1T0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJ1T0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:26:16 -0500
Received: from host217-37-214-121.in-addr.btopenworld.com ([217.37.214.121]:61563
	"HELO filmlight.ltd.uk") by vger.kernel.org with SMTP
	id S261614AbTJ1T0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:26:13 -0500
Message-ID: <3F9EC2D1.1050707@filmlight.ltd.uk>
Date: Tue, 28 Oct 2003 19:26:09 +0000
From: Christopher Fraser <chrisf@filmlight.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mouse and keyboard problems with 2.6.0-test9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having mouse and keyboard problems with kernels since 
2.6.0-test6 (at least).  The machine I'm testign with has a Supermicro 
X5DA8 (Intel E7507 chipset) motherboard with two 3Ghz Xeon CPUs and was 
install with Red Hat 9 and updates modutils, kinitrd etc.

When doing large amounts of I/O (we're reading > 300MB/s from disk, 
processing it and downloading it across AGP) while running XFree86 the 
psmouse gets into a state where it loses synchronisation and cannot 
recover. The pointer warps to the top right of the desktop and moving 
the mouse generates spurious mouse down events.  Switching to a virtual 
console and back to the X desktop sometimes recovers, but usually not. 

I've tried the psmouse_noext option, various rates including 200 (which 
seemed to make things better for a while) and the recent psmouse_rate 
with the rate to 0 without success.  I've also tried a generic Dell 
wheelmouse and and one of those optical Microsoft Intellimouse things.

The keyboard problem is that atkbd.c gets into a state where it starts 
generating message like the following for each key press:

Unknown key pressed (translated set 2, code 0x0, data 0x0, on 
isa0060/serio0)

These flood the console, making the machine difficult to use.  This 
mostly happens when I switch between XFree86 and virtual consoles, so it 
may be due to my generic PS2 keyboard generating spurious release events 
(as mentioned previously 
<http://www.ussg.iu.edu/hypermail/linux/kernel/0309.1/2185.html>).  
Commenting out the warning in atkdb.c makes the console usable again.

Any suggestions on things to try would be greatfully appreciated.

Regards,

Christopher.

