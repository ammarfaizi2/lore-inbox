Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbTIPUrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTIPUrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:47:48 -0400
Received: from rs26s12.datacenter.cha.cantv.net ([200.44.33.31]:39648 "EHLO
	rs26s12.datacenter.cha.cantv.net") by vger.kernel.org with ESMTP
	id S262492AbTIPUrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:47:46 -0400
From: Leo Mauro <lmauro@usb.ve>
Organization: Universidad =?iso-8859-1?q?Sim=F3n?= =?iso-8859-1?q?=20Bol=EDvar?=
To: Vishwas Raman <vishwas@eternal-systems.com>
Subject: Re: Incremental update of TCP Checksum
Date: Tue, 16 Sep 2003 16:47:38 -0400
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <3F3C07E2.3000305@eternal-systems.com> <200309161900.h8GJ0kYe019776@turing-police.cc.vt.edu> <3F67734A.8060804@eternal-systems.com>
In-Reply-To: <3F67734A.8060804@eternal-systems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309161647.38571.lmauro@usb.ve>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 September 2003 04:32 pm, Vishwas Raman wrote:

> As mentioned in RFC1624, I did the following.
> void changePacket(struct sk_buff* skb)
> {
>      struct tcphdr *tcpHdr = skb->h.th;
>
>      // Verifying the tcp checksum works here...
>
>      __u16 oldDoff = tcpHeader->doff;
>      tcpHeader->doff += 1;
>
>      // Formula from RFC1624 is HC' = ~(C + (-m) + m')
>      // where HC  - old checksum in header
>      // C   - one's complement sum of old header
>      // HC' - new checksum in header
>      // C'  - one's complement sum of new header
>      // m   - old value of a 16-bit field
>      // m'  - new value of a 16-bit field
>
>      long cksum = (~(tcpHdr->check))&0xffff;
>      cksum += (__u16)~oldDoff;
                       ^  should be a -

>      cksum += tcpHeader->doff;
>      while (cksum >> 16)
>      {
>          cksum = (cksum & 0xffff) + (cksum >> 16);
>      }
>      tcpHeader->check = ~cksum;
>
>      // Verifying tcp checksum here fails with bad cksum
> }

-- 
Leo Mauro
Network Security
Simon Bolivar University
Caracas, Venezuela

