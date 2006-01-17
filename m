Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWAQXiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWAQXiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWAQXiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:38:02 -0500
Received: from natblindhugh.rzone.de ([81.169.145.175]:61412 "EHLO
	natblindhugh.rzone.de") by vger.kernel.org with ESMTP
	id S932370AbWAQXiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:38:00 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: wireless: recap of current issues (other issues / fake ethernet)
Date: Wed, 18 Jan 2006 00:36:09 +0100
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <43C97693.7000109@pobox.com> <20060115153920.GB1722@shaftnet.org>
In-Reply-To: <20060115153920.GB1722@shaftnet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601180036.10500.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag 15 Januar 2006 16:39 schrieb Stuffed Crust:

> Internally, we're pure 802.11.  One thing to keep in mind that we're not
> going to be bridging/translating non-data traffic to other networks, and
> with that in mind, 802.3<->802.11 translation is trivial, and won't lose
> anything except for a bit of efficiency.  (and then, just to be
> contrary, the prism54 hardware actually requires 802.3 frames!)

prism2 usb is even worse - the urb is build of some control structure, the 
802.11 3 address header, a 802.3 header and the 802.11 data part. Some bits 
in the control structure decide whether the 802.11 or the 802.3 header is 
used to create the frame sent to the air.

Fortunately, a driver should be able to specify it's additional memory need at 
the front of the frame via hard_header_len. Some drivers will need to do some 
ugly memmove()s at the packet begin then.

> (Part of the problem is that 802.11 has a variable-length header - 24,
>  26, 30, or 32 bytes, and each address field means different things
>  depending on which mode we're using..)

.. and it gets even worse as soon as we start encrypting packets. I think we 
should start using the netdev wiki at http://linux-net.osdl.org/ to collect 
information. For this part of the discussion, we need to know what transmit 
frame formats different hardware needs.

I'll ask Stephen Hemminger to put a link for wireless development on the index 
page and will start with frame information for prism2 and other hardware I 
have and understand good enough.

Stefan
