Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUACOwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 09:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbUACOwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 09:52:20 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:11393 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263462AbUACOwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 09:52:19 -0500
Date: Sat, 3 Jan 2004 15:51:50 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Just a thought: Kconfig & architecture command
Message-ID: <20040103155150.N30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

while working on some of the watchdog-drivers (that are only valid for certain architectures), I just wondered if we cannot have a simpler indication of the architecture the driver is working on. A possible solution would be to have an extra keyword/command 'architecture' in the Kconfig file. It works like a dependancy, but you have a clear distinction between the real dependancy and the actual hardware/architecture it runs on.

Lett me give a simple example: the sa1100 watchdog driver only works for the sa1100 architecture. In Kconfig this could then look like:
-Kconfig------------------------------------------------------------------
config SA1100_WATCHDOG
        tristate "SA1100 watchdog"
        architecture ARCH_SA1100
        depends on WATCHDOG
        help
          Watchdog timer embedded into SA11x0 chips. This will reboot your
          system when timeout is reached.
          NOTE, that once enabled, this timer cannot be disabled.
                                                                                                 
          To compile this driver as a module, choose M here: the
          module will be called sa1100_wdt.

--------------------------------------------------------------------------
Â
The advantage is that you could source driver directory's more easily in a lott of architectures (without having to copy general pieces in every seperate architecture-dependant Kconfig file, like we do know for sun, sh, ...).

Greetings,
Wim.

