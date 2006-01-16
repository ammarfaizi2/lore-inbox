Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWAPFcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWAPFcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 00:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWAPFcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 00:32:47 -0500
Received: from dhost002-46.dex002.intermedia.net ([64.78.21.140]:1449 "EHLO
	dhost002-46.dex002.intermedia.net") by vger.kernel.org with ESMTP
	id S1751037AbWAPFcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 00:32:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: wireless: recap of current issues (other issues)
Date: Sun, 15 Jan 2006 21:32:45 -0800
Message-ID: <C86180A8C204554D8A3323D8F6B0A29FE29B2E@dhost002-46.dex002.intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: wireless: recap of current issues (other issues)
Thread-Index: AcYZVzGn3YhI3vVeTu60Nx7n5RzdaAAyVELg
From: "Simon Barber" <simon@devicescape.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "John W. Linville" <linville@tuxdriver.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To fake ethernet or not?
------------------------

There is a similar problem in the VLAN code - do you expect the rest of
the network stack to be able to interpret VLAN tagged frames? This was
the original state of the VLAN code - this caused problems since many
apps and modules did not understand VLAN tags (e.g. dhcp).  The VLAN
code was extended to offer both options - the  VLAN virtual device can
be switched to ethernet (non tagged) or tagged. I would suggest that for
compatibility the default for WLAN code be ethernet format frames, and
if somebody wants it to also have an option for 802.11 format frames -
then that be alowed too. If you really want to build a kernel without
ethernet support this is theoretically possible.

The 802.11 format question is related to the 'virtual devices' question.
Most 802.11 implementations split into 2 categories. 1. Those where the
MLME runs on the chip and 2. those where the MLME runs in the host. The
MLME implementations that run on the chip to date that I know about do
not support multiple virtual networks, or other advanced features that
require multiple virtual devices. For these devices frames are typically
exchanged with the hardware in ethernet format, and a single ethernet
format net_device is likely all that will be needed in linux. For
devices that leave the MLME to the host, a much wider range of advanced
features is possible - and here a raw 802.11 net_device and multiple
virtual devices is likely required. A single physical device is required
to implement a qdisc and do priority queueing properly. Multiple virtual
devices to support advanced stack features could be either 802.11 format
or ethernet format depending on the feature and configuration.

Channels/Frequencies
--------------------
For chips with firmware that runs on the chip oftentimes the setting of
channel and power limits is done on the chip, in order to meet the FCC
restriction of making it difficult for the end user to set illegal
values. In cases of chips without firmware these functions may be done
by the stack, or in some cases by a binary code block.

Simon


-----Original Message-----
From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
On Behalf Of Jeff Garzik
Sent: Saturday, January 14, 2006 2:09 PM
To: John W. Linville
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (other issues)

John W. Linville wrote:
> Other Issues
> ============

A big open issue:  should you fake ethernet, or represent 802.11
natively throughout the rest of the net stack?

The former causes various and sundry hacks, and the latter requires that
you touch a bunch of non-802.11 code to make it aware of a new frame
class.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe netdev" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
