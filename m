Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUHYPsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUHYPsC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUHYPsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:48:02 -0400
Received: from nene.qinetiq.com ([192.102.214.10]:43735 "HELO nene.qinetiq.com")
	by vger.kernel.org with SMTP id S267259AbUHYPrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:47:41 -0400
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
From: Mark Broadbent <markb@wetlettuce.com>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412CA518.7090109@bio.ifi.lmu.de>
References: <412C5E80.8050603@bio.ifi.lmu.de>
	 <1093439062.25506.12.camel@mbpc.signal.qinetiq.com>
	 <412CA518.7090109@bio.ifi.lmu.de>
Message-Id: <1093448839.25506.57.camel@mbpc.signal.qinetiq.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 16:47:19 +0100
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Wed, 2004-08-25 at 15:41, Frank Steiner wrote:
>
> the output is exactly the same on both machines! On the one machine that
> went through (because it got the IP first) I got the output from dmesg,
> printed it and compared it to the both boot screens. And they are really
> identical.

Stupid question but the MAC addresses on the cards are different aren't
they?  Could you also double check that the xid values differ on both
machines, this is shown on the line:

IP-Config: eth0 UP (able=1, xid=07196018)
                                ^^^^^^^^

Both MAC and xid should be different.

> I didn't see any option (or "extension") that contains the mac address.
> Could that be the problem? Do I have to tell the server that the mac
> address must be in the request-list?

The MAC address is embedded in the chaddr field of the request packets.

This trace does not contain any DHCP NACK responses that were shown in
the DHCP server log (annotated in the log below).  Are you sure it is
behaving exactly as before (i.e. is the DHCP server showing the same
messages being transmitted, including the NACKs)?

The kernel appears to be working correctly in this case.

Thanks
Mark

> IP-Config: Entered.
> IP-Config: eth0 UP (able=1, xid=07196018)
> Sending DHCP requests .DHCP: Sending message type 1
[DHCPDISCOVER]
> tg3: eth0: Link is up at 100 Mbps, full duplex.
> tg3: eth0: Flow control is on for TX and on for RX.
> DHCP: Got message type 2
[DHCPOFFER]
> DHCP: Offered address 141.84.1.168 by server 141.84.1.132
> DHCP/BOOTP: Got extension 53: 02
> DHCP/BOOTP: Got extension 54: 8d 54 01 84
> DHCP/BOOTP: Got extension 51: 00 00 1c 20
> DHCP/BOOTP: Got extension 1: ff ff ff 80
> DHCP/BOOTP: Got extension 3: 8d 54 01 82
> DHCP/BOOTP: Got extension 6: 81 bb d6 87
> DHCP/BOOTP: Got extension 12: 72 61 64 6f
> DHCP/BOOTP: Got extension 15: 62 69 6f 2e 69 66 69 2e 6c 6d 75 2e 64 65
> DHCP/BOOTP: Got extension 17: 2f
> DHCP/BOOTP: Got extension 28: 8d 54 01 ff
> DHCP/BOOTP: Got extension 208: f1 00 74 7e
> DHCP/BOOTP: Got extension 209: 70 78 65 6c 69 6e 75 78 2e 63 66 67 2e 72 61 64 6f
> DHCP/BOOTP: Got extension 210: 68 6f 73 74 73 2f
> ,DHCP: Sending message type 3
[DHCPREQUEST]
> DHCP: Got message type 5
[DHCPACK]
> DHCP/BOOTP: Got extension 53: 05
> DHCP/BOOTP: Got extension 54: 8d 54 01 84
> DHCP/BOOTP: Got extension 51: 00 00 1c 20
> DHCP/BOOTP: Got extension 1: ff ff ff 80
> DHCP/BOOTP: Got extension 3: 8d 54 01 82
> DHCP/BOOTP: Got extension 6: 81 bb d6 87
> DHCP/BOOTP: Got extension 12: 72 61 64 6f
> DHCP/BOOTP: Got extension 15: 62 69 6f 2e 69 66 69 2e 6c 6d 75 2e 64 65
> DHCP/BOOTP: Got extension 17: 2f
> DHCP/BOOTP: Got extension 28: 8d 54 01 ff
> DHCP/BOOTP: Got extension 208: f1 00 74 7e
> DHCP/BOOTP: Got extension 209: 70 78 65 6c 69 6e 75 78 2e 63 66 67 2e 72 61 64 6f
> DHCP/BOOTP: Got extension 210: 68 6f 73 74 73 2f
>   OK
> IP-Config: Got DHCP answer from xxx.xxx.1.132, my address is xxx.xxx.1.168
> IP-Config: Complete:
>        device=eth0, addr=xxx.xxx.1.168, mask=255.255.255.128, gw=xxx.xxx.1.130,
>       host=rado, domain=xxx nis-domain=(none),
>       bootserver=xxx.xxx.1.132, rootserver=xxx.xxx.1.132, rootpath=/

