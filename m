Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284619AbRL3TM1>; Sun, 30 Dec 2001 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284652AbRL3TMS>; Sun, 30 Dec 2001 14:12:18 -0500
Received: from camus.xss.co.at ([194.152.162.19]:30989 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S284619AbRL3TMN>;
	Sun, 30 Dec 2001 14:12:13 -0500
Message-ID: <3C2F66FF.13BD2A19@xss.co.at>
Date: Sun, 30 Dec 2001 20:11:59 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: johninsd@san.rr.com
Subject: lilo, initrd and RAM > 1GB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found a problem booting with lilo 22.1, linux-2.2.20 and
initrd on a machine with more than 1GB of physical memory!

The kernel is configured with CONFIG_2GB set and lilo is
called with the following parameters in /etc/lilo.conf:

[...]
boot = /dev/scsi/host0/bus0/target0/lun0/disc
install = /boot/boot.b
timeout = 100
verbose = 1
prompt
read-only
lba32

image = /boot/vmlinuz
  label = linux
  root = /dev/scsi/host0/bus0/target0/lun0/part3
  initrd = /boot/initrd.gz
  append = "apm=power-off"
  vga = 1
[...]

With this setting, the system boots fine if I have 1GB - epsilon
of RAM installed.

As soon as I put more than 1GB of physical memory into
the machine (for example: 1.5GB), the kernel itself recognizes
the correct amount of memory, but tells me at boot time:

[...]
initrd overwritten (0x80f30000 < 0x8115af08) - disabling it
[...]

It boots fine, if I boot it with "linux mem=960M"...

I tried the same kernel and initrd image with the syslinux
bootloader (version 1.65), and here linux boots fine even
with 1.5GB RAM installed.

I've put a printk statement into init/main.c to get the 
initrd_start address in this case, and it says:

[...]
start_kernel: initrd_start = 0xb7f30000
[...]

I then called lilo again on the 1.5GB system booted with
syslinux, but this didn't help: initrd was still loaded
at address 0x80f30000 and thus got overwritten at boot time...

This behaviour is reproducable on a different system, too.

To me it looks like lilo get's the initrd start address
wrong if there is more than 1GB of RAM in the system.
I haven't found anything in the lilo documentation how to 
solve this problem. 

Is this a lilo or a user bug?
Any idea, anyone?

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
