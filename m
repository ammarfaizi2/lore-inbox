Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbRFGAJ7>; Wed, 6 Jun 2001 20:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbRFGAJt>; Wed, 6 Jun 2001 20:09:49 -0400
Received: from ruckus.brouhaha.com ([209.185.79.17]:61352 "HELO brouhaha.com")
	by vger.kernel.org with SMTP id <S262865AbRFGAJh>;
	Wed, 6 Jun 2001 20:09:37 -0400
Date: 7 Jun 2001 00:09:32 -0000
Message-ID: <20010607000932.23918.qmail@brouhaha.com>
From: Eric Smith <eric@brouhaha.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 yenta_socket problems on ThinkPad 240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded my IBM ThinkPad 240 (Type 2609-31U) from Red Hat 7.0 to
Red Hat 7.1, which uses the 2.4.2 kernel and the kernel PCMCIA drivers.

Before the upgrade, all my CardBus and PCMCIA devices were working fine.
Now the yenta_socket module seems to be causing problems, and none of
the cards work.

Before doing 'modprobe yenta_socket', the PCI stuff looks OK:

    % ls -l /proc/bus/pci
    total 0
    dr-xr-xr-x    2 root    root            0 Jun  1 12:52 00
    -r--r--r--    1 root    root            0 Jun  1 12:52 devices

    % ls /proc/bus/pci/00
    00.0  07.0  07.1  07.2  07.3  09.0  0a.0  0b.0  0c.0

and lspci -vvv gives normal-looking output (which I can send if it's
useful).

After the 'modprobe yenta_socket':

    % ls -l /proc/bus/pci
    total 0
    dr-xr-xr-x    2 root    root            0 Jun  1 12:44 00
    dr-xr-xr-x    2 root    root            0 Jun  1 12:44 00
    -r--r--r--    1 root    root            0 Jun  1 12:44 devices

Note the two directories with the same name.

    % ls -l /proc/bus/pci/00
    total 0
    -rw-r--r--    1 root    root            0 Jun  1 12:48 00.0

    % lspci -vvv
    pcilib: Cannot open /proc/bus/pci/00/0c.0

Has anyone seen similar behavior?  Is there any way to force
yenta_socket to assign the cardbus to be bus 01 rather than 00?

Thanks!
Eric Smith
