Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVJLDRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVJLDRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 23:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVJLDRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 23:17:03 -0400
Received: from tus-gate1.raytheon.com ([199.46.245.230]:14413 "EHLO
	tus-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S932084AbVJLDRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 23:17:01 -0400
Message-ID: <434C8010.2060306@raytheon.com>
Date: Tue, 11 Oct 2005 20:16:32 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
Organization: Raytheon Missile Systems -- Tucson, AZ, U.S.
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Keyboard under 2.6.x
References: <434B121A.3000705@raytheon.com> <434B3C82.5080409@m1k.net>	 <5bdc1c8b0510102148l7faae4c7ke0ce4137b175dfcb@mail.gmail.com>	 <200510110042.13325.dtor_core@ameritech.net>	 <434C21F4.7090806@raytheon.com>	 <d120d5000510111353paf02994ta3bd815428f228d2@mail.gmail.com>	 <434C29D9.8000603@raytheon.com> <d120d5000510111434m2951b895p893e93bafef0f8e7@mail.gmail.com>
In-Reply-To: <d120d5000510111434m2951b895p893e93bafef0f8e7@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Well, it died deep in SCSI core so I doubt i8042.noacpi made it do it.

What odd synchronicity.  You are correct: I re-did the boot with that 
kernel (still all modules) and i8042.noacpi, and it booted fine.  Didn't 
fix the problem, though.

> OK, having finally read your .config :) :
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=m
> CONFIG_SERIO_I8042=y
> 
> Please make serio core compiled in instead of being a module and also
> make sure that you load atkbd module (or make it built-in as well).

This, however, *did* fix it, without the addition of any commandline 
parameters.  Hooray!  Here's my diffed .config.

--- ../configs/config-2.6.14-rc3-rt13   2005-10-10 15:03:56.536039048 -0700
+++ .config     2005-10-11 20:04:44.702136016 -0700
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux kernel version: 2.6.14-rc3-rt13
-# Mon Oct 10 15:03:45 2005
+# Tue Oct 11 20:04:44 2005
  #
  CONFIG_X86_64=y
  CONFIG_64BIT=y
@@ -26,7 +26,7 @@
  #
  # General setup
  #
-CONFIG_LOCALVERSION="_local_00"
+CONFIG_LOCALVERSION="_local_02"
  CONFIG_LOCALVERSION_AUTO=y
  CONFIG_SWAP=y
  CONFIG_SYSVIPC=y
@@ -755,7 +755,7 @@
  # Input Device Drivers
  #
  CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=m
+CONFIG_KEYBOARD_ATKBD=y
  # CONFIG_KEYBOARD_SUNKBD is not set
  # CONFIG_KEYBOARD_LKKBD is not set
  CONFIG_KEYBOARD_XTKBD=m
@@ -773,13 +773,13 @@
  #
  # Hardware I/O ports
  #
-CONFIG_SERIO=m
+CONFIG_SERIO=y
  CONFIG_SERIO_I8042=y
  CONFIG_SERIO_SERPORT=m
  CONFIG_SERIO_CT82C710=m
  # CONFIG_SERIO_PARKBD is not set
  CONFIG_SERIO_PCIPS2=m
-CONFIG_SERIO_LIBPS2=m
+CONFIG_SERIO_LIBPS2=y
  CONFIG_SERIO_RAW=m
  # CONFIG_GAMEPORT is not set

I edited the .config by hand, so I guess the LIBPS2 change was some 
dependency discovered by the build system?

Thanks very much.

-- 
Robert Crocombe
rwcrocombe@raytheon.com

