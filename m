Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267177AbRGJXwS>; Tue, 10 Jul 2001 19:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbRGJXwI>; Tue, 10 Jul 2001 19:52:08 -0400
Received: from dsl081-228-056.chi1.dsl.speakeasy.net ([64.81.228.56]:47746
	"EHLO melfina.tsunami-project.org") by vger.kernel.org with ESMTP
	id <S267174AbRGJXv4>; Tue, 10 Jul 2001 19:51:56 -0400
Date: Tue, 10 Jul 2001 18:51
To: "linux-kernel" <linux-kernel@vger.kernel.org>
From: "Mike Crawford" <mike@tuxnami.org>
Subject: Problems with eepro100 and kernel 2.4.6
Message-ID: MDA2OT.TWlrZSBDcmF3Zm9yZA@melfina.tuxnami.org
X-Mailer: Aethera [0.9.0] 17 Jan 2000
X-Aethera-Generated: header (rfc822), reference id idx000000699
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just upgraded from Linux Kernel 2.4.5 to 2.4.6 and I have a small annoying problem with the eepro100 driver.  Every time I put my system into an APM suspend and then resume the machine, the driver stops working and will not let me bring up the interface until I remove the module and reinstall it.  I am using the exact same config as I did in 2.4.5.  Computer is a Compaq Armada M700.  I inserted in this message what I do at the command line and my syslog.  It's not a big issue, just something that is a little annoying.

Mike Crawford

--- Stuff I do at the command line ---

[0] ryo-ohki:~# lsmod
Module                  Size  Used by
eepro100               16464   0  (autoclean)
printer                 5088   0
vfat                    9424   0  (autoclean)
fat                    32224   0  (autoclean) [vfat]
maestro                27104   2  (autoclean)
vmnet                  18912   3
vmmon                  18768   0  (unused)
md                     42112   0  (unused)
uhci                   23200   0  (unused)
usbcore                50064   1  [printer uhci]
[0] ryo-ohki:~# ifconfig eth0 172.18.228.21 netmask 255.255.0.0
SIOCSIFFLAGS: No such device
[0] ryo-ohki:~# ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:6581 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6581 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

vmnet1    Link encap:Ethernet  HWaddr 00:50:56:01:00:00
          inet addr:172.16.203.1  Bcast:172.16.203.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100

[0] ryo-ohki:~# rmmod eepro100
[0] ryo-ohki:~# modprobe eepro100
[0] ryo-ohki:~# ifconfig eth0 172.18.228.21 netmask 255.255.0.0
[0] ryo-ohki:~# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:D0:59:17:9A:69
          inet addr:172.18.228.21  Bcast:172.18.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:11 Base address:0x8000

--- Syslog ---
--- Right after resume ---
Jul 10 06:59:04 ryo-ohki kernel: apm: set display: Interface not engaged
Jul 10 06:59:06 ryo-ohki sysctl: net.ipv4.ip_forward = 0
Jul 10 06:59:06 ryo-ohki sysctl: net.ipv4.conf.all.rp_filter = 1
Jul 10 06:59:06 ryo-ohki sysctl: kernel.sysrq = 0
Jul 10 06:59:06 ryo-ohki network: Setting network parameters:  succeeded
Jul 10 06:59:07 ryo-ohki network: Bringing up interface lo:  succeeded
Jul 10 06:59:07 ryo-ohki ifup: SIOCSIFFLAGS: No such device
Jul 10 06:59:07 ryo-ohki ifup: SIOCADDRT: Network is down
Jul 10 06:59:07 ryo-ohki ifup: SIOCADDRT: Network is unreachable
Jul 10 06:59:08 ryo-ohki network: Bringing up interface eth0:  succeeded
Jul 10 06:59:10 ryo-ohki netfs: Mounting other filesystems:  succeeded
Jul 10 06:59:15 ryo-ohki apmd[607]: Normal Resume after 09:13:52 (90%
unknown) Battery power


Jul 10 07:14:22 ryo-ohki apmd[607]: Now using AC Power
Jul 10 07:14:22 ryo-ohki apmd[607]: Battery: 0.926130 (0:15) 1:22 (76%
unknown)
Jul 10 07:58:02 ryo-ohki su(pam_unix)[5975]: session opened for user root
by mike(uid=500)
Jul 10 07:58:03 ryo-ohki su(pam_unix)[5975]: session closed for user root
Jul 10 07:58:03 ryo-ohki su(pam_unix)[5982]: session opened for user root
by mike(uid=500)
Jul 10 08:06:22 ryo-ohki su(pam_unix)[5982]: session closed for user root
Jul 10 08:35:22 ryo-ohki su(pam_unix)[6242]: session opened for user root 
by mike(uid=500)

--- This is when I started trying to get the interface up, all the syslog
    shows is the mod being loaded ---

Jul 10 08:49:13 ryo-ohki kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Jul 10 08:49:13 ryo-ohki kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jul 10 08:49:13 ryo-ohki kernel: PCI: Found IRQ 11 for device 00:09.0
Jul 10 08:49:13 ryo-ohki kernel: PCI: Sharing IRQ 11 with 00:08.0
Jul 10 08:49:13 ryo-ohki kernel: PCI: Sharing IRQ 11 with 00:09.1
Jul 10 08:49:13 ryo-ohki kernel: eth0: OEM i82557/i82558 10/100 Ethernet,
00:D0:59:17:9A:69, IRQ 11.
Jul 10 08:49:13 ryo-ohki kernel:   Board assembly 98003c-000, Physical
connectors present: RJ45
Jul 10 08:49:13 ryo-ohki kernel:   Primary interface chip i82555 PHY #1.
Jul 10 08:49:13 ryo-ohki kernel:   General self-test: passed.
Jul 10 08:49:13 ryo-ohki kernel:   Serial sub-system self-test: passed.
Jul 10 08:49:13 ryo-ohki kernel:   Internal registers self-test: passed.
Jul 10 08:49:13 ryo-ohki kernel:   ROM checksum self-test: passed
(0xdbd8681d).
Jul 10 08:49:14 ryo-ohki modprobe: modprobe: Can't locate module net-pf-4
Jul 10 08:49:14 ryo-ohki modprobe: modprobe: Can't locate module net-pf-5
Jul 10 08:49:14 ryo-ohki /etc/hotplug/net.agent: register event not
handled

