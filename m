Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSGFLnf>; Sat, 6 Jul 2002 07:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317634AbSGFLne>; Sat, 6 Jul 2002 07:43:34 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:20154 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S317633AbSGFLnd>; Sat, 6 Jul 2002 07:43:33 -0400
Message-ID: <3D26D705.9000808@oracle.com>
Date: Sat, 06 Jul 2002 13:39:49 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.25 dead kbd and gpm oops (my config error ?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.25 compiles and boots fine, but keyboard is dead and
  gpm exits with its own oops() function (not a kernel oops).

Jul  6 13:08:33 dolphin kernel: PCI: Probing PCI hardware
Jul  6 13:08:33 dolphin kernel: PCI: Probing PCI hardware (bus 00)
Jul  6 13:08:33 dolphin kernel: Unknown bridge resource 2: assuming transparent
Jul  6 13:08:33 dolphin kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Jul  6 13:08:33 dolphin kernel: __iounmap: bad address d0802400
Jul  6 13:08:33 dolphin kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
[...]
Jul  6 13:08:34 dolphin kernel: PCI: Found IRQ 11 for device 00:03.0
Jul  6 13:08:34 dolphin kernel: PCI: Sharing IRQ 11 with 00:03.1
Jul  6 13:08:34 dolphin kernel: PCI: Sharing IRQ 11 with 00:07.2
Jul  6 13:08:34 dolphin kernel: PCI: Found IRQ 11 for device 00:03.1
Jul  6 13:08:34 dolphin kernel: PCI: Sharing IRQ 11 with 00:03.0
Jul  6 13:08:34 dolphin kernel: PCI: Sharing IRQ 11 with 00:07.2
Jul  6 13:08:34 dolphin kernel: mice: PS/2 mouse device common for all mice
Jul  6 13:08:34 dolphin kernel: i8042.c: Can't get irq 1 for KBD
Jul  6 13:08:34 dolphin kernel: i8042.c: Can't get irq 1 for KBD
Jul  6 13:08:34 dolphin kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  6 13:08:34 dolphin kernel: Yenta IRQ list 06d8, PCI irq11
Jul  6 13:08:34 dolphin keytable: Loading keymap:  succeeded
Jul  6 13:08:34 dolphin kernel: Socket status: 30000020
Jul  6 13:08:34 dolphin kernel: Yenta IRQ list 06d8, PCI irq11
Jul  6 13:08:34 dolphin kernel: Socket status: 30000006
Jul  6 13:08:34 dolphin kernel: input.c: hotplug returned -2
Jul  6 13:08:34 dolphin kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul  6 13:08:34 dolphin kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul  6 13:08:34 dolphin kernel: Advanced Linux Sound Architecture Driver Version 0.9.0rc2 (Wed Jun 19 08:56:25 2002 UTC).
[...]
Jul  6 13:08:44 dolphin sendmail: sendmail startup succeeded
Jul  6 13:08:44 dolphin gpm: gpm startup succeeded
Jul  6 13:08:44 dolphin gpm[778]: oops() invoked from gpm.c(978)
Jul  6 13:08:44 dolphin gpm[778]: /dev/mouse: Device or resource busy
Jul  6 13:08:45 dolphin crond: crond startup succeeded

So, there is the __iounmap message I've never seen, then the irq1
  problem from i8042.c, the hotplug message from input.c and the
  gpm oops(). This latter perhaps I should point to /dev/input/mouse
  (/dev/mouse is a softlink to /dev/psaux) ?

 From .config:

[asuardi@dolphin linux]$ egrep 'INPUT|MOUSE|SERIO|8042' .config | grep -v '^#'
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
CONFIG_SERIO_SERPORT=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y


Box is a Dell Latitude laptop.

Thanks in advance for any "input" ;)

--alessandro

  "my actions make me beautiful / and dignify the flesh"
                 (R.E.M., "Falls to Climb")

