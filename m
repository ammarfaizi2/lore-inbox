Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTFEL5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFEL5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:57:04 -0400
Received: from camus.xss.co.at ([194.152.162.19]:14601 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264634AbTFEL4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:56:40 -0400
Message-ID: <3EDF3310.7040501@xss.co.at>
Date: Thu, 05 Jun 2003 14:09:52 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Marcelo Tosatti wrote:
> Hallo,
>
> Now I really hope its the last one, all this rc's are making me mad.
>
;-)

So, here's a report on the more positive side...

As I mentioned in some e-mails in the last few days,
I'm currently testing an Asus AP1700-S5 server with
a single Xeon 2.4GHz CPU (FSB533), 512MB RAM and
4x36GB U320SCSI drives (3 of them are assembled as RAID5),
connected via GBit Ethernet to our internal network

root@setup:~ {533} $ lspci
00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)

root@setup:~ {538} $ uptime
  2:05pm  up 18:09, 11 users,  load average: 8.03, 8.45, 8.15

This system is running 2.4.21-rc7 for more than 18 hours
now with the following load:

*) an endless loop to create and remove a large file on the
   RAID5 (ext3 filesystem):
   while true; do time dd if /dev/zero of /var/tmp/largefile bs 1M count 2000 ; rm -f /var/tmp/largefile; done

*) some commands to create additional load:
   cd /
   find . boot/ usr/ tmp/ opt/ var/ -xdev -type f -exec md5sum {} \;

*) NFS copy of a whole 40GB filesystem tree from a Linux NFS server
   to the RAID5 (in a loop)

*) the system is also NFS serving a Linux NFS client, which
   copies the whole server filesystem into /dev/null

*) Additionally, I have the following programs running:
   - Squid (currently used as proxy for our internal web browsers)
   - Apache
   - jedit (with j2sdk-1.4.1_01)
   - StarOffice-5.2
   - Mozilla-1.3.1
   - and lots of additional programs (shell, sshd, emacs), but
     no X server (we are using Linux workstations as X-Terminals)

All in all, there are more than 190 processes at any point in
time in the past 18 hours.
This all produces a permanent load between 7 and 9

vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  4  4 111720   3220  11344 423820   0   0     4 18976 4892  4273   2  68  30
 0  4  3 111720   3204  11352 423728  32   0    80 25216 1460  2095   0  15  85
 0  4  3 111716   3332  11352 423364  76   0    92 25796 1432  1895   2  14  84
 0  4  3 111716   3208  11372 423392  48   0   712 26336 1566  2346   4  14  81
 0  6  3 111716   3208  11412 423196 132   0   420 32820 1774  3113  12  19  69
 0  5  3 111716   3376  11440 422340 704   0   924 24444 1570  2811   3  17  79
 6  2  4 111716   2328  11560 423988 536   0   700 32088 2268  4590   6  73  21
11  3  4 111764  63352  11604 321148  16 308   310 36868 2267  5390  12  46  42

root@setup:~ {537} $ uptime
  1:37pm  up 17:41, 10 users,  load average: 7.94, 7.31, 7.18

Under this circumstances, I made the following observations:

a) The system runs stable for more than 18 hours now

b) It seems to behave quite fine, given the load.
   Response time for all services (web-proxy, web-server)
   is reasonable low (you almost don't notice any delay)

c) Interactive programs (Mozilla, StarOffice, JEdit) are
   still quite usable. There is some delay when opening
   a file in SO (say, about 2-3 seconds), but that's fine

d) Sometimes (but not really reproducable) I noticed a
   _big_ delay when connecting to the server using SSH
   (with "big", I mean 1 minute or so). I eventually
   get a connection, and then can work as normal.

e) The server uses a single, but hyperthreaded CPU.
   Hyperthreading is enabled, and Linux shows both
   logical CPU's:

root@setup:~ {529} $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.169
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.169
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

   But interrupt distribution seems a little bit strange:

root@setup:~ {530} $ cat /proc/interrupts
           CPU0       CPU1
  0:    6318080          0    IO-APIC-edge  timer
  1:        967          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      32477          0    IO-APIC-edge  serial
  5:   55629300          0   IO-APIC-level  eth0
  9:   85639064          0   IO-APIC-level  acpi, ioc0, ioc1
 11:          0          0   IO-APIC-level  usb-ohci
 15:          2          0    IO-APIC-edge  ide1
NMI:          0          0
LOC:    6318529    6318527
ERR:          0
MIS:          0

   With 2.4.21-rc6-ac1, interrupts where counted for both
   logical CPU's. Is this a bug or a feature?

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3zMOxJmyeGcXPhERAu6CAKCILyOUfPyGaKG8pvbl4droch6B+ACbBNB/
Dw1L/tRv2JSrOHA12B8BaHM=
=rWPF
-----END PGP SIGNATURE-----

