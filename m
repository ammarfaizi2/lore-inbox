Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280120AbRKIVOf>; Fri, 9 Nov 2001 16:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280133AbRKIVO1>; Fri, 9 Nov 2001 16:14:27 -0500
Received: from bio3d.Colorado.EDU ([128.138.212.7]:21608 "EHLO
	bio3d.Colorado.EDU") by vger.kernel.org with ESMTP
	id <S280120AbRKIVOR>; Fri, 9 Nov 2001 16:14:17 -0500
Subject: X-Windows locks up under concurrent OpenGL (Mesa) and I/O on Athlon
From: Rick Gaudette <Richard.Gaudette@Colorado.EDU>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Nov 2001 14:11:18 -0700
Message-Id: <1005340278.6168.21.camel@wanderer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am submitting this to the kernel mailing list on the hunch that
intense system usage appears to be causing a deadlock that goes away
when AGP usage is disabled.

Problem:
X-Windows locks up under concurrent OpenGL (Mesa) and I/O on Athlon
based motherboards with VIA and AMD chipsets and AGP enabled.  This
problem does NOT occur on Pentium III and Pentium IV based systems with
Intel chipsets.  Nor, if AGP is disabled.

Using either OpenGL sample applications (morph3d, teapot), a solar
system simulation app called ssystem, or our own application IMOD along
with concurrent I/O causes all of our Athlon based systems to hang
within a couple of hours.  We can usually ssh into the hung machine from
another machine and kill the application to bring back X.  Top shows
that the app is either using all of CPU cycles or splitting it evenly
with X.

We have tried many hardware combinations that include both VIA and AMD
chipsets, NVIdia and Matrox video cards, below is a list of
motherboards, video cards and RedHat version for which we have observed
and can reproduce this behavior:

CPUs:
  Athlon 1.0 -1.4 GHz
  Athlon MP 1800+

Motherboards:
  IWILL KK-266
  ABIT KT-7/KT-7a/KT-7A-Raid
  ABIT KG-7-RAID
  Tyan Tiger MP (S2460)

Video cards:
  NVidia Geforce2 MX, Ultra
  NVidia Geforce3 and Geforce3 Titanium 500
  Nvidia drivers: 1.0-1512 and 1.0-1541
  Matrox G400 with 1.3 drivers and XFree86 4.0.3 drivers

OS Versions:
  Red Hat 7.1
  Red Hat 7.1 with kernel upgrades from redhat.com
  Red Hat Roswell
  Red Hat Roswell with ALL upgrades from Red Hat Network
  Red Hat 7.2
  SUSE 7.1

Xfree86 versions 4.0.3 and 4.1.0

Typical system config:
  40 GB IDE (ATA-100) hard disk
  Generic CD-ROM
  Generic network card (100BT)
  1-1.5 GB RAM
  400 watt or greater power supply


Reproduction Procedure:
Run an OpenGL app such ssystem
http://linux.tucows.com/home/preview/9981.html or our IMOD
ftp://bio3d.colorado.edu/pub/graphicstest/obj7.mod.gz .  

To run ssystem:
  tar -xzvf solartest.tar.gz
  cd solartest/ssystem
  ./ssystem
  resize thewindow greater than 800x800

To run IMOD:
  gunzip obj7.mod.gz
  imodv obj7.mod
  You should get a 512x512 window with a model displayed in it.
  Type 5 then 6 on the numeric keypad to start the model spinning.


A simple way to do persistent concurrent I/O:
  Create a file called bigfile larger than the RAM size of the computer
  under tcsh 
    while (1)
    \cp bigfile bigfile1
    end


X will appear to hang within 3 hours on all of our machines. Sometimes
the display will hang until the next mouse or keyboard event.  This  is
a bad sign and is usually a precursor to a full hang-up.

Any help with this problem would be greatly appreciated.

To contact us:

Rick Gaudette
rickg@bio3d.colorado.edu


