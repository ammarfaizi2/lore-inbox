Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTL0SMN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 13:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTL0SMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 13:12:13 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:1196 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264522AbTL0SMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 13:12:06 -0500
Date: Sat, 27 Dec 2003 19:11:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics problems in -mm1
Message-ID: <20031227181120.GC10491@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <200312250414.58598.dtor_core@ameritech.net> <20031227113848.GA10491@louise.pinerecords.com> <200312271228.59192.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312271228.59192.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-27 2003, Sat, 12:28 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> > it seems one of the synaptics-related patches in 2.6.0-mm1 kills
> > off the pointer stick on my T40p.  2.6.0 vanilla works just fine
> > in that department.  Thought you might want to know.

...

> I have a couple of questions (I am not familiar with IBM hardware so
> please bear with me...):

No problem.

There are two pointer controllers on the T40p: a stick and a pad.
With 2.6.0, just compiling in synaptics support and running gpm as
"gpm -t ps2 -m /dev/psaux" or XFree with

  Option          "Protocol"      "PS/2"
  Option          "Device"        "/dev/psaux"

gives perfect results, both controllers work, even with
all the (3 + 2) buttons.

With 2.6.0-mm1 (the same .config of course), however, the stick does nothing.

> - Is it detected as Synaptics but does not work?

Yes.

> - Should it be detected as Synaptics?

I believe so.

> - Does it work if you pass psmouse_noext=1 or psmouse_proto=bare?

psmouse_noext=1				no change
psmouse_proto=bare			no change

>   And what about psmouse_proto=imps and psmouse_proto=exps

psmouse_proto=imps			no change
psmouse_proto=exps			no change

> - Does it work if you give 2.6.0-test10-mm1 a quick boot?

Hmmm, let's see.
[time passes]

-> No.

Linux version 2.6.0-test10-mm1 (kala@ns) (gcc version 3.3.2) #1 Sat Dec 27 18:59:17 CET 2003
...
mice: PS/2 mouse device common for all mice
input: PC Speaker
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0

> - dmesg, input section of you XFree and version and parameters that
>   are passed to GPM.

Working kernel dmesg:

Linux version 2.6.0 (kala@ns) (gcc version 2.95.3 20010315 (release)) #1 Sat Dec 27 18:59:59 CET 2003
...
mice: PS/2 mouse device common for all mice
input: PC Speaker
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0

Broken kernel dmesg:

Linux version 2.6.0-mm1 (kala@ns) (gcc version 3.3.2) #1 Sat Dec 27 14:12:13 CET 2003
...
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
...
psmouse.c: TouchPad at isa0060/serio1/input0 lost synchronization, throwing 5 bytes away.

gpm is 1.19.6.
XFree is 4.3.0.
gpm parameters & XFree input config - see above.

-- 
Tomas Szepe <szepe@pinerecords.com>
