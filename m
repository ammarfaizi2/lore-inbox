Return-Path: <linux-kernel-owner+w=401wt.eu-S965007AbXATA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbXATA04 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbXATA04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:26:56 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:47094 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871AbXATA0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:26:54 -0500
Message-ID: <011101c73c29$9f6f5db0$84163e05@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Cc: "Allen Parker" <parker@isohunt.com>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
References: <20070117190448.A20184@mail.kroptech.com> <45AEB79B.2010205@intel.com> <00d701c73c1f$b2bb2390$84163e05@kroptech.com> <45B1562C.8070503@intel.com>
Subject: Re: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree e1000 driver (regression)
Date: Fri, 19 Jan 2007 19:26:26 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_010E_01C73BFF.B68AFDD0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_010E_01C73BFF.B68AFDD0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

Auke Kok wrote:
> Adam Kropelin wrote:
>> I haven't been able to test rc5-mm yet because it won't boot on this
>> box. Applying git-e1000 directly to -rc4 or -rc5 results in a number
>> of rejects that I'm not sure how to fix. Some are obvious, but the
>> others I'm unsure of.
>
> that won't work. You either need to start with 2.6.20-rc5 (and pull
> the changes pending merge in netdev-2.6 from Jeff Garzik),

I thought that's what I was doing when I applied git-e1000 to 
2.6.20-rc5, but I guess not.

> or start
> with 2.6.20-rc4-mm1 and manually apply that patch I sent out on
> monday. A different combination of either of these two will not work,
> as they are completely different drivers.

I'll try to work something out.

> can you include `ethtool ethX` output of the link down message and
> `ethtool -d ethX` as well? I'll need to dig up an 82572 and see
> what's up with that, I've not seen that problem before.

ethtool output attached.

> More importantly, I suspect that *again* the issue is caused by
> interrupts not arriving or getting lost.

Smells that way to me, too.

> Can you try running with MSI disabled in your kernel config?

That fixes it! The link comes up and tx/rx works well. I get about 300 
Mbps using default iperf settings with a nearby windows box.

> FYI the driver gives an interrupt to signal to the driver that link
> is up. no interrupt == no link detected. So that explains the symptom.

Yep, makes sense. I've worked with a number of PHYs like that.

--Adam

------=_NextPart_000_010E_01C73BFF.B68AFDD0
Content-Type: application/octet-stream;
	name="ethtool-eth1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ethtool-eth1"

Settings for eth1:=0A=
	Supported ports: [ TP ]=0A=
	Supported link modes:   10baseT/Half 10baseT/Full =0A=
	                        100baseT/Half 100baseT/Full =0A=
	                        1000baseT/Full =0A=
	Supports auto-negotiation: Yes=0A=
	Advertised link modes:  10baseT/Half 10baseT/Full =0A=
	                        100baseT/Half 100baseT/Full =0A=
	                        1000baseT/Full =0A=
	Advertised auto-negotiation: Yes=0A=
	Speed: Unknown! (65535)=0A=
	Duplex: Unknown! (255)=0A=
	Port: Twisted Pair=0A=
	PHYAD: 0=0A=
	Transceiver: internal=0A=
	Auto-negotiation: on=0A=
	Supports Wake-on: umbg=0A=
	Wake-on: d=0A=
	Current message level: 0x00000007 (7)=0A=
	Link detected: no=0A=

------=_NextPart_000_010E_01C73BFF.B68AFDD0
Content-Type: application/octet-stream;
	name="ethtool-d-eth1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ethtool-d-eth1"

MAC Registers=0A=
-------------=0A=
0x00000: CTRL (Device control register)  0x000C0241=0A=
      Duplex:                            full=0A=
      Endian mode (buffers):             little=0A=
      Link reset:                        normal=0A=
      Set link up:                       1=0A=
      Invert Loss-Of-Signal:             no=0A=
      Receive flow control:              disabled=0A=
      Transmit flow control:             disabled=0A=
      VLAN mode:                         disabled=0A=
      Auto speed detect:                 disabled=0A=
      Speed select:                      1000Mb/s=0A=
      Force speed:                       no=0A=
      Force duplex:                      no=0A=
0x00008: STATUS (Device status register) 0x00080383=0A=
      Duplex:                            full=0A=
      Link up:                           link config=0A=
      TBI mode:                          disabled=0A=
      Link speed:                        1000Mb/s=0A=
      Bus type:                          PCI=0A=
      Bus speed:                         33MHz=0A=
      Bus width:                         32-bit=0A=
0x00100: RCTL (Receive control register) 0x00008002=0A=
      Receiver:                          enabled=0A=
      Store bad packets:                 disabled=0A=
      Unicast promiscuous:               disabled=0A=
      Multicast promiscuous:             disabled=0A=
      Long packet:                       disabled=0A=
      Descriptor minimum threshold size: 1/2=0A=
      Broadcast accept mode:             accept=0A=
      VLAN filter:                       disabled=0A=
      Cononical form indicator:          disabled=0A=
      Discard pause frames:              filtered=0A=
      Pass MAC control frames:           don't pass=0A=
      Receive buffer size:               2048=0A=
0x02808: RDLEN (Receive desc length)     0x00001000=0A=
0x02810: RDH   (Receive desc head)       0x00000041=0A=
0x02818: RDT   (Receive desc tail)       0x000000FE=0A=
0x02820: RDTR  (Receive delay timer)     0x00000000=0A=
0x00400: TCTL (Transmit ctrl register)   0x310000F8=0A=
      Transmitter:                       disabled=0A=
      Pad short packets:                 enabled=0A=
      Software XOFF Transmission:        disabled=0A=
      Re-transmit on late collision:     enabled=0A=
0x03808: TDLEN (Transmit desc length)    0x00001000=0A=
0x03810: TDH   (Transmit desc head)      0x00000000=0A=
0x03818: TDT   (Transmit desc tail)      0x00000000=0A=
0x03820: TIDV  (Transmit delay timer)    0x00000008=0A=
PHY type:                                IGP=0A=

------=_NextPart_000_010E_01C73BFF.B68AFDD0--

