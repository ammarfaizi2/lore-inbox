Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261940AbREPNTm>; Wed, 16 May 2001 09:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbREPNTc>; Wed, 16 May 2001 09:19:32 -0400
Received: from pD9004B0D.dip.t-dialin.net ([217.0.75.13]:43746 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S261932AbREPNTW>;
	Wed, 16 May 2001 09:19:22 -0400
Message-ID: <3B027E46.5095E8BB@pcsystems.de>
Date: Wed, 16 May 2001 15:19:02 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip.Blundell@pobox.com, tim@cyberelk.demon.co.uk,
        campbell@torque.net, andrea@e-mind.com, linux-parport@torque.net
Subject: parport problems with devfs
Content-Type: multipart/mixed;
 boundary="------------4CDFF581E9F72400F74D57C7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4CDFF581E9F72400F74D57C7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!

I attached the problem occured with parport and devfs.
I don't exactly know where the problem in the parport source
is. If someone has a patch for it, I will test it.

Nico


--------------4CDFF581E9F72400F74D57C7
Content-Type: text/plain; charset=us-ascii;
 name="DEVFS_parport"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DEVFS_parport"


# Loading the parport and parport_pc modules for my parallelport
flapp:/home/user/nico/gpm-1.19.3 # modprobe parport_pc

# is there an entry in /dev ?
flapp:/home/user/nico/gpm-1.19.3 # ls /dev/
.         cdroms   fb      initctl  mem   ptmx    root     usb
..        console  full    input    misc  pts     shm      vc
.devfsd   cpu      gpmctl  kmem     null  pty     tty      vcc
apm_bios  discs    ide     log      port  random  urandom  zero

# What does the kernel message say ?
flapp:/home/user/nico/gpm-1.19.3 # dmesg  | tail -n 14
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 7
0x378: readIntrThreshold is 7
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x49
0x378: ECP settings irq=7 dma=1
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)


# Have a look what lp0 has been before
>From /usr/src/linux/Documentation/ :
  6 char        Parallel printer devices
                  0 = /dev/lp0          Parallel printer on parport0
                  1 = /dev/lp1          Parallel printer on parport1

# make our own device out of /dev
flapp:/ # mknod /lp0 c 6 0

# has anything happened ? No! 
flapp:/ # ls /dev/
.         cdroms   fb      initctl  mem   ptmx    root     usb
..        console  full    input    misc  pts     shm      vc
.devfsd   cpu      gpmctl  kmem     null  pty     tty      vcc
apm_bios  discs    ide     log      port  random  urandom  zero

# Use the printer the easiest way :)
flapp:/ # cat /tmp/* > lp0

# And now... 
flapp:/ # ls /dev/
.         cdroms   fb      initctl  mem   printers  random  urandom  zero
..        console  full    input    misc  ptmx      root    usb
.devfsd   cpu      gpmctl  kmem     null  pts       shm     vc
apm_bios  discs    ide     log      port  pty       tty     vcc

# there is now the entry printers/0.

--------------4CDFF581E9F72400F74D57C7--

