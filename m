Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286211AbRLTMIS>; Thu, 20 Dec 2001 07:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286218AbRLTMIJ>; Thu, 20 Dec 2001 07:08:09 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:19471 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S286211AbRLTMHz>; Thu, 20 Dec 2001 07:07:55 -0500
Date: Thu, 20 Dec 2001 04:07:50 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011220120750.GA1429@wizard.com>
In-Reply-To: <20011220111249.GA15692@wizard.com> <20011220122325.A710@suse.de> <20011220113654.GA1271@wizard.com> <20011220123904.B710@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20011220123904.B710@suse.de>
User-Agent: Mutt/1.3.23.2i
X-Operating-System: Linux/2.5.1-dj3 (i686)
X-uptime: 3:47am  up 30 min,  2 users,  load average: 0.00, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-PGP-Keys: see http://www.omnilinx.net/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20, 2001 at 12:39:04PM +0100, Jens Axboe wrote:
> 
> Great so it could be either, you're really not giving any new
> information here :-)
> 
> Please tell me what /dev/* is opened by the cd player program and please
> include the kernel message as asked, thanks.
> 

        No problem. The device is /dev/hdc, set to 
/dev/ide/host0/bus1/target0/lun0/cd with devfs. I just reproduced the problem. 
I have a hefty list of modules loaded (including ALSA). See attached for that.
In the messages file, I've taken it from the initial time I saw the problem, 
through the reboot, up to reproducing it. I did just remember that I'm running 
devfsd-1.3.19, so I might be getting it from not upgrading. I'll do that 
really quick, and see if I can reproduce it another time.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Description: output of lsmod
Content-Disposition: attachment; filename=LSM

Module                  Size  Used by    Tainted: P  
snd-pcm-oss            20632   0 (autoclean) (unused)
snd-pcm-plugin         15568   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           5504   1 (autoclean) [snd-pcm-oss]
snd-card-fm801          2176   1
snd-fm801               5152   0 [snd-card-fm801]
snd-pcm                39488   0 [snd-pcm-oss snd-pcm-plugin snd-fm801]
snd-ac97-codec         27072   0 [snd-fm801]
snd-mixer              34696   0 [snd-mixer-oss snd-ac97-codec]
snd-opl3                6080   0 [snd-card-fm801]
snd-timer              11776   0 [snd-pcm snd-opl3]
snd-hwdep               4672   0 [snd-opl3]
snd-mpu401-uart         3728   0 [snd-card-fm801]
snd-rawmidi            12544   0 [snd-mpu401-uart]
snd-seq-device          4492   0 [snd-rawmidi]
snd                    45792   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-card-fm801 snd-fm801 snd-pcm snd-ac97-codec snd-mixer snd-opl3 snd-timer snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3972   0 [snd]
ppp_deflate            40064   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6688   1 (autoclean)
ppp_generic            15272   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    5088   1 (autoclean) [ppp_generic]
serial                 45728   1 (autoclean)
isa-pnp                29224   0 (autoclean) [serial]
ide-cd                 26816   1 (autoclean)
sr_mod                 13524   0 (autoclean) (unused)
cdrom                  29344   0 (autoclean) [ide-cd sr_mod]
scsi_mod               71544   1 (autoclean) [sr_mod]
softdog                 1604   1 (autoclean)
ipt_MASQUERADE          2048   1 (autoclean)
ipt_LOG                 3552 110 (autoclean)
ipt_state                992   3 (autoclean)
ipt_limit               1280   4 (autoclean)
ip_nat_ftp              3904   0 (unused)
ip_conntrack_ftp        3904   0 [ip_nat_ftp]
iptable_filter          2112   0 (unused)
iptable_nat            21524   1 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack           21612   3 [ipt_MASQUERADE ipt_state ip_nat_ftp ip_conntrack_ftp iptable_nat]
ip_tables              13312   8 [ipt_MASQUERADE ipt_LOG ipt_state ipt_limit iptable_filter iptable_nat]
parport_pc             12804   1 (autoclean)
lp                      6240   1 (autoclean)
parport                15008   1 (autoclean) [parport_pc lp]
eepro100               18992   1 (autoclean)
isofs                  26528   0 (autoclean)
inflate_fs             18144   0 (autoclean) [isofs]
reiserfs              160000  12 (autoclean)
unix                   15140  55 (autoclean)

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Description: /var/log/messages
Content-Disposition: attachment; filename=MESS

Dec 20 02:40:57 bellicha sendmail[15427]: fBKAeuJ15426: to="|IFS=' ' && exec /usr/bin/procmail -f- || exit 75 #bradl", ctladdr=<bradl@localhost> (1000/100), delay=00:00:01, xdelay=00:00:00, mailer=prog, pri=139105, dsn=2.0.0, stat=Sent
Dec 20 02:46:12 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 02:46:45 bellicha last message repeated 7 times
Dec 20 02:47:06 bellicha su[15504]: + pts/4 bradl-root 
Dec 20 02:47:07 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 02:48:35 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 02:49:08 bellicha last message repeated 3 times
Dec 20 02:49:11 bellicha su[15568]: + pts/5 bradl-root 
Dec 20 02:50:25 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 02:51:02 bellicha last message repeated 8 times
Dec 20 02:52:02 bellicha last message repeated 7 times
Dec 20 02:52:48 bellicha last message repeated 6 times
Dec 20 02:53:57 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 02:54:54 bellicha last message repeated 3 times
Dec 20 02:56:02 bellicha last message repeated 8 times
Dec 20 02:57:03 bellicha last message repeated 14 times
Dec 20 02:57:23 bellicha last message repeated 5 times
Dec 20 02:57:27 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 02:57:47 bellicha last message repeated 5 times
Dec 20 02:58:40 bellicha last message repeated 4 times
Dec 20 02:59:49 bellicha last message repeated 3 times
Dec 20 03:00:58 bellicha last message repeated 3 times
Dec 20 03:02:03 bellicha last message repeated 9 times
Dec 20 03:02:08 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:03:16 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:04:27 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:04:29 bellicha su[15768]: + pts/3 bradl-root 
Dec 20 03:04:41 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:12:50 bellicha in.identd[15867]: reply to 209.170.216.9: 37059 , 25 : USERID : UNIX :root
Dec 20 03:12:54 bellicha sendmail[15866]: fBKBCn615864: to=linux-kernel@vger.kernel.org, ctladdr=bradl (1000/100), delay=00:00:05, xdelay=00:00:05, mailer=smtp, pri=52124, relay=smtp.wizard.com [209.170.216.9], dsn=2.0.0, stat=Sent (DAA75168 Message accepted for delivery)
Dec 20 03:13:28 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:13:42 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:14:30 bellicha last message repeated 2 times
Dec 20 03:14:56 bellicha init: Switching to runlevel: 6
Dec 20 03:14:59 bellicha exiting on signal 15
Dec 20 03:18:29 bellicha syslogd 1.4.1: restart.
Dec 20 03:18:31 bellicha kernel: klogd 1.4.1, log source = /proc/kmsg started.
Dec 20 03:18:31 bellicha kernel: Inspecting /boot/System.map
Dec 20 03:18:31 bellicha kernel: Loaded 14280 symbols from /boot/System.map.
Dec 20 03:18:31 bellicha kernel: Symbols match kernel version 2.5.1.
Dec 20 03:18:31 bellicha kernel: Loaded 46 symbols from 5 modules.
Dec 20 03:18:31 bellicha kernel: BIOS-provided physical RAM map:
Dec 20 03:18:31 bellicha kernel: Initializing CPU#0
Dec 20 03:18:31 bellicha kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Dec 20 03:18:31 bellicha kernel: CPU: L2 Cache: 256K (64 bytes/line)
Dec 20 03:18:31 bellicha kernel: Intel machine check architecture supported.
Dec 20 03:18:31 bellicha kernel: Intel machine check reporting enabled on CPU#0.
Dec 20 03:18:31 bellicha kernel: Enabling fast FPU save and restore... done.
Dec 20 03:18:31 bellicha kernel: Checking 'hlt' instruction... OK.
Dec 20 03:18:31 bellicha kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Dec 20 03:18:31 bellicha kernel: Applying VIA southbridge workaround.
Dec 20 03:18:31 bellicha kernel: PCI: Disabling Via external APIC routing
Dec 20 03:18:31 bellicha kernel: Linux NET4.0 for Linux 2.4
Dec 20 03:18:31 bellicha kernel: Based upon Swansea University Computer Society NET3.039
Dec 20 03:18:31 bellicha kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
Dec 20 03:18:31 bellicha sshd[98]: Server listening on 0.0.0.0 port 22.
Dec 20 03:18:31 bellicha kernel: Journalled Block Device driver loaded
Dec 20 03:18:31 bellicha kernel: atyfb: using auxiliary register aperture
Dec 20 03:18:32 bellicha kernel: Real Time Clock Driver v1.10e
Dec 20 03:18:32 bellicha kernel: Uniform Multi-Platform E-IDE driver Revision: 6.32
Dec 20 03:18:32 bellicha kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
Dec 20 03:18:32 bellicha kernel: hda: 30015216 sectors (15368 MB) w/512KiB Cache, CHS=1868/255/63, UDMA(66)
Dec 20 03:18:32 bellicha kernel: hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(100)
Dec 20 03:18:32 bellicha kernel: Partition check:
Dec 20 03:18:32 bellicha kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Dec 20 03:18:32 bellicha kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 >
Dec 20 03:18:32 bellicha kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 20 03:18:32 bellicha kernel: IP Protocols: ICMP, UDP, TCP
Dec 20 03:18:32 bellicha kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Dec 20 03:18:32 bellicha kernel: EXT3-fs: write access will be enabled during recovery.
Dec 20 03:18:32 bellicha kernel: kjournald starting.  Commit interval 5 seconds
Dec 20 03:18:32 bellicha kernel: EXT3-fs: recovery complete.
Dec 20 03:18:32 bellicha kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 20 03:18:32 bellicha kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec 20 03:18:32 bellicha kernel: Adding Swap: 1028120k swap-space (priority -1)
Dec 20 03:18:32 bellicha kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Dec 20 03:18:32 bellicha kernel: kjournald starting.  Commit interval 5 seconds
Dec 20 03:18:32 bellicha kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
Dec 20 03:18:32 bellicha kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 20 03:18:32 bellicha kernel: kjournald starting.  Commit interval 5 seconds
Dec 20 03:18:32 bellicha kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Dec 20 03:18:32 bellicha kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 20 03:18:33 bellicha kernel: PCI: Found IRQ 10 for device 00:08.0
Dec 20 03:18:33 bellicha kernel: eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:90:27:10:08:1C, IRQ 10.
Dec 20 03:18:33 bellicha kernel:   Receiver lock-up bug exists -- enabling work-around.
Dec 20 03:18:33 bellicha kernel:   Board assembly 689661-004, Physical connectors present: RJ45
Dec 20 03:18:33 bellicha kernel:   Primary interface chip i82555 PHY #1.
Dec 20 03:18:33 bellicha kernel:   General self-test: passed.
Dec 20 03:18:33 bellicha kernel:   Serial sub-system self-test: passed.
Dec 20 03:18:33 bellicha kernel:   Internal registers self-test: passed.
Dec 20 03:18:33 bellicha kernel:   ROM checksum self-test: passed (0x24c9f043).
Dec 20 03:18:33 bellicha kernel:   Receiver lock-up workaround activated.
Dec 20 03:18:33 bellicha kernel: parport0: PC-style at 0x378 [PCSPP(,...)]
Dec 20 03:18:33 bellicha kernel: parport_pc: Via 686A parallel port: io=0x378
Dec 20 03:18:33 bellicha kernel: lp0: using parport0 (polling).
Dec 20 03:18:33 bellicha kernel: lp0: compatibility mode
Dec 20 03:18:40 bellicha sendmail[116]: starting daemon (8.11.6): queueing@00:05:00
Dec 20 03:18:40 bellicha apmd[120]: Version 3.0final (APM BIOS 1.2, Linux driver 1.15)
Dec 20 03:18:40 bellicha apmd[120]: Charge: * * * (-1% unknown)
Dec 20 03:18:40 bellicha ntpd[132]: ntpd 4.1.71-a Wed Oct 31 01:11:35 PST 2001 (1)
Dec 20 03:18:41 bellicha ntpd[132]: precision = 19 usec
Dec 20 03:18:41 bellicha ntpd[132]: kernel time discipline status 0040
Dec 20 03:18:41 bellicha ntpd[132]: frequency initialized 204.660 from /etc/ntp/drift
Dec 20 03:18:41 bellicha ntpd[132]: frequency initialized 204.660 from /etc/ntp/drift
Dec 20 03:18:42 bellicha kernel: Software Watchdog Timer: 0.05, timer margin: 60 sec
Dec 20 03:20:49 bellicha login[228]: ROOT LOGIN on `tty3' 
Dec 20 03:26:49 bellicha kernel: SCSI subsystem driver Revision: 1.00
Dec 20 03:26:49 bellicha kernel: Uniform CD-ROM driver Revision: 3.12
Dec 20 03:30:07 bellicha kernel: PCI: Found IRQ 11 for device 00:09.0
Dec 20 03:30:07 bellicha kernel: PCI: Sharing IRQ 11 with 00:0c.0
Dec 20 03:31:17 bellicha sshd[1215]: Accepted password for postgres from 192.168.11.1 port 32827 ssh2
Dec 20 03:32:40 bellicha ntpd[132]: time reset -0.485000 s
Dec 20 03:32:40 bellicha ntpd[132]: synchronisation lost
Dec 20 03:34:18 bellicha in.identd[1299]: reply to 127.0.0.1: 32856 , 25 : USERID : UNIX :bradl
Dec 20 03:34:18 bellicha sendmail[1298]: connect from bradl@127.0.0.1
Dec 20 03:34:18 bellicha in.identd[1300]: reply to 127.0.0.1: 32856 , 25 : USERID : UNIX :bradl
Dec 20 03:53:03 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:54:59 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:55:48 bellicha last message repeated 4 times
Dec 20 03:56:35 bellicha in.identd[1536]: reply to 127.0.0.1: 32924 , 25 : USERID : UNIX :bradl
Dec 20 03:56:35 bellicha sendmail[1535]: connect from bradl@127.0.0.1
Dec 20 03:56:35 bellicha in.identd[1537]: reply to 127.0.0.1: 32924 , 25 : USERID : UNIX :bradl
Dec 20 03:56:40 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:57:03 bellicha last message repeated 4 times
Dec 20 03:57:22 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 03:57:28 bellicha last message repeated 2 times
Dec 20 04:01:45 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 04:01:57 bellicha last message repeated 2 times
Dec 20 04:03:42 bellicha kernel: D REQ_BLOCK_PC 
Dec 20 04:04:53 bellicha last message repeated 3 times

--HlL+5n6rz5pIUxbD--
