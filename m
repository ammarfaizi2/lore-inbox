Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWAXTkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWAXTkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWAXTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:40:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:5089 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030373AbWAXTj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:39:59 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC] Controller Area Network (CAN) infrastructure
Date: Tue, 24 Jan 2006 11:39:54 -0800
Organization: OSDL
Message-ID: <20060124113954.0782cb59@dxpl.pdx.osdl.net>
References: <43D61374.8010208@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1138131595 21947 10.8.0.74 (24 Jan 2006 19:39:55 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 24 Jan 2006 19:39:55 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006 11:45:56 +0000
David Vrabel <dvrabel@arcom.com> wrote:

> 
> This is a basic Controller Area Network (CAN) infrastructure.
> 
> CAN is a serial bus network commonly used in automotive and industrial
> control applications.  CAN is exclusively a broadcast network.  Frames
> do not have destination addresses and instead have an ID which
> identifies the frame (generally the ID identifies the type of data in
> the payload of the frame).  Nodes can selectively receive frames based
> on their ID (using mask and match bits).
> 
> Since CAN is a network, CAN controller drivers are implemented as
> network devices with a few extras provided by a CAN class device.  CAN
> frame aren't a whole number of octets so the user recv()'s and send()'s
> 'struct can_frame's which include all the header bits and the 8 octets
> of payload.
> 
> This infrastructure provides the bare minimum required to test CAN
> controllers and is likely missing stuff necessary to actually use it in
> an application.  In particular, the requirement that frames are sent via
> a packet(7) socket could do with being removed but I'm unclear on a
> method that would allow this but wouldn't be a security risk (e.g., a
> mechanism needs to be provided so you can't send/receive raw CAN frames
> on, say, an ethernet device).
> 
> David Vrabel


This implementation looks racey if sysfs files are held open
and device module is removed.
Network device's can not be embedded in other structures.

Also network devices can be renamed, but your code can't handle that.

Read Documentation/networking/netdevices.txt

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
