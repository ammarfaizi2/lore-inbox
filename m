Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbTISEqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 00:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTISEqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 00:46:35 -0400
Received: from caipirinha.heise.de ([193.99.145.36]:33512 "EHLO
	caipirinha.heise.de") by vger.kernel.org with ESMTP id S261303AbTISEq1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 00:46:27 -0400
From: Thorsten Leemhuis <Thorsten_Leemhuis@gmx.de>
Date: Fri, 19 Sep 2003 04:46:17 GMT
Message-ID: <20030919.4461700@thl.ct.heise.de>
Subject: User-Experiences 2.6.0-test5[-mm2]: General, Power-Management and
 tmscsim 
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A0D9u-0000Td-00*8ROrPkjbn9I*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[third attempt to send mail, seems the first two (send more then 18 and 
36 hours ago) didn't arrive at the list]

Hi *,

now that we're some time in the 2.6.0-test stage I thought to disturb
development a bit by testing the new kernel ;-) . I'm mostly a normal
linux "desktop" user with only minor programming experiences in C.

Base Distro was a Red Hat 9 System updated with some security updates. I
also installed the initscripts and modutils rpm packages from
http://people.redhat.com/arjanv/2.5/RPMS.kernel/

Hardware is an Athlon XP 2400+ on an Asus A7V266-E (Via KT266-A).
lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 
10)
00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
00:0c.0 Network controller: Cologne Chip Designs GmbH ISDN network
controller [HFC-PCI] (rev 02)
00:0d.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] (rev 36)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:10.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev a1)

Tested Kernels: 2.6.0-test5 and 2.6.0-test5-mm2 (the later one
especially used for "Power Management" tests)



-----------------------------------
Some general experiences while building and configuring the Kernel


-----------------
- gconfig currently doesn't work so nice:

-- Double-mouse-clicks in the checkboxes sometimes aren't noticed.
Clicking in the “N M Y” Fields in the full view works correct it seems.

-- In the “Split-View” it will throw this segfault when trying to turn
of/on something:
----start
(gconf:2448): Gtk-CRITICAL **: file gtktreestore.c: line 635
(gtk_tree_store_get_value): assertion `iter->stamp == GTK_TREE_STORE
(tree_model)->stamp' failed

(gconf:2448): GLib-GObject-WARNING **: gtype.c:2967: type id `0' is 
invalid

(gconf:2448): GLib-GObject-WARNING **: can't peek value table for type
`' which is not currently referenced
make[1]: *** [gconfig] Segmentation fault
make: *** [gconfig] Error 2
----end


-----------------
- Using xconfig worked without problems. But IMHO some things are a bit
disturbing:

-- Split-View: When do options appear in the left panel ("Support for
USB Gadgets" and "Remove kernel Features")? It seems to me that these
two are not a the right place there.
Another thing: Sometimes Sub-Menus appear in a sub-field in the left
tree-view (like Power Management -> CPU Frequency Scaling) and sometimes
they only have an own sub-menu in the top-right panel (like Networking
-> Ethernet (10 or 100 MBit)?

-- Selecting "Code maturity level options -> Select only drivers
expected to compile cleanly" is helpful but it would be nice if the
config-system would show these drivers in a light grey (or something
like that) and make them not-selectable.


-----------------
- tmscsim

-- The Driver for my Tekram 390 SCSI-Card (tmscsim.o) doesn't compile
currently. It's not an important point for me, maybe this is the right
moment to buy a new cd-rom drive and a new burner. But if someone wants
to update the driver I'm willing to test it.


-----------------
- Building

-- Warning: *not* reproducible: I took Arjans config files as a starting
point and made an "make oldconfig xconfig". After that I made a "make
bzImage modules modules_install" to compile and everything seemed to go
as expected. But I couldn't find arch/i386/boot/bzImage after that. This
Problem is *not* reproducible, but it hit me two times.

-- Once I got this question during a "make bzImage" in a
kernel-source-dir where I compiled a kernel before. I had changed a
Highmem-Option before. Is that on purpose?
----start
[...]
CC kernel/configs.o
mv: Überschreiben von »kernel/configs.o«, über Modus 0644 hinwegsetzen?
----end




-----------------------------------
Starting and using the kernel


-----------------
No special unexpected problems during normal use so far. Time will 
tell...


-----------------
Power Management

- I tried power management as it is one of the things I mostly look
forward to in 2.6. All test were done in single user mode with only the
relevant modules loaded and an *2.6.0-test5-mm2* Kernel as it contains
most of the latest PM-patches I'm aware of.

-- One pitfall I ran into was echoing to /sys/power/state. It only works
when echo has the Option "-n", e.g. "echo -n standby > /sys/power/state
" works, "echo standby > /sys/power/state " doesn't. Maybe a point for
Dave's post-halloween Document?! Or is it my fault?

-- "echo -n standby > /sys/power/state" worked only if I used "sleep 1
&& echo -n standby > /sys/power/state" -- otherwise the Machine only
enters standby for a short moment and will wake up immediately. Screen
also showed PM-output so I think the VGA Card didn't stop.

-- "echo -n mem > /sys/power/state" doesn't work -- it will go to sleep
and the machine wakes up correctly (only once it didn't, don't know why)
and the console will show again as left before. But then immediately 
lines
bash-2.0.5#
bash-2.0.5#
run endlessly through the screen as if someone holds the enter-key
pressed. Pressing any keys doesn't show any effect. I had to tun of the
machine.
Config for Input:

CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_INPUT_JOYSTICK=y
# CONFIG_INPUT_JOYDUMP is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_USB_HIDINPUT=y

-- "echo -n disk > /sys/power/state" (while cat /sys/power/disk state's
"plattform") also doesn't work. The machine will go to sleep and will
resume on the next boot. But immediately after resuming an OOPS is
printed. Is someone (Patrick) any interest in this?
BTW: Is it possible to configure a small configured and fast loading
Kernel that could be used to resume a session that was "frozen" with
another Kernel? That would improve the resume time a bit... The current
scheme seems a lot slower than the one from w**ows.



-----------------------------------
Some other (minor) Points I saw:

- the README refers to 2.5 on many places -- but I think that will
change in time...
- the README refers to lilo on many places -- maybe we should say a word
or two on grub. It's default on many newer distros...
- The line-breaks in the help-texts that are shown in xconfig mostly
seem hardcoded. It that intended?
- The site
http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
state's
----start
- Scheduler is now Hyperthreading SMP aware and will disperse processes
over physically different CPUs, instead of just over logical CPUs.
----end
while
http://www.ussg.iu.edu/hypermail/linux/kernel/0308.3/0862.html
state's it is not in. From my point of view it seem not to be in...


---------
Thorsten Leemhuis

P.S.: I'm not subscribed but I think I'll find all replies through the 
archives




