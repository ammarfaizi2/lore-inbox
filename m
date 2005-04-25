Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVDYQAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVDYQAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVDYPvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:51:40 -0400
Received: from post.arx.com ([212.25.66.95]:13080 "EHLO post.arx.com")
	by vger.kernel.org with ESMTP id S262659AbVDYPsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:48:50 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Re-routing packets via netfilter (ip_rt_bug)
X-Mimeole: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 25 Apr 2005 18:51:25 +0200
Message-ID: <4151C0F9B9C25C47B3328922A6297A3286CFA5@post.arx.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re-routing packets via netfilter (ip_rt_bug)
Thread-Index: AcVJfvDunbgmfGRxTeGvwV8PVozwmAAN+olg
From: "Yair Itzhaki" <Yair@arx.com>
To: "Patrick McHardy" <kaber@trash.net>
Cc: <linux-kernel@vger.kernel.org>,
       "Netfilter Development Mailinglist" 
	<netfilter-devel@lists.netfilter.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, this does not help.
The failure is now inside "ip_route_output_slow", since the reversed address packet has the source address of the remote machine, and the call to "ip_dev_find" fails to find a device with matching address.

In 2.4 the okfn pointer used to point to "ip_queue_xmit2" which evaluated the new route from scratch. 
It was passed in as the completion function when calling the NF_HOOK chain.
In 2.6 this function is gone (replaced with a reference to "dst_output).

Was removing it a mistake?


-----Original Message-----
From: Patrick McHardy [mailto:kaber@trash.net]
Sent: Monday, April 25, 2005 11:07
To: Yair Itzhaki
Cc: linux-kernel@vger.kernel.org; Netfilter Development Mailinglist
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)


Yair Itzhaki wrote:
> While traversing packets through Netfilter, changing dest address from a foreign to a local address causes the packet to drop (and show up at ip_rt_bug(), along a syslog entry).

Does this patch fix your problem?

