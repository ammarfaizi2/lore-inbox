Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVD0XbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVD0XbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 19:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVD0XbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 19:31:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56284 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262097AbVD0XbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 19:31:23 -0400
In-Reply-To: <d3c101b00bd9573e30aa843e2335439e@mac.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Felix von Leitner <felix-linuxkernel@fefe.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Pekka Savola <pekkas@netcore.fi>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Subject: Re: IPv6 has trouble assigning an interface
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF383E111F.F9F6791E-ON88256FF0.007F9539-88256FF0.00813651@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 27 Apr 2005 16:31:18 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF294 | January 28, 2005) at
 04/27/2005 17:31:19,
	Serialize complete at 04/27/2005 17:31:19
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

netdev-bounce@oss.sgi.com wrote on 04/27/2005 03:57:05 PM:

> On Apr 26, 2005, at 02:10, Felix von Leitner wrote:
> > OK for unicast. But multicast?  I expected link-local multicast
> > to send on _all_ interfaces if I don't specify one.

(I didn't see the article this is quoting-- apparently wasn't CC-ed
to "netdev" as the original was).
        Multicasting doesn't work that way. Multicast group memberships
are per-device (whether or not they are link-local). If you join
the same group address on two different devices, they'll only be the
same group if there are multicast routers on the two links connecting
them in the same multicast routing hierarchy. With a scope broader
than link-local, and a multicast router on that link, the packets
can be forwarded to other links, but they won't be forwarded to
every host on the internet in that group (!), and there are sometimes
good reasons for having different partitions of the same group
within a single organization. So, the same group number on two
different links is not necessarily the same group. It depends
entirely on whether the two groups have common multicast routers
with no policy restricting forwarding for that group between them.
        This is how IPv4 multicasting works, too. You join a group
on a particular device.

                                                                +-DLS

