Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUAZMSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 07:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUAZMSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 07:18:25 -0500
Received: from mid-1.inet.it ([213.92.5.18]:37054 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S261492AbUAZMSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 07:18:22 -0500
Date: Mon, 26 Jan 2004 13:17:49 +0100
From: Mattia Dongili <dongili@supereva.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Wrong Synaptics Touchpad detection when USB mouse present
Message-ID: <20040126121749.GA1078@inferi.kami.home>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Please Cc me as I'm not subscribed to the list]

I'm experiencing problems with a dual configuration of mice on my
laptop. The sympthoms are:

- if I boot with my Logitech USB mouse plugged in, the Synaptics
  Touchpad is not recognized as such but as "PS/2 Generic Mouse"

- if I boot without USB mouse plugged in or if I simply reload psmouse
  after the boot process, the Synaptics Touchpad is recognized correctly

So it has something to do with the order modules are loaded.

I'm available to test patches and/or send more info.
I have some evidences of those facts:
---> /proc/bus/input/devices

  usb mouse present during boot
    I: Bus=0011 Vendor=0002 Product=0001 Version=0000
    N: Name="PS/2 Generic Mouse"
    P: Phys=isa0060/serio1/input0
    H: Handlers=mouse0 event1 
    B: EV=7 
    B: KEY=70000 0 0 0 0 0 0 0 0 
    B: REL=3 
  
  usb mouse absent during boot
    I: Bus=0011 Vendor=0002 Product=0007 Version=0000
    N: Name="SynPS/2 Synaptics TouchPad"
    P: Phys=isa0060/serio1/input0
    H: Handlers=mouse0 event1 
    B: EV=b 
    B: KEY=6420 0 670000 0 0 0 0 0 0 0 0 
    B: ABS=11000003 

---> dmesg
  
  usb mouse present during boot
    input: PS/2 Generic Mouse on isa0060/serio1

  usb mouse absent during boot or reloading psmouse
    Synaptics Touchpad, model: 1
     Firmware: 5.9
     Sensor: 37
     new absolute packet format
     Touchpad has extended capability bits
     -> multifinger detection
     -> palm detection
    input: SynPS/2 Synaptics TouchPad on isa0060/serio1
   

Linux inferi 2.6.1-2 #2 Mon Jan 26 11:09:55 CET 2004 i686 GNU/Linux
# lsmod
Module                  Size  Used by
[...]
psmouse                18700  0 
usb_storage            25600  0 
scsi_mod               66860  1 usb_storage
hid                    23680  0 
uhci_hcd               30224  0 
usbcore                97884  5 usb_storage,hid,uhci_hcd
radeon                116908  0 
intel_agp              16412  1 
agpgart                26920  2 intel_agp
sonypi                 21052  0 
speedstep_ich           3724  0 
speedstep_lib           2944  1 speedstep_ich
evdev                   7808  1 
pcspkr                  3428  0 
rtc                    10680  0 

bye
-- 
mattia
:wq!
