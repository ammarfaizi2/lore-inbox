Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282905AbRLORr1>; Sat, 15 Dec 2001 12:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282824AbRLORrR>; Sat, 15 Dec 2001 12:47:17 -0500
Received: from [212.159.14.225] ([212.159.14.225]:61827 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S282821AbRLORrG>; Sat, 15 Dec 2001 12:47:06 -0500
Date: Sat, 15 Dec 2001 17:47:04 +0000
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: AIC7850 panic (post 2.4.14)
Message-Id: <20011215174704.661d017e.jpm@it-he.org>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a more blatant problem with SCSI in 2.4.16 that still exists
in 17-rc1.  As an RC it is probably too late to fix for '17, but
whatever.

(This may have been introduced in 2.4.15, I haven't yet checked)

This problem is that th kernel panics on boot as soon as it reaches
the AIC7xxx module, which is loaded at the end (i.e. not built in).

This only happens from cold; when the machine is rebooted it will
initialise the SCSI card successfully.. just never on the first
attempt.  The aic7xxx_old driver works.

Barring transcription errors, here are the details:

SCSI 0:1:0 attempting to queue an abort message
scsi0 dumping card state in data_out phase at SEQADDR 0x0
ACCUM = 0x0  SINDEX=0x0  DINDEX=0x0  ARG_2=0x0
HCNT = 0x0  SCSISEQ=0x0  SBLKCTL=0xc0
DFCNTRL = 0x0  SCSISIGI = 0x0  SXFRCTL0=0x0
SSTAT0 = 0x0  SSTAT1 = 0x8
STACK = 0x0 0x0 0x0 0x0
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 0
QINFIFO entries: 3 2
waiting queue entries = 0:255 1:255 2:255
disconnected queue entries = 0:255 1:255 2:255
QOUTFIFO entries:
sequencer free SCB list: 0 1 2
Pending list: 2
Kernel Free SCB list: 1 2
Untagged Q(1): 2
Dev Q(0:1:0) 0 waiting
qinpos = 0, SCB index = 3
Kernel Panic: Loop 1


-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  doug@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
