Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTJ0KKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 05:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTJ0KKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 05:10:47 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:41477 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261503AbTJ0KKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 05:10:45 -0500
Message-ID: <3F9CF169.3060802@aitel.hist.no>
Date: Mon, 27 Oct 2003 11:20:25 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [long] linux-2.6.0-test9, XFree86 4.2.1.1, ATI ATI Radeon VE
 QY, screen hangs on 3d apps
References: <3F9B8A6B.6030102@hundstad.net>
In-Reply-To: <3F9B8A6B.6030102@hundstad.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey E. Hundstad wrote:
> Hello,
> 
> I'm using Debian unstable.  It comes with XFree86 Vesrion 4.2.1.1.  This 
> works fine with linux-2.4.22.  I've been using this configuration with 
> accelerated 3d apps.  With linux-2.6.0-test9 X works fine until a 3d 
> application such as glxgears starts.  The screen no longer updates 
> except that you can move the cursor.  The logs do not indicate failure.  
> I can't get the screen back without a reboot.  I can connect via. the 
> network to do analysis if someone wants to give me a clue what to look for.
> 
Check all log files and dmesg, see if some driver (probably 3d drivers)
complaining about anything.  If so, tell the relevant developers.

You may also want to run "ps aux" and see if any apps (particulary
glxgears) is stuck in D state.

Finally, you may try to see if you can get the screen back without
a reboot using the network connection.
Try killing glxgears, or kill -9 if that doesn't help.
Try restarting X - use "kill" or "kill -9" if
it won't quit nicely.
Killing X and xdm (or gdm/kdm/whatever) may
force you to restart it manually.

> So once again:
> 
> XFree86 Vesrion 4.2.1.1
> linux-2.6.0-test9
> ATI Radeon VE QY rev 0

Oh, a radeon.  I have one too, using 3D kills my machine.
Developers thought I might have a "broken agp device"
or something like that.  You should definitely report
it to DRI developers, more independent reports on radeon failures with 2.6
might make things happen rather than this "maybe the hw is broken" theory.

Note that the debian 3d software is quite old.
consider adding this to tour /etc/apt/sources.list:
deb     http://people.debian.org/~daenzer/dri-trunk-sid/        ./

You may then apt-get install xlibmesa-gl1-dri-trunk xserver-xfree86-dri-trunk 
That will get you X 4.3 with the latest DRI software.  It may
work better, or it may not.  You can trivially go back
to your old setup by removing those two packages.
Note that xdm might fail with the experimental packages,
if so, start X using startx.

Helge Hafting

