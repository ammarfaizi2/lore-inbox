Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289853AbSA2T5j>; Tue, 29 Jan 2002 14:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSA2T53>; Tue, 29 Jan 2002 14:57:29 -0500
Received: from [212.9.189.171] ([212.9.189.171]:20353 "HELO deneb.enyo.de")
	by vger.kernel.org with SMTP id <S289853AbSA2T5V>;
	Tue, 29 Jan 2002 14:57:21 -0500
To: linux-kernel@vger.kernel.org, tcpdump-workers@tcpdump.org
Subject: Linux 2.4 and iptables: output includes NAT
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 29 Jan 2002 20:57:19 +0100
Message-ID: <87elk9rkv4.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 2.4.14 with the following iptables rule,

  iptables -t nat -A POSTROUTING -o eth1 -p tcp -d $TARGET -j SNAT --to $NEW

tcpdump version 3.6.2 with libpcap 0.6.2 (Debian GNU/Linux versions)
shows the address on the wire for source addresses of IP packets, but
the destination address is displayed with NAT applied, which is
quit confusing.

Sample output ($ORIG is the local address without NAT).  There is an
aliased interface for $NEW and $ORIG on the host on which tcpdump is
running.  Running tcpdump on the destination host shows that only $NEW
is used.

20:51:12.421778 $NEW.3068 > $TARGET.119: SWE 3333853624:3333853624(0) win 5840 <mss 1460,sackOK,timestamp 70130986 0,nop,wscale 0> (DF)
 [tos 0x10]
20:51:12.465066 $NEW.119 > $ORIG.3068: S 3130380818:3130380818(0) ack 3333853625 win 5792 <mss 1460,sackOK,timestamp 519229759 701309
86,nop,wscale 0> (DF)
20:51:12.465316 $NEW.3068 > $TARGET.119: . ack 3130380819 win 5840 <nop,nop,timestamp 70130991 519229759> (DF) [tos 0x10]
