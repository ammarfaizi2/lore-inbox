Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUG3BQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUG3BQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 21:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUG3BQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 21:16:35 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:40591 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264054AbUG3BQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 21:16:32 -0400
Message-ID: <4109A05B.6080900@comcast.net>
Date: Thu, 29 Jul 2004 18:11:55 -0700
From: "Amit D. Chaudhary" <amit_ml@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-list@redhat.com, linux-kernel@vger.kernel.org
Subject: ext3 filesystem corruption with Fedora Core 2, Test 3 with latest
 2.6.6.x kernel
Content-Type: multipart/mixed;
 boundary="------------090406070402030907050905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406070402030907050905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

What happened:
I got filesystem corrupted yesterday when using a Fedora Core 3, Test 3 
with linux kernel 2.6.6-1.435.

The filesystems were /boot and /, particularly files under /bin were 
missing including /bin/sh, /etc/fstab, etc.
kernel images, and other files under /boot had disappeared.

Setup:
The desktop is a HP with a P3 700 with 512 MB RAM, 2 HDD, this happenned 
on ide0 (hda1 and hda3)
The ext3 filesystems had the default journaling mode.

How I ran into it:
I ran vncserver from one of the mingetty (text) consoles, I am still 
trying it out and probably used an incorrect xstartup, attached incase 
it might be useful. Anyways, I did not connect to it, decided to log 
onto another mingetty (CTRL+ALT+2), this took the login name and hung. 
Now the computer went into a hard hang (No Oops, CTRL+ALT+DEL, etc did 
not work.)
On a reboot using grub directly went into Windows (it is a dual boot 
system). Using the rescue disk, I noticed, since it did not mount 
/dev/hda1 as /boot, the old /boot was being effective and suprisingly 
did not have a link entry.

I have reinstalled the OS, so no direct help is needed.
Thought should email it to the list for information and if someone knows 
which release this happens in and is there a fix to it.

Thanks
Amit

--------------090406070402030907050905
Content-Type: text/plain;
 name="xstartup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xstartup"

#!/bin/sh

# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
#Original commands
#xsetroot -solid grey
#vncconfig -iconic &
#xterm -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#twm &

#/usr/bin/gdm-binary  -nodaemon&
/usr/bin/gnome-keyring-daemon&
metacity&
/usr/libexec/gnome-settings-daemon&
xscreensaver -nosplash&
magicdev&
#nautilus&
gnome-panel&
eggcups&

konsole&

/usr/libexec/gnome-vfs-daemon&
dcopserver --nosid --suicide&
/usr/libexec/mapping-daemon&
kded&
klauncher&

--------------090406070402030907050905--
