Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRJNAXF>; Sat, 13 Oct 2001 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRJNAWz>; Sat, 13 Oct 2001 20:22:55 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:2432 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S272620AbRJNAWp>; Sat, 13 Oct 2001 20:22:45 -0400
Message-ID: <3BC8DAF0.3D16A546@welho.com>
Date: Sun, 14 Oct 2001 03:23:12 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCP acking too fast
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It seems that recent (and maybe not so recent) linux kernels have a TCP
problem that causes them to acknowledge almost every segment. While,
strictly speaking, this is not against the spec, any sane TCP only acks
every second segment in steady state. The statistics appended below
illustrate the problem.

Why do I care? Because I'm connected through a cable network with a
severe bandwidth asymmetry; the upstream is rate limited to 256 kbps,
while the downstream can theoretically yield 10 Mbps (assuming a quiet
period). Right now, the excessive ack rate seems to be a limiting factor
on peak performance.

I've already disabled quickacks, replaced the receive MSS estimate with
advertised MSS in the ack sending policy (two places), and removed one
dubious "immediate ack" condition from send_delay_ack(). The annoying
thing is that none of this seem to make any real difference. I must be
missing something huge that's right in front of my nose, but I'm
starting to run out of steam.

Any thoughts on this?

Regards,

	MikaL

Some stats from a unidirectional 6MB transfer:

c->d:                                  d->c:
total packets:          3643           total packets:          4498
ack pkts sent:          3642           ack pkts sent:          4498
pure acks sent:         3640           pure acks sent:            2
unique bytes sent:       108           unique bytes sent:   6161570
actual data pkts:          1           actual data pkts:       4494
actual data bytes:       108           actual data bytes:   6161570
rexmt data pkts:           0           rexmt data pkts:           0
rexmt data bytes:          0           rexmt data bytes:          0
outoforder pkts:           0           outoforder pkts:          10
pushed data pkts:          1           pushed data pkts:       3043
SYN/FIN pkts sent:       1/1           SYN/FIN pkts sent:       1/1
req 1323 ws/ts:          Y/Y           req 1323 ws/ts:          Y/Y
adv wind scale:            0           adv wind scale:            0
req sack:                  Y           req sack:                  Y
sacks sent:               28           sacks sent:                0
mss requested:          1460 bytes     mss requested:          1460
bytes
max segm size:           108 bytes     max segm size:          1448
bytes
min segm size:           108 bytes     min segm size:            92
bytes
avg segm size:           107 bytes     avg segm size:          1371
bytes
max win adv:           63712 bytes     max win adv:           32120
bytes
min win adv:            5840 bytes     min win adv:           32120
bytes
zero win adv:              0 times     zero win adv:              0
times
avg win adv:           63515 bytes     avg win adv:           32120
bytes
initial window:          108 bytes     initial window:          489
bytes
initial window:            1 pkts      initial window:            1 pkts
ttl stream length:       108 bytes     ttl stream length:   6161570
bytes
missed data:               0 bytes     missed data:               0
bytes
truncated data:           46 bytes     truncated data:      5882942
bytes
truncated packets:         1 pkts      truncated packets:      4494 pkts
data xmit time:        0.000 secs      data xmit time:       10.663 secs
idletime max:           98.1 ms        idletime max:           98.0 ms
throughput:               10 Bps       throughput:           572079 Bps
