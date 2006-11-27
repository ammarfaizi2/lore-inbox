Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933058AbWK0Ue2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbWK0Ue2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbWK0Ue0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:34:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:58075 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933058AbWK0UeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:34:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=La6KxxsWv/m5Z5VP69k5pbmrMitdNpTpO+wftx8RpoizpFxRG5QqRMRJ4IkgekfqNe1zSgE7EC5fPTWY5B70i83/zTjA5y9Bdx3wR+nmsqlMCE76IeuumrjUS2ZvrPZxyl5ph8mqg4oa/zH+Wf458ZLx+UXflt7Neofn2lvl0FI=
Message-ID: <e6babb600611271234u5bb09ef1j1e26d68548770e88@mail.gmail.com>
Date: Mon, 27 Nov 2006 13:34:23 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <456B2DD0.4060500@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20446_18989578.1164659663936"
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
	 <4564C4C7.5060403@s5r6.in-berlin.de>
	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>
	 <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>
	 <456B1C52.4040305@s5r6.in-berlin.de>
	 <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>
	 <456B2DD0.4060500@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_20446_18989578.1164659663936
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Robert Crocombe wrote:
> this is in 2.6.16-rt29 which has proved to be the easiest to provoke.
> I actually couldn't get 2.6.18 to break earlier this morning (few
> hundred resets).

Okay, I got the problem to occur again with 2.6.18.  I will attach my
config in case you wish to scrutinize for any boneheadedness on my
part.

I provoked the problem both with and without the additional read of
IntMaskSet.  Amazingly, I lost host1 on the bus reset that occured
after this sequence:

rmmod ohci1394
rmmod ieee1394
make
make modules_install
modprobe ohci1394

which followed my adding the extra register read line.  Here's the
entirety of the host1 stuff (I did a s/.*host[^1].*//g in vim).  I
snipped some of the self ID chatter.

Nov 27 13:06:35 spanky kernel: ieee1394: nodemgr and IRM functionality disabled
Nov 27 13:06:35 spanky kernel: ohci1394: fw-host1: Remapped memory
spaces reg 0xffffc20000058000
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Soft reset finished
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Iso contexts reg:
000000a8 implemented: 0000000f
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Iso contexts reg:
00000098 implemented: 000000ff
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Receive DMA ctx=0 initialized
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Receive DMA ctx=0 initialized
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Transmit DMA ctx=0
initialized
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: Transmit DMA ctx=1
initialized
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: physUpperBoundOffset=00000000
Nov 27 13:06:36 spanky kernel: ohci1394: fw-host1: OHCI-1394 1.1
(PCI): IRQ=[98]  MMIO=[f9ffe000-f9ffe7ff]  Max Packet=[4096]  IR/IT
contexts=[4/8]
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 1, not root)
Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: SelfID packet
0x807fc494 received
Nov 27 13:06:38 spanky kernel: ohci1394: fw-host1: SelfID packet
0x817fc494 received
Nov 27 13:06:38 spanky kernel: ohci1394: fw-host1: SelfID for this
node is 0x817fc494
Nov 27 13:06:39 spanky kernel: ohci1394: fw-host1: SelfID packet BLAH
...15 more SelfID...
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: SelfID complete
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: PhyReqFilter=0000000000000000
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: IntEventClear
00000000 IntEventSet   04508000 IntMaskSet    838301f3
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 27 13:06:41 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 27 13:06:42 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 1, not root)
Nov 27 13:06:42 spanky kernel: ohci1394: fw-host1: SelfID packet
0x807fc494 received
Nov 27 13:06:42 spanky kernel: ohci1394: fw-host1: SelfID packet
0x817fc496 received
Nov 27 13:06:42 spanky kernel: ohci1394: fw-host1: SelfID for this
node is 0x817fc496
Nov 27 13:06:42 spanky kernel: ohci1394: fw-host1: SelfID packet BLAH
...15 more SelfID...
Nov 27 13:06:43 spanky kernel: ohci1394: fw-host1: SelfID complete
Nov 27 13:06:43 spanky kernel: ohci1394: fw-host1: PhyReqFilter=0000000000000000
Nov 27 13:06:44 spanky kernel: ohci1394: fw-host1: IntEventClear
00000000 IntEventSet   6ffdc33f IntMaskSet    00000000

with the bad IntMaskSet again.

I don't know if the host loss when I didn't have the additional read
is meaningful, but there it is simply:

Nov 27 13:04:39 spanky kernel: ohci1394: fw-host2: SelfID packet
0x823fc4f8 rf8c43f8c
.
.
.
Nov 27 13:06:30 spanky kernel: ohci1394: fw-host2: Soft reset finished

with 2 minutes and ~30 bus resets in between.

Oh, poop.  I didn't mention that I have:

options ieee1394 disable_nodemgr=1
options ohci1394 phys_dma=0

in my /etc/modprobe.conf.  The Linux adapters are functioning as
simulated peripherals to a piece of control hardware that always has a
dest address of 0x0000 0000 0000 on all packets so I needed to get rid
of posted writes and any bickering over bus master.

-- 
Robert Crocombe
rcrocomb@gmail.com

------=_Part_20446_18989578.1164659663936
Content-Type: application/x-bzip2; name=2.6.18_00_config.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ev1c08at
Content-Disposition: attachment; filename="2.6.18_00_config.bz2"

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
nDIFExfxdyRThQkJcIFPcA==
------=_Part_20446_18989578.1164659663936--
