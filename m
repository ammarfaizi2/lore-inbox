Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267956AbTB1PQe>; Fri, 28 Feb 2003 10:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTB1PQe>; Fri, 28 Feb 2003 10:16:34 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:61824 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S267956AbTB1PQa>;
	Fri, 28 Feb 2003 10:16:30 -0500
Message-ID: <3E5F7FB5.2070104@beam.ltd.uk>
Date: Fri, 28 Feb 2003 15:26:45 +0000
From: Terry Barnaby <terry1@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI Error: Adaptec aic79xx: "Saw underflow" with Seagate ST336607LW
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if anyone can help me with a problem I have with a
Seagate ST336607LW SCSI disk. I am using the following system:

System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
SCSI: Adaptec 7902 onboard dual channel SCSI controller
Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
Disks: 1 off Seagate ST336607LW 36G (320LW)
System: RedHat 7.3 with updates to 18/02/03
Kernel: 2.4.18-24.7.xsmp

This system has been running fine for about a month with the Quantum
Atlas 10K2 SCSI disks. I have just tried to add a Seagate ST336607LW
320LW SCSI disk (faster and bigger) and am now getting problems.
If I start off a disk to disk copy of a large amount of information,
after about 10mins the new SCSI disk will lock up.

I get the kernel message "Saw underflow (16384 of 20480 bytes). Treated 
as error" followed by various SCSI error messages. The SCSI disks LED
remains on and it is impossible to access the SCSI disk.
Reseting the system with the hard reset switch does not clear the
SCSI disk LED and the SCSI disk is subsequently not seen in the Adaptec
BIOS on startup. A power off/on cycle will clear the condition.

A proper 320LW SCSI cable is being used. I have also tried reducing
the data rate for the disk to 160LW to no effect. I notice this
drive is used in "packetized" mode. I have not tried turning this off yet.

I am running the SMP kernel but with Hyperthreading disabled.

I don't know if this is a Linux kernel SCSI driver problem or a SCSI
disk problem on the Seagate ST336607LW.

Any help would be most appreciated ....

The command I am using which generate the error is:

Copy a disk partition with "tar -clf - . | (cd /new; tar -xpf -)

The entries in /var/log/messages include:

Feb 28 11:38:42 beam kernel: kjournald starting.  Commit interval 5 seconds
Feb 28 11:38:42 beam kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on 
sd(8,18), internal journal
Feb 28 11:38:42 beam kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Feb 28 11:39:09 beam kernel: Saw underflow (16384 of 20480 bytes). 
Treated as error
Feb 28 11:39:27 beam login(pam_unix)[1644]: session opened for user root 
by LOGIN(uid=0)
Feb 28 11:39:27 beam  -- root[1644]: ROOT LOGIN ON tty2
Feb 28 11:39:36 beam login(pam_unix)[1645]: session opened for user root 
by LOGIN(uid=0)
Feb 28 11:39:36 beam  -- root[1645]: ROOT LOGIN ON tty3
Feb 28 11:39:40 beam shutdown: shutting down for system reboot
Feb 28 11:40:09 beam kernel: Abort called for cmd f7aeac00
Feb 28 11:40:09 beam kernel: scsi0: Dumping Card State at program 
address 0x6d Mode 0x11
Feb 28 11:40:09 beam kernel: Softc pointer is f7fd0000
Feb 28 11:40:09 beam kernel: IOWNID == 0x7, TOWNID == 0x7, SCSISEQ1 == 0x12
Feb 28 11:40:09 beam kernel: SCSISIGI == 0x0
Feb 28 11:40:09 beam kernel: QFREEZE_COUNT == 0, SEQ_FLAGS2 == 0x1
Feb 28 11:40:09 beam kernel: scsi0: LASTSCB 0xf CURRSCB 0xf NEXTSCB 
0xff80 SEQINTCTL 0x0
Feb 28 11:40:09 beam kernel: SCSISEQ = 0x0
Feb 28 11:40:09 beam kernel: SCB count = 256
Feb 28 11:40:09 beam kernel: Kernel NEXTQSCB = 15
Feb 28 11:40:09 beam kernel: scsi0: LQCTL1 = 0x0
Feb 28 11:40:09 beam kernel: scsi0: WAITING_TID_LIST == 0xff48:0xff0f
Feb 28 11:40:09 beam kernel: scsi0: WAITING_SCB_TAILS: 0(0xff0f) 
1(0xff19) 2(0xff0d) 3(0xff00) 4(0xff00) 5(0xff00) 6(0xff00) 7(0xff00) 
8(0xff00) 9(0xff00) 10(0xff00) 11(0xff00) 12(0xff00) 13(0xff00) 
14(0xff00) 15(0xff00)
Feb 28 11:40:16 beam kernel: qinstart = 15778 qinfifonext = 15778
Feb 28 11:40:16 beam kernel: QINFIFO:
Feb 28 11:40:16 beam init: Switching to runlevel: 6
Feb 28 11:40:16 beam kernel: WAITING_TID_QUEUES:
Feb 28 11:40:16 beam login(pam_unix)[1643]: session closed for user root
Feb 28 11:40:16 beam login(pam_unix)[1644]: session closed for user root
Feb 28 11:40:16 beam login(pam_unix)[1645]: session closed for user root
Feb 28 11:40:16 beam kernel: Pending list:
Feb 28 11:40:16 beam kernel:  25(CTRL 0x60 ID 0x17 N 0xff40 N2 0xfffc SG 
0x3749440a, RSG 0x3f95, KSG 0x3749440a)
Feb 28 11:40:16 beam kernel: ,  52(CTRL 0x60 ID 0x17 N 0xff80 N2 0xfffc 
SG 0x3748900a, RSG 0x7782, KSG 0x3748900a)
Feb 28 11:40:16 beam kernel: ,  49(CTRL 0x60 ID 0x17 N 0xff80 N2 0xfffc 
SG 0x3748b40a, RSG 0x1795, KSG 0x3748b40a)
Feb 28 11:40:16 beam kernel: ,  46(CTRL 0x60 ID 0x17 N 0xff80 N2 0xfffc 
SG 0x3748c80a, RSG 0xff94, KSG 0x3748c80a)
Feb 28 11:40:16 beam kernel: ,  26(CTRL 0x60 ID 0x17 N 0x2e N2 0xfffc SG 
0x3749480a, RSG 0xf794, KSG 0x3749480a)
Feb 28 11:40:16 beam kernel: ,  47(CTRL 0x60 ID 0x17 N 0xff00 N2 0xfffc 
SG 0x3748cc0a, RSG 0xe794, KSG 0x3748cc0a)
Feb 28 11:40:17 beam kernel: ,  17(CTRL 0x60 ID 0x17 N 0xff00 N2 0xfffc 
SG 0x3749740a, RSG 0xbf94, KSG 0x3749740a)
Feb 28 11:40:17 beam kernel:
Feb 28 11:40:17 beam kernel: Kernel Free SCB list: 15 59 56 38 63 43 42 
33 57 62 30 67 66 4 16 37 10 65 29 61 45 32 68 8 22 35 48 27 64 31 34 71 
7 18 24 41 12 60 28 5 21 44 70 51 58 40 54 14 69 36 20 23 53 13 19 9 39 
6 50 11 55 254 255 248 249 250 251 244 245 246 247 240 241 242 243 236 
237 238 239 232 233 234 235 228 229 230 231 224 225 226 227 220 221 222 
223 216 217 218 219 212 213 214 215 208 209 210 211 204 205 206 207 200 
201 202 203 196 197 198 199 192 193 194 195 188 189 190 191 184 185 186 
187 180 181 182 183 176 177 178 179 172 173 174 175 168 169 170 171 164 
165 166 167 160 161 162 163 156 157 158 159 152 153 154 155 148 149 150 
151 144 145 146 147 140 141 142 143 136 137 138 139 132 133 134 135 128 
129 130 131 124 125 126 127 120 121 122 123 116 117 118 119 112 113 114 
115 108 109 110 111 104 105 106 107 100 101 102 103 96 97 98 99 92 93 94 
95 88 89 90 91 84 85 86 87 80 81 82 83 76 77 78 79 72 73 74 75 0 2 1 253 
252
Feb 28 11:40:17 beam kernel: Sequencer Complete DMA-inprog list:
Feb 28 11:40:17 beam kernel: Sequencer Complete list:
Feb 28 11:40:17 beam kernel: Sequencer DMA-Up and Complete list:

Cheers


Terry

--
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                        "Tandems are twice the fun !"

