Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUGOUzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUGOUzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUGOUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:55:17 -0400
Received: from scrye.com ([216.17.180.1]:6375 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S266304AbUGOUzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:55:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Jul 2004 14:54:55 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: psmouse as module with suspend/resume
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20040715205459.197177253D@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings. 

I am having a bit of an issue with psmouse and suspend/resume. 
I am using the swsusp2, which is working great... (Thanks Nigel!)

However: 

If I compile psmouse as a module and leave it in and suspend/resume
when the laptop comes back the mouse doesn't work at all. 

If I compile psmouse as a module and unload before suspend, and reload
after resume, the mouse works for simple movement, but all the
advanced synaptics features no longer work. No tap for mouse button,
no scolling, etc. 

If I compile psmouse in everything works after a suspend/resume cycle.

I would like to be able to compile psmouse as a module. Does anyone
see any reason the synaptics stuff wouldn't work after a
unload/reload? 

Before a suspend/resume: 

kernel: Synaptics Touchpad, model: 1
kernel:  Firmware: 5.9
kernel:  Sensor: 51
kernel:  new absolute packet format
kernel:  Touchpad has extended capability bits
kernel:  -> 4 multi-buttons, i.e. besides standard buttons
kernel:  -> multifinger detection
kernel:  -> palm detection
kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4

Afer a unload and reload:

kernel: Synaptics Touchpad, model: 1
kernel:  Firmware: 5.9
kernel:  Sensor: 51
kernel:  new absolute packet format
kernel:  Touchpad has extended capability bits
kernel:  -> 4 multi-buttons, i.e. besides standard buttons
kernel:  -> multifinger detection
kernel:  -> palm detection
kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4

So, it all looks the same there. 
I wonder if it's not something with the input layer not reconnecting
right on reload with what the synaptics driver in X is expecting... 

In the X log after a resume/reload: 

(II) DevInputMice: ps2EnableDataReporting: succeeded
Synaptics DeviceOn called
(EE) xf86OpenSerial: Cannot open device /dev/input/event2
        No such device.
(WW) Mouse0: cannot open input device

Any ideas?
Happy to provde more information on versions, etc...

thanks,

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFA9u8i3imCezTjY0ERAmWnAJ9uKMauJAfSMKgz9VBB6Z5o7/66vACffKg5
8Imj27a19cu4OtVuhaszXOM=
=6i7m
-----END PGP SIGNATURE-----
